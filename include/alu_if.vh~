/*
  alu file interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

//all types
`include "cpu_types_pkg.vh"

interface alu_if;
	//import types
	import cpu_types_pkg::*;

	aluop_t		ALUOP;
	word_t		PORT_A, PORT_B, OUT;
	logic			NEG, OVERFLOW, ZERO;	

	//register file ports
	modport alu (
		input		ALUOP, PORT_A, PORT_B,
		output	OUT, NEG, OVERFLOW, ZERO
	);

	//register file tb
	modport tb (
		output	OUT, NEG, OVERFLOW, ZERO,
		input		ALUOP, PORT_A, PORT_B
	);
endinterface

`endif //ALU_IF_VH

