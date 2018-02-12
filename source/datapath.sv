/*
  Gabriel Chen and Deeptanshu Malik

  Pipeline datapath contains latch between stages, register file, control, hazard,
  muxes, and glue logic for processor
	
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "program_counter_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"
`include "request_unit_if.vh"
//`include "caches_if.vh"
// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;
	
	//interface
	control_unit_if cuif();
	program_counter_if pcif();
	alu_if aif();
	register_file_if rfif();
	request_unit_if ruif();
	if_id_if iiif();
	id_ex_if ieif();
	ex_mem_if emif();
	mem_wb_if mwif();
	hazard_unit_if huif();
	//forwarding_unit_if fuif();
	
	//DUT
	control_unit CU (cuif);
	program_counter PC (CLK, nRST, pcif);
	alu ALU (aif);
	register_file REGF (CLK, nRST, rfif);
	request_unit RU (CLK, nRST, ruif);
	if_id	II (CLK, nRST, iiif);
	id_ex	IE (CLK, nRST, ieif);
	ex_mem EM (CLK, nRST, emif);
	mem_wb MW (CLK, nRST, mwif);
	hazard_unit HU (huif);
	//forwarding_unit FU (fuif);

/* Single cycle signals
	logic					branchAND;//, branchlogic;
	logic [15:0]	imm, baddr;
	word_t				shamt, ext, branchaddr, jumpaddr;
	logic [25:0]	jaddr;
*/
	
//new parameters for pipeline
	//misc signals (actually signals for PC coming out of MEM stage)
	logic [1:0]		PCSrc;
	//signals in IF stage
	word_t				IFnext_pc, IFnpc, IFimemload;
	logic 				IFflushed;
	//signals in ID stage
	r_t 					ID_r_type;
	i_t 					ID_i_type;
	j_t						ID_j_type;
	logic	[1:0]		IDALUSrc, IDRegDest;	//IDALUSrc goes into ID/EX latch, a 2 bit signal (ALUSrc + sll + srl) don't confuse with ALUSrc(1bit)
	word_t				IDnpc, IDimemload, IDrdat1, IDrdat2, IDext, IDshamt;
	logic					IDflushed, IDjump, IDjr, IDbne, IDbeq, IDbranch, IDimemREN, IDhalt, IDdWEN, IDdREN, IDjal, IDlui, IDMemtoReg, IDRegWr;
	aluop_t				IDALUOP;
	//signals in EX stage
	r_t 					EX_r_type;
	i_t 					EX_i_type;
	j_t						EX_j_type;
	word_t				EXnpc, EXimemload, EXrdat1, EXrdat2, EXext, EXshamt, EXALU_OUT, EXbranchaddr;
	logic					EXflushed, EXjump, EXjr, EXbne, EXbeq, EXbranch, EXhalt, EXimemREN, EXdWEN, EXdREN, EXjal, EXlui, EXMemtoReg, EXRegWr, EXZERO;
	logic [1:0]		EXALUSrc, EXRegDest;
	aluop_t				EXALUOP;
	regbits_t			EXwsel;
	//signals in MEM stage
	r_t 					MEM_r_type;
	i_t 					MEM_i_type;
	j_t						MEM_j_type;
	word_t				MEMimemload, MEMbranchaddr, MEMnpc, MEMrdat1, MEMrdat2, MEMALU_OUT, MEMdmemload, MEMjumpaddr;
	logic 				MEMjump, MEMjr, MEMbne, MEMbeq, MEMbranch, MEMhalt, MEMimemREN, MEMdmemWEN, MEMdmemREN, MEMjal, MEMlui, MEMMemtoReg, MEMRegWr, MEMZERO, MEMbranchAND;
	regbits_t			MEMwsel;
	//signals in WB stage
	r_t 					WB_r_type;
	i_t 					WB_i_type;
	j_t						WB_j_type;
	word_t				WBimemload, WBnpc, WBALU_OUT, WBdmemload, WBwdat;
	logic					WBjal, WBlui, WBMemtoReg, WBRegWr, WBdhit, WBihit;
	logic [1:0]		WBwdatsel;
	regbits_t			WBwsel;
	
	//linking the register signals to datapath signals
	//IF signals
	assign iiif.ifid_ip_npc = IFnpc;
	assign iiif.ifid_ip_imemload = IFimemload;
	assign iiif.ifid_ip_ihit = dpif.ihit;
	assign iiif.ifid_ip_dhit = dpif.dhit;
	//assign iiif.ifid_ip_dopause = huif.IFdopause;
	assign iiif.ifid_ip_doflush = IFflushed;
	assign iiif.idex_ip_dopause = huif.IDdopause;	//THIS IS CORRECT SIGNAL


	//ID signals
	assign IDnpc = iiif.ifid_op_npc;
	assign IDimemload = iiif.ifid_op_imemload;
  assign ID_r_type = r_t'(IDimemload);
	assign ID_i_type = i_t'(IDimemload);
	assign ID_j_type = j_t'(IDimemload);

	assign ieif.idex_ip_doflush = IDflushed;
	assign ieif.idex_ip_ihit = dpif.ihit;
	assign ieif.idex_ip_dhit = dpif.dhit;
	assign ieif.idex_ip_npc = IDnpc;
	assign ieif.idex_ip_imemload = IDimemload;
	assign ieif.idex_ip_dREN = IDdREN;
	assign ieif.idex_ip_dWEN = IDdWEN;
	assign ieif.idex_ip_RegWr = IDRegWr;
	assign ieif.idex_ip_MemtoReg = IDMemtoReg;
	assign ieif.idex_ip_jal = IDjal;
	assign ieif.idex_ip_jr = IDjr;
	assign ieif.idex_ip_halt = IDhalt;
	assign ieif.idex_ip_lui = IDlui;
	assign ieif.idex_ip_imemREN = IDimemREN;
	assign ieif.idex_ip_branch = IDbranch;
	assign ieif.idex_ip_jump = IDjump;
	assign ieif.idex_ip_bne = IDbne;
	assign ieif.idex_ip_beq = IDbeq;
	assign ieif.idex_ip_ext = IDext;
	assign ieif.idex_ip_rdat1 = IDrdat1;
	assign ieif.idex_ip_rdat2 = IDrdat2;
	assign ieif.idex_ip_shamt = IDshamt;
	assign ieif.idex_ip_ALUOP = IDALUOP;	
	assign ieif.idex_ip_RegDest = IDRegDest;
	assign ieif.idex_ip_ALUSrc = IDALUSrc;	
	assign ieif.idex_ip_dopause = huif.IDdopause;

	//EX signals
	assign EXimemload = ieif.idex_op_imemload;
	assign EXnpc = ieif.idex_op_npc;
	assign EXdREN = ieif.idex_op_dREN;
	assign EXdWEN = ieif.idex_op_dWEN;
	assign EXRegWr = ieif.idex_op_RegWr;
	assign EXMemtoReg = ieif.idex_op_MemtoReg;
	assign EXjal = ieif.idex_op_jal;
	assign EXjr = ieif.idex_op_jr;
	assign EXhalt = ieif.idex_op_halt;
	assign EXlui = ieif.idex_op_lui;
	assign EXimemREN = ieif.idex_op_imemREN;
	assign EXbranch = ieif.idex_op_branch;
	assign EXjump = ieif.idex_op_jump;
	assign EXbne = ieif.idex_op_bne;
	assign EXbeq = ieif.idex_op_beq;
	assign EXALUOP = ieif.idex_op_ALUOP;	
	assign EXRegDest = ieif.idex_op_RegDest;
	assign EXALUSrc = ieif.idex_op_ALUSrc;	
	assign EXext = ieif.idex_op_ext;
	assign EXrdat1 = ieif.idex_op_rdat1;
	assign EXrdat2 = ieif.idex_op_rdat2;
	assign EXshamt = ieif.idex_op_shamt;
  assign EX_r_type = r_t'(EXimemload);
	assign EX_i_type = i_t'(EXimemload);
	assign EX_j_type = j_t'(EXimemload);

	assign emif.exmem_ip_doflush = EXflushed;
	assign emif.exmem_ip_ihit = dpif.ihit;
	assign emif.exmem_ip_dhit = dpif.dhit;
  assign emif.exmem_ip_npc = EXnpc;
	assign emif.exmem_ip_imemload = EXimemload;
	assign emif.exmem_ip_branchaddr = EXbranchaddr;
	assign emif.exmem_ip_dREN = EXdREN;
	assign emif.exmem_ip_dWEN = EXdWEN;
	assign emif.exmem_ip_RegWr = EXRegWr;
	assign emif.exmem_ip_MemtoReg = EXMemtoReg;
	assign emif.exmem_ip_jal = EXjal;
	assign emif.exmem_ip_jr = EXjr;
	assign emif.exmem_ip_halt = EXhalt;
	assign emif.exmem_ip_lui = EXlui;
	assign emif.exmem_ip_imemREN = EXimemREN;
	assign emif.exmem_ip_branch = EXbranch;
	assign emif.exmem_ip_jump = EXjump;
	assign emif.exmem_ip_bne = EXbne;
	assign emif.exmem_ip_beq = EXbeq;
	assign emif.exmem_ip_rdat1 = EXrdat1;
	assign emif.exmem_ip_rdat2 = EXrdat2;
	assign emif.exmem_ip_ALUOUT = EXALU_OUT;
	assign emif.exmem_ip_ZERO = EXZERO;
  assign emif.exmem_ip_wsel = EXwsel;

	//MEM signals
	assign MEMnpc = emif.exmem_op_npc;
	assign MEMimemload = emif.exmem_op_imemload;
	assign MEMbranchaddr = emif.exmem_op_branchaddr;
	assign MEMdmemREN = emif.exmem_op_dmemREN;
	assign MEMdmemWEN = emif.exmem_op_dmemWEN;
	assign MEMRegWr = emif.exmem_op_RegWr;
	assign MEMMemtoReg = emif.exmem_op_MemtoReg;
	assign MEMjal = emif.exmem_op_jal;
	assign MEMjr = emif.exmem_op_jr;
	assign MEMhalt = emif.exmem_op_halt;
	assign MEMlui = emif.exmem_op_lui;
	assign MEMimemREN = emif.exmem_op_imemREN;
	assign MEMbranch = emif.exmem_op_branch;
	assign MEMjump = emif.exmem_op_jump;
	assign MEMbne = emif.exmem_op_bne;
	assign MEMbeq = emif.exmem_op_beq;
	assign MEMrdat1 = emif.exmem_op_rdat1;
	assign MEMrdat2 = emif.exmem_op_rdat2;
	assign MEMALU_OUT = emif.exmem_op_ALUOUT;
	assign MEMZERO = emif.exmem_op_ZERO;
  assign MEMwsel = emif.exmem_op_wsel;
  assign MEM_r_type = r_t'(MEMimemload);
	assign MEM_i_type = i_t'(MEMimemload);
	assign MEM_j_type = j_t'(MEMimemload);

	assign mwif.memwb_ip_ihit = dpif.ihit;
	assign mwif.memwb_ip_dhit = dpif.dhit;
  assign mwif.memwb_ip_npc = MEMnpc;
	assign mwif.memwb_ip_imemload = MEMimemload;
	assign mwif.memwb_ip_dmemload = MEMdmemload;
	assign mwif.memwb_ip_jal = MEMjal;
	assign mwif.memwb_ip_lui = MEMlui;
	assign mwif.memwb_ip_MemToReg = MEMMemtoReg;
	assign mwif.memwb_ip_RegWr = MEMRegWr;
	assign mwif.memwb_ip_ALUOUT = MEMALU_OUT;
  assign mwif.memwb_ip_wsel = MEMwsel;

	//WB signals
	assign WBihit = mwif.memwb_op_ihit;
	assign WBdhit = mwif.memwb_op_dhit;
  assign WBnpc = mwif.memwb_op_npc;
	assign WBimemload = mwif.memwb_op_imemload;
	assign WBdmemload = mwif.memwb_op_dmemload;
	assign WBjal = mwif.memwb_op_jal;
	assign WBlui = mwif.memwb_op_lui;
	assign WBMemtoReg = mwif.memwb_op_MemToReg;
	assign WBRegWr = mwif.memwb_op_RegWr;
	assign WBALU_OUT = mwif.memwb_op_ALUOUT;
  assign WBwsel = mwif.memwb_op_wsel;
  assign WB_r_type = r_t'(WBimemload);
	assign WB_i_type = i_t'(WBimemload);
	assign WB_j_type = j_t'(WBimemload);

	/*//PC inputs
	assign pcif.next_pc = (cuif.jr) ? rfif.rdat1 : (branchAND) ? branchaddr : (cuif.jump || cuif.jal) ? jumpaddr : pcif.npc;
	assign pcif.ihit = dpif.ihit;

	assign dpif.imemaddr = pcif.cur_pc;
	*/
	//IF stage (PC)

	assign pcif.ihit = dpif.ihit;
	assign IFnpc = pcif.cur_pc + 4;
	assign IFimemload = dpif.imemload;
	assign dpif.imemaddr = pcif.cur_pc;
	//assign pcif.IFdopause = huif.IFdopause;
	assign pcif.IDdopause = huif.IDdopause;
	assign pcif.next_pc = (PCSrc == 0) ? MEMrdat1 : (PCSrc == 1) ? (MEMjumpaddr) : (PCSrc == 2) ? MEMbranchaddr : IFnpc;
	assign pcif.PCSrc = PCSrc;
	assign IFflushed = (PCSrc == 3) ? 0 : 1;

/*
	always_ff @(posedge CLK, negedge nRST) begin
		if (nRST == 0) begin
			IFnext_pc <= 0;
		end		
		else if (huif.IFdopause || huif.IDdopause) begin
			IFnext_pc <= pcif.next_pc;
		end
		else begin
			IFnext_pc <= (PCSrc == 0) ? MEMrdat1 : (PCSrc == 1) ? (MEMjumpaddr) : (PCSrc == 2) ? MEMbranchaddr : IFnpc;
		end
	end
*/
	/*
	//Control unit inputs
	assign cuif.imemload = dpif.imemload;

	//Registers inputs
	assign rfif.rsel1 = dpif.imemload[25:21];		//
	assign rfif.rsel2 = dpif.imemload[20:16];		//rt

	always_comb begin
		if (cuif.RegWr) begin
			if (dpif.imemload[31:26] == LW && dpif.dhit) begin
				rfif.WEN = 1;
			end
			else begin
				rfif.WEN = cuif.RegWr && dpif.ihit;
			end
		end	
		else begin
			rfif.WEN = 0;
		end
	end

	assign imm = dpif.imemload[15:0];
	//Extender output for imm
	assign ext = (cuif.ExtOp) ? ((imm[15]) ? {16'hFFFF, imm} : {16'b0, imm}) : {16'b0, imm};
	assign shamt = {27'b0, dpif.imemload[10:6]};
	*/
	//ID stage (Control Unit, Register Unit)
	assign cuif.imemload = IDimemload;
	assign rfif.rsel1 = IDimemload[25:21];
	assign rfif.rsel2 = IDimemload[20:16];
	assign rfif.wsel = WBwsel;
	assign rfif.wdat = WBwdat;


	assign rfif.WEN = WBRegWr;
/*
	always_comb begin
		if (cuif.RegWr) begin
			if (IDimemload[31:26] == LW && WBdhit) begin
				rfif.WEN = 1;
			end
			else begin
				rfif.WEN = WBRegWr && WBihit;
			end
		end	
		else begin
			rfif.WEN = 0;
		end
	end*/

	assign IDrdat1 = rfif.rdat1;
	assign IDrdat2 = rfif.rdat2;
	assign IDext = (cuif.ExtOp) ? ((IDimemload[15]) ? {16'hFFFF, IDimemload[15:0]} : {16'b0, IDimemload[15:0]}) : {16'b0, IDimemload[15:0]};
	assign IDshamt = {27'b0, IDimemload[10:6]};

	assign IDjump = cuif.jump;
	assign IDjr = cuif.jr;
	assign IDbne = cuif.bne;
	assign IDbeq = cuif.beq;
	assign IDbranch = cuif.branch;
	assign IDimemREN = cuif.imemREN;
	assign IDhalt = cuif.halt;
	assign IDdWEN = cuif.dWEN;
	assign IDdREN = cuif.dREN;
	assign IDjal = cuif.jal;
	assign IDlui = cuif.lui;
	assign IDMemtoReg = cuif.MemtoReg;
	assign IDRegWr = cuif.RegWr;
	assign IDALUOP = cuif.ALUOP;
	assign IDALUSrc = (cuif.sll || cuif.srl) ? 2 : (cuif.ALUSrc) ? 1 : 0;
	assign IDRegDest = cuif.RegDest;
	assign IDflushed = (PCSrc == 3) ? 0 : 1;

/*
	//ALU inputs
	assign aif.ALUOP = cuif.ALUOP;
	assign aif.PORT_A = rfif.rdat1;
	assign aif.PORT_B = (cuif.sll || cuif.srl) ? shamt : (cuif.ALUSrc) ? ext : rfif.rdat2;

	//write select between rt, rd, $31
	assign rfif.wsel = (cuif.RegDest == 0) ? dpif.imemload[20:16] : (cuif.RegDest == 1) ? dpif.imemload[15:11] : 5'b11111;

	assign baddr = dpif.imemload[15:0];
	//branch address that is passed into PC
	assign branchaddr = pcif.npc + ((baddr[15]) ? {16'hFFFF, baddr} : {16'b0, baddr} << 2); //forgot to <<2 for 1ext
*/
	//EX stage (ALU, wsel, branchaddr)
	assign aif.ALUOP = EXALUOP;
	assign aif.PORT_A = EXrdat1;
	assign aif.PORT_B = (EXALUSrc == 0) ? EXrdat2 : (EXALUSrc == 1) ? EXext : EXshamt;
	assign EXALU_OUT = aif.OUT;
	assign EXZERO = aif.ZERO;

	assign EXwsel = (EXRegDest == 0) ? EXimemload[20:16] : (EXRegDest == 1) ? EXimemload[15:11] : 5'b11111;

	assign EXbranchaddr = EXnpc + (EXext << 2);
	assign EXflushed = (PCSrc == 3) ? 0 : 1;
	

/*
	assign jaddr = dpif.imemload[25:0];

	//branch logic
	//assign branchlogic = (cuif.bne) ? !aif.ZERO : (cuif.beq) ? aif.ZERO : 0;
	assign branchAND = cuif.branch && ((cuif.bne) ? !aif.ZERO : (cuif.beq) ? aif.ZERO : 0); //assignbranchAND = cuif.branch && branchlogic
	//jump addresss that is passed into PC
	assign jumpaddr = {pcif.npc[31:28], (jaddr << 2)};

	//Cache inputs
	always_ff @(posedge CLK, negedge nRST) begin	
		if (nRST == 0) begin
  		dpif.halt <= 0;
		end
		else begin
			dpif.halt <= cuif.halt;
		end
	end

	assign dpif.imemREN = cuif.imemREN;
	assign dpif.dmemREN = ruif.dmemREN;
	assign dpif.dmemWEN = ruif.dmemWEN;
	assign dpif.dmemaddr = aif.OUT;
	assign dpif.dmemstore = rfif.rdat2;

	//Request unit inputs
	assign ruif.dREN = cuif.dREN;
	assign ruif.dWEN = cuif.dWEN;
	assign ruif.ihit = dpif.ihit;
	assign ruif.dhit = dpif.dhit;
*/
	//MEM stage (PC addresses, cache inputs, REQUEST UNIT?? - IN EX/MEM REGISTER)
	assign MEMbranchAND = MEMbranch && ((MEMbne) ? !MEMZERO : (MEMbeq) ? MEMZERO : 0);
	assign MEMjumpaddr = {MEMnpc[31:28], (MEMimemload[25:0] << 2)};
	assign PCSrc = (MEMjr) ? 0 : (MEMjal || MEMjump) ? 1 : (MEMbranchAND) ? 2 : 3; 

	always_ff @(posedge CLK, negedge nRST) begin	
		if (nRST == 0) begin
  		dpif.halt <= 0;
		end
		else begin
			dpif.halt <= MEMhalt;
		end
	end

	assign dpif.imemREN = MEMimemREN;
	assign dpif.dmemREN = MEMdmemREN;
	assign dpif.dmemWEN = MEMdmemWEN;
	assign dpif.dmemaddr = MEMALU_OUT;
	assign dpif.dmemstore = MEMrdat2;
	assign MEMdmemload = dpif.dmemload;

/*
	//write data between LUI(imm:16b'0), JAL(npc), memtoreg[LW](dmemload), else ALUOUT
	assign rfif.wdat = (cuif.lui) ? {imm, 16'b0} : (cuif.jal) ? pcif.npc : (cuif.MemtoReg) ? dpif.dmemload : aif.OUT;
*/
	//WB stage (wdatsel and wdat)
	assign WBwdatsel = (WBjal) ? 3 : (WBlui) ? 2 : (WBMemtoReg) ? 0 : 1;
	assign WBwdat = (WBwdatsel == 0) ? WBdmemload : (WBwdatsel == 1) ? WBALU_OUT : (WBwdatsel == 2) ? {WBimemload[15:0], 16'b0} : WBnpc;

	//Hazard unit
	assign huif.EXwsel = EXwsel;
	assign huif.MEMwsel = MEMwsel;
	assign huif.rs = IDimemload[25:21];
	assign huif.rt = IDimemload[20:16];
	assign huif.MEMRegWr = MEMRegWr;
	assign huif.EXRegWr = EXRegWr;
	assign huif.PCSrc = PCSrc;
	assign huif.ihit = dpif.ihit;

endmodule
