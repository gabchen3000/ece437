/*
  control unit test bench
*/

// mapped needs this
`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"
// import types
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  control_unit_if cuif ();
  // test program
  test PROG (CLK, cuif);
  // DUT
`ifndef MAPPED
  control_unit DUT(cuif);
`else
  control_unit DUT(
    .\cuif.imemload (cuif.imemload),
    .\cuif.ALUOP (cuif.ALUOP),
    .\cuif.RegDest (cuif.RegDest),
    //.\cuif.jaddr (cuif.jaddr),
    .\cuif.ALUSrc (cuif.ALUSrc),
    .\cuif.ExtOp (cuif.ExtOp),
    .\cuif.dREN (cuif.dREN),
    .\cuif.dWEN (cuif.dWEN),
    .\cuif.RegWr (cuif.RegWr),
    .\cuif.MemtoReg (cuif.MemtoReg),
    .\cuif.jal (cuif.jal),
    .\cuif.jr (cuif.jr),
    .\cuif.halt (cuif.halt),
    .\cuif.lui (cuif.lui),
    .\cuif.imemREN (cuif.imemREN),
    .\cuif.branch (cuif.branch),
    .\cuif.jump (cuif.jump),
    .\cuif.sll (cuif.sll),
    .\cuif.srl (cuif.srl),
    .\cuif.bne (cuif.bne),
    .\cuif.beq (cuif.beq),
    //.\cuif.rs (cuif.rs),
    //.\cuif.rt (cuif.rt),
    //.\cuif.rd (cuif.rd),
    //.\cuif.imm (cuif.imm),
    //.\cuif.baddr (cuif.baddr),
    //.\cuif.shamt (cuif.shamt),
  );
`endif

endmodule

program test(
	input logic CLK,
	control_unit_if cuiftb
);

	parameter PERIOD = 10;

	initial begin
    
		#(PERIOD);
		//nRST = 0;
		//@(posedge CLK);
		//nRST = 1;
		@(posedge CLK);


		//case 1 ADDU rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 100001
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000100001;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_ADD && cuiftb.RegWr == 1 && cuiftb.RegDest == 1) begin
			$display("==Case 1 is correct==");
		end
		else begin
			$display("----------------Case 1 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest);
		end 

		//case 2 ADD rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 100000
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000100000;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_ADD && cuiftb.RegWr == 1 && cuiftb.RegDest == 1) begin
			$display("==Case 2 is correct==");
		end
		else begin
			$display("----------------Case 2 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest);
		end 

		//case 3 AND rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 100100
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000100100;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_AND && cuiftb.RegWr == 1 && cuiftb.RegDest == 1) begin
			$display("==Case 3 is correct==");
		end
		else begin
			$display("----------------Case 3 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest);
		end 

		//case 4 JR rs = 2 opcode = 000000, funct = 001000
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000001000;
		@(posedge CLK);

		if (cuiftb.jr == 1) begin
			$display("==Case 4 is correct==");
		end
		else begin
			$display("----------------Case 4 is wrong, cuiftb.jr = %h", cuiftb.jr);
		end 

		//case 5 NOR rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 100111
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000100111;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_NOR && cuiftb.RegWr == 1 && cuiftb.RegDest == 1) begin
			$display("==Case 5 is correct==");
		end
		else begin
			$display("----------------Case 5 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest);
		end 

		//case 6 OR rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 100101
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000100101;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_OR && cuiftb.RegWr == 1 && cuiftb.RegDest == 1) begin
			$display("==Case 6 is correct==");
		end
		else begin
			$display("----------------Case 6 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest);
		end 

		//case 7 SLT rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 101010
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000101010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_SLT && cuiftb.RegWr == 1 && cuiftb.RegDest == 1) begin
			$display("==Case 7 is correct==");
		end
		else begin
			$display("----------------Case 7 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest);
		end 

		//case 8 SLTU rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 101011
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000101011;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_SLTU && cuiftb.RegWr == 1 && cuiftb.RegDest == 1) begin
			$display("==Case 8 is correct==");
		end
		else begin
			$display("----------------Case 1 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest);
		end 

		//case 9 SLL rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 000000
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000000000;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_SLL && cuiftb.RegWr == 1 && cuiftb.RegDest == 1 && cuiftb.sll == 1) begin
			$display("==Case 9 is correct==");
		end
		else begin
			$display("----------------Case 9 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h, sll = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest, cuiftb.sll);
		end 

		//case 10 SRL rd = 1, rs = 2, opcode = 000000, funct = 000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000000000100000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_SRL && cuiftb.RegWr == 1 && cuiftb.RegDest == 1 && cuiftb.srl == 1) begin
			$display("==Case 10 is correct==");
		end
		else begin
			$display("----------------Case 10 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h, srl = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest, cuiftb.srl);
		end 

		//case 11 SUBU rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 100011
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000100011;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_SUB && cuiftb.RegWr == 1 && cuiftb.RegDest == 1) begin
			$display("==Case 11 is correct==");
		end
		else begin
			$display("----------------Case 11 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest);
		end 

		//case 12 SUB rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 100010
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000100010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_SUB && cuiftb.RegWr == 1 && cuiftb.RegDest == 1) begin
			$display("==Case 12 is correct==");
		end
		else begin
			$display("----------------Case 12 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest);
		end 

		//case 13 XOR rd = 1, rs = 2, rt = 3, opcode = 000000, funct = 100110
		@(posedge CLK);
		cuiftb.imemload = 32'b00000000010000110000100000100110;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_XOR && cuiftb.RegWr == 1 && cuiftb.RegDest == 1) begin
			$display("==Case 13 is correct==");
		end
		else begin
			$display("----------------Case 13 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest);
		end 

		//case 14 ADDIU rs = 2, rt = 3, opcode = 001001, imm = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00100100010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_ADD && cuiftb.RegWr == 1 && cuiftb.RegDest == 0 && cuiftb.ExtOp == 1 && cuiftb.ALUSrc == 1) begin
			$display("==Case 14 is correct==");
		end
		else begin
			$display("----------------Case 14 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h, extOp = %h, ALUSrc = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest, cuiftb.ExtOp, cuiftb.ALUSrc);
		end 

		//case 15 ADDI rs = 2, rt = 3, opcode = 001000, imm = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00100000010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_ADD && cuiftb.RegWr == 1 && cuiftb.RegDest == 0 && cuiftb.ExtOp == 1 && cuiftb.ALUSrc == 1) begin
			$display("==Case 15 is correct==");
		end
		else begin
			$display("----------------Case 15 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h, extOp = %h, ALUSrc = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest, cuiftb.ExtOp, cuiftb.ALUSrc);
		end 

		//case 16 ANDI rs = 2, rt = 3, opcode = 001100, imm = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00110000010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_AND && cuiftb.RegWr == 1 && cuiftb.RegDest == 0 && cuiftb.ExtOp == 0 && cuiftb.ALUSrc == 1) begin
			$display("==Case 16 is correct==");
		end
		else begin
			$display("----------------Case 16 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h, extOp = %h, ALUSrc = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest, cuiftb.ExtOp, cuiftb.ALUSrc);
		end 

		//case 17 BEQ rs = 2, rt = 3, opcode = 000100, addr = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00010000010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_SUB && cuiftb.RegDest == 0 && cuiftb.branch == 1 && cuiftb.beq == 1) begin
			$display("==Case 17 is correct==");
		end
		else begin
			$display("----------------Case 17 is wrong, cuiftb.ALUOP = %h, cuiftb.RegDest = %h, branch = %h, beq = %h", cuiftb.ALUOP, cuiftb.RegDest, cuiftb.branch, cuiftb.beq);
		end 

		//case 18 BNE rs = 2, rt = 3, opcode = 000101, addr = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00010100010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_SUB && cuiftb.RegDest == 0 && cuiftb.branch == 1 && cuiftb.bne == 1) begin
			$display("==Case 18 is correct==");
		end
		else begin
			$display("----------------Case 18 is wrong, cuiftb.ALUOP = %h, cuiftb.RegDest = %h, branch = %h, bne = %h", cuiftb.ALUOP, cuiftb.RegDest, cuiftb.branch, cuiftb.bne);
		end 

		//case 19 LUI rs = 2, rt = 3, opcode = 001111, imm = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00111100010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.RegWr == 1 && cuiftb.RegDest == 0 && cuiftb.lui == 1) begin
			$display("==Case 19 is correct==");
		end
		else begin
			$display("----------------Case 19 is wrong, cuiftb.RegWr = %h, cuiftb.RegDest = %h, lui = %h", cuiftb.RegWr, cuiftb.RegDest, cuiftb.lui);
		end 

		//case 20 LW rs = 2, rt = 3, opcode = 100011, imm = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b10001100010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_ADD && cuiftb.RegWr == 1 && cuiftb.RegDest == 0 && cuiftb.ExtOp == 1 && cuiftb.ALUSrc == 1 && cuiftb.MemtoReg == 1 && cuiftb.dREN == 1) begin
			$display("==Case 20 is correct==");
		end
		else begin
			$display("----------------Case 20 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h, extOp = %h, ALUSrc = %h, memtoreg = %h, dREN = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest, cuiftb.ExtOp, cuiftb.ALUSrc, cuiftb.MemtoReg, cuiftb.dREN);
		end 

		//case 21 ORI rs = 2, rt = 3, opcode = 001101, imm = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00110100010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_OR && cuiftb.RegWr == 1 && cuiftb.RegDest == 0 && cuiftb.ExtOp == 0 && cuiftb.ALUSrc == 1) begin
			$display("==Case 21 is correct==");
		end
		else begin
			$display("----------------Case 21 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h, extOp = %h, ALUSrc = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest, cuiftb.ExtOp, cuiftb.ALUSrc);
		end 

		//case 22 SLTI rs = 2, rt = 3, opcode = 001010, imm = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00101000010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_SUB && cuiftb.RegWr == 1 && cuiftb.RegDest == 0 && cuiftb.ExtOp == 1 && cuiftb.ALUSrc == 1) begin
			$display("==Case 22 is correct==");
		end
		else begin
			$display("----------------Case 22 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h, extOp = %h, ALUSrc = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest, cuiftb.ExtOp, cuiftb.ALUSrc);
		end 

		//case 23 SLTIU rs = 2, rt = 3, opcode = 001011, imm = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00101100010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_SUB && cuiftb.RegWr == 1 && cuiftb.RegDest == 0 && cuiftb.ExtOp == 1 && cuiftb.ALUSrc == 1) begin
			$display("==Case 23 is correct==");
		end
		else begin
			$display("----------------Case 23 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h, extOp = %h, ALUSrc = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest, cuiftb.ExtOp, cuiftb.ALUSrc);
		end 

		//case 24 SW rs = 2, rt = 3, opcode = 101011, imm = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b10101100010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_ADD && cuiftb.ExtOp == 1 && cuiftb.ALUSrc == 1 && cuiftb.dWEN == 1) begin
			$display("==Case 24 is correct==");
		end
		else begin
			$display("----------------Case 24 is wrong, cuiftb.ALUOP = %h, extOp = %h, ALUSrc = %h, dWEN = %h", cuiftb.ALUOP,  cuiftb.ExtOp, cuiftb.ALUSrc, cuiftb.dWEN);
		end 

		//case 25 XORI rs = 2, rt = 3, opcode = 001110, imm = 0000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00111000010000110000000000000010;
		@(posedge CLK);

		if (cuiftb.ALUOP == ALU_XOR && cuiftb.RegWr == 1 && cuiftb.RegDest == 0 && cuiftb.ExtOp == 0 && cuiftb.ALUSrc == 1) begin
			$display("==Case 25 is correct==");
		end
		else begin
			$display("----------------Case 25 is wrong, cuiftb.ALUOP = %h, cuiftb.RegWr = %h, cuiftb.RegDest = %h, extOp = %h, ALUSrc = %h", cuiftb.ALUOP, cuiftb.RegWr, cuiftb.RegDest, cuiftb.ExtOp, cuiftb.ALUSrc);
		end 

		//case 26 J opcode = 000010, addr = 00000000000000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00001000000000000000000000000010;
		@(posedge CLK);

		if (cuiftb.jump == 1) begin
			$display("==Case 26 is correct==");
		end
		else begin
			$display("----------------Case 26 is wrong, cuiftb.jump = %h", cuiftb.jump);
		end 

		//case 27 JAL opcode = 000011, addr = 00000000000000000000000010
		@(posedge CLK);
		cuiftb.imemload = 32'b00001100000000000000000000000010;
		@(posedge CLK);

		if (cuiftb.jal == 1 && cuiftb.RegDest == 2 && cuiftb.RegWr == 1) begin
			$display("==Case 27 is correct==");
		end
		else begin
			$display("----------------Case 27 is wrong, cuiftb.jump = %h, cuiftb.RegDest = %h, cuiftb.RegWr = %h", cuiftb.jump, cuiftb.RegDest, cuiftb.RegWr);
		end 

		//case 28 HALT opcode = 111111
		@(posedge CLK);
		cuiftb.imemload = 32'b11111100000000000000000000000000;
		@(posedge CLK);

		if (cuiftb.halt == 1) begin
			$display("==Case 28 is correct==");
		end
		else begin
			$display("----------------Case 28 is wrong, cuiftb.halt = %h", cuiftb.halt);
		end 

  end

endprogram