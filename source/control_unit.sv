/*
control unit module
*/

// interface include
`include "control_unit_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module control_unit (
  control_unit_if.cu cuif
);

  // import types
  import cpu_types_pkg::*;

	always_comb begin
		cuif.imemREN = 1;					//iREN should be always asserted
		cuif.ALUOP[3:0] = 0;			//opcode to alu
		//cuif.jaddr = 0;			//jtype address
		cuif.ALUSrc = 0;		//controls rdat2/ext mux 0-rdat2, 1-
		cuif.ExtOp = 0;			//controls signext/ext	(1 for signedext, 0 for zeroext)
		cuif.dREN = 0;			//to RU
		cuif.dWEN = 0;			//to RU
		cuif.RegWr = 0;			//register write enable to Registers
		cuif.MemtoReg = 0;	//controls dmemload/ALUresult mux
		cuif.jal = 0;				//controls rdat2/npc mux for dmemstore
		cuif.jr = 0;				//controls next_pc for jr
		cuif.halt = 0;			//halt to cache
		cuif.lui = 0;				//controls mux for LUI and writedata
		cuif.branch = 0;		//controls next_pc for branch
		cuif.jump = 0;			//controls next_pc for jump/jal
		cuif.sll = 0;				//controls shamt mux
		cuif.srl = 0;				//controls shamt mux
		cuif.beq = 0;				//beq signal for branch logic
		cuif.bne = 0;				//bne signal for branch logic
		cuif.RegDest = 0;
		//cuif.rs = 0;				//Ra to rdat1
		//cuif.rt = 0;				//Rb to rdat1 / Rw to rdat2
		//cuif.rd = 0;				//Rw to rdat2
		//cuif.imm = 0;				//imm for itype
		//cuif.baddr = 0;			//branch address
		//cuif.shamt = 0;			//shift amount for rtype

//send datomic signal to datapath if LL or SC


		/*
		R [opcode 6 | rs 5 | rt 5 | rd 5 | shamt 5 | funct 6] 
		I [opcode 6 | rs 5 | rt 5 | address / immediate 16  ]
		J [opcode 6 | 							addr 25									]

		R-type opcode = 6'b000000,
		I-type opcode -> everything that's not Rtype and Jtype (look at cpu_types_pkg)
		J = 6'b000010, JAL = 6'b000011
		*/

		if (cuif.imemload[31:26] == RTYPE) begin 	//RTYPE == '0
			//cuif.rs = cuif.imemload[25:21];
			//cuif.rt = cuif.imemload[20:16];
			//cuif.rd = cuif.imemload[15:11];
			//cuif.shamt = cuif.imemload[10:6];
			cuif.RegDest = 2'd1;												//RegDest = 1 for selecting rd

			casez (cuif.imemload[5:0])							//imemload[5:0] = funct

				SLL		: begin
								cuif.ALUOP = ALU_SLL;
								cuif.sll = 1;
								cuif.RegWr = 1;
				end

				SRL		: begin
								cuif.ALUOP = ALU_SRL;
								cuif.srl = 1;
								cuif.RegWr = 1;
				end

				JR		: cuif.jr = 1;

				ADD		: begin
								cuif.ALUOP = ALU_ADD;
								cuif.RegWr = 1;
				end

				ADDU	: begin
								cuif.ALUOP = ALU_ADD;
								cuif.RegWr = 1;
				end

				SUB		: begin
								cuif.ALUOP = ALU_SUB;
								cuif.RegWr = 1;
				end

				SUBU	: begin
								cuif.ALUOP = ALU_SUB;
								cuif.RegWr = 1;
				end

				AND		: begin
								cuif.ALUOP = ALU_AND;
								cuif.RegWr = 1;
				end

				OR		: begin
								cuif.ALUOP = ALU_OR;
								cuif.RegWr = 1;
				end

				XOR		: begin
								cuif.ALUOP = ALU_XOR;
								cuif.RegWr = 1;
				end

				NOR	: begin
								cuif.ALUOP = ALU_NOR;
								cuif.RegWr = 1;
				end

				SLT		: begin
								cuif.ALUOP = ALU_SLT;
								cuif.RegWr = 1;
				end

				SLTU	: begin
								cuif.ALUOP = ALU_SLTU;
								cuif.RegWr = 1;
				end
			endcase
		end
		else if (cuif.imemload[31:26] == J) begin	//J = 6'b000010, JAL = 6'b000011
			cuif.jump = 1;
			//cuif.jaddr = cuif.imemload[25:0];
		end
		else if (cuif.imemload[31:26] == JAL) begin
			cuif.jal = 1;
			//cuif.jaddr = cuif.imemload[25:0];
			cuif.RegDest = 2'd2;
			cuif.RegWr = 1;
		end
		else begin		//I-type
			//cuif.rs = cuif.imemload[25:21];
			//cuif.rt = cuif.imemload[20:16];
			//cuif.imm = cuif.imemload[15:0];
			//cuif.baddr = cuif.imemload[15:0];
			cuif.RegDest = 2'd0;												//RegDest = 0 for selecting rt

			casez (cuif.imemload[31:26])
				
				BEQ		:	begin
								cuif.branch = 1;
								cuif.beq = 1;
								cuif.ExtOp = 1;
								cuif.ALUOP = ALU_SUB;
				end

				BNE		:	begin
								cuif.branch = 1;
								cuif.bne = 1;
								cuif.ExtOp = 1;
								cuif.ALUOP = ALU_SUB;
				end

				ADDI	:	begin
								cuif.ALUOP = ALU_ADD;
								cuif.ExtOp = 1;
								cuif.RegWr = 1;
								cuif.ALUSrc = 1;
				end

				ADDIU	:	begin
								cuif.ALUOP = ALU_ADD;
								cuif.ExtOp = 1;
								cuif.RegWr = 1;
								cuif.ALUSrc = 1;
				end

				SLTI	: begin
								cuif.ALUOP = ALU_SUB;
								cuif.ExtOp = 1;
								cuif.RegWr = 1;
								cuif.ALUSrc = 1;
				end

				SLTIU	:	begin
								cuif.ALUOP = ALU_SUB;
								cuif.ExtOp = 1;
								cuif.RegWr = 1;
								cuif.ALUSrc = 1;
				end

				ANDI	: begin
								cuif.ALUOP = ALU_AND;
								cuif.RegWr = 1;
								cuif.ALUSrc = 1;
				end

				ORI		:	begin
								cuif.ALUOP = ALU_OR;
								cuif.RegWr = 1;
								cuif.ALUSrc = 1;
				end

				XORI	: begin
								cuif.ALUOP = ALU_XOR;
								cuif.ALUSrc = 1;
								cuif.RegWr = 1;
				end

				LUI   :	begin
								cuif.RegWr = 1;
								cuif.lui = 1;
				end

				LW		:	begin
								cuif.ALUOP = ALU_ADD;
								cuif.ExtOp = 1;
								cuif.ALUSrc = 1;
								cuif.MemtoReg = 1;
								cuif.RegWr = 1;
								cuif.dREN = 1;
				end

				SW		:	begin
								cuif.ALUOP = ALU_ADD;
								cuif.ExtOp = 1;
								cuif.ALUSrc = 1;
								cuif.dWEN = 1;
				end

				HALT	:	begin
								cuif.halt = 1;
				end

				LL		: begin
								cuif.ALUOP = ALU_ADD;
								cuif.ExtOp = 1;
								cuif.ALUSrc = 1;
								cuif.MemtoReg = 1;
								cuif.RegWr = 1;
								cuif.dREN = 1;
				end

				SC		: begin
								cuif.ALUOP = ALU_ADD;
								cuif.ExtOp = 1;
								cuif.ALUSrc = 1;
								cuif.dWEN = 1;
								cuif.RegWr = 1;
								cuif.MemtoReg = 1; //for writing 1 or 0 into R[rt] from dcache
				end

			endcase
		end
	end

endmodule
