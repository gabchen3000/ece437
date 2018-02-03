/*
	program counter interface file
	takes in ihit, next_pc, 
	gives out cur_pc, npc
*/

`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH
`include "cpu_types_pkg.vh"

interface program_counter_if;

  // import types
  import cpu_types_pkg::*;
	//Look at file description for input/output
	word_t	next_pc, cur_pc, npc;
	logic		ihit;

	// request unit ports to control unit and cache
	modport pc(
		input		ihit, next_pc,
		output	cur_pc, npc
	);

	modport pctb(
		input		cur_pc, npc,
		output	ihit, next_pc
	);

endinterface

`endif  //PROGRAM_COUNTER_IF_VH