/*
	control unit interface file
	takes in imemload (instructions)
	gives out ALUOP, RegDest, ALUSrc, ExtOp, dREN, dWEN, RegWr, MemtoReg, jal, jr(PCSrc?), halt, lui, imemREN, branch, jump, rs, rt, rd, imm, shamt, reg31($31?)
*/

`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH
`include "cpu_types_pkg.vh"

interface control_unit_if;

  // import types
  import cpu_types_pkg::*;
	//Look at file description for input/output
	word_t				imemload;
	aluop_t				ALUOP;	
	logic [1:0]		RegDest;
	//logic [25:0]	jaddr;
	logic 				ALUSrc, ExtOp, dREN, dWEN, RegWr, MemtoReg, jal, jr, halt, lui, imemREN, branch, jump, sll, srl, bne, beq;
	//regbits_t			rs, rt, rd;
	//logic [15:0] 	imm, baddr;
	//word_t				shamt;

	// request unit ports to control unit and cache
	modport cu(
		input		imemload,
		output	ALUOP, RegDest, ALUSrc, ExtOp, dREN, dWEN, RegWr, MemtoReg, jal, jr, halt, lui, imemREN, branch, jump, sll, srl, bne, beq//,jaddr, rs, rt, rd, imm, baddr, shamt
	);

	modport cutb(
		input		ALUOP, RegDest, ALUSrc, ExtOp, dREN, dWEN, RegWr, MemtoReg, jal, jr, halt, lui, imemREN, branch, jump, sll, srl, bne, beq,//jaddr, rs, rt, rd, imm, baddr, shamt,
		output	imemload
	);

endinterface

`endif  //CONTROL_UNIT_IF_VH
