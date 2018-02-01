/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
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
	//DUT
	control_unit CU (cuif);
	program_counter PC (CLK, nRST, pcif);
	alu ALU (aif);
	register_file REGF (CLK, nRST, rfif);
	request_unit RU (CLK, nRST, ruif);

	logic					branchAND, branchlogic;
	logic [15:0]	imm, baddr;
	word_t				shamt, ext, branchaddr, jumpaddr;
	logic [25:0]	jaddr;
	

	assign shamt = {27'b0, dpif.imemload[10:6]};
	assign jaddr = dpif.imemload[25:0];
	assign imm = dpif.imemload[15:0];
	assign baddr = dpif.imemload[15:0];
	//Extender output for imm
	assign ext = (cuif.ExtOp) ? ((imm[15]) ? {16'hFFFF, imm} : {16'b0, imm}) : {16'b0, imm};
	//branch address that is passed into PC
	assign branchaddr = pcif.npc + ((baddr[15]) ? {16'hFFFF, baddr} : {16'b0, baddr} << 2);
	//branch logic
	assign branchlogic = (cuif.bne) ? !aif.ZERO : (cuif.beq) ? aif.ZERO : 0;
	assign branchAND = cuif.branch && branchlogic;
	//jump addresss that is passed into PC
	assign jumpaddr = {pcif.npc[31:28], (jaddr << 2)};

	//Registers inputs
	assign rfif.rsel1 = dpif.imemload[25:21];		//rs
	assign rfif.rsel2 = dpif.imemload[20:16];		//rt
	//write select between rt, rd, $31
	assign rfif.wsel = (cuif.RegDest == 0) ? dpif.imemload[20:16] : (cuif.RegDest == 1) ? dpif.imemload[15:11] : 5'b11111;
	//write data between LUI(imm:16b'0), JAL(npc), memtoreg[LW](dmemload), else ALUOUT
	assign rfif.wdat = (cuif.lui) ? {imm, 16'b0} : (cuif.jal) ? pcif.npc : (cuif.MemtoReg) ? dpif.dmemload : aif.OUT;
	assign rfif.WEN = cuif.RegWr;

	//ALU inputs
	assign aif.ALUOP = cuif.ALUOP;
	assign aif.PORT_A = rfif.rdat1;
	assign aif.PORT_B = (cuif.sll || cuif.srl) ? shamt : (cuif.ALUSrc) ? ext : rfif.rdat2;

	//Request unit inputs
	assign ruif.dREN = cuif.dREN;
	assign ruif.dWEN = cuif.dWEN;
	assign ruif.ihit = dpif.ihit;
	assign ruif.dhit = dpif.dhit;

	//Control unit inputs
	assign cuif.imemload = dpif.imemload;
	
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
	assign dpif.dmemstore = rfif.rdat2;
	assign dpif.dmemaddr = aif.OUT;
	assign dpif.imemaddr = pcif.cur_pc;

	//PC inputs
	assign pcif.next_pc = (cuif.jr) ? rfif.rdat1 : (branchAND) ? branchaddr : (cuif.jump || cuif.jal) ? jumpaddr : pcif.npc;
	assign pcif.ihit = dpif.ihit;

endmodule
