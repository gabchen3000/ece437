/*
	forwarding unit interface file
	takes in EXimemload[25:21](rs), EXimemload[20:16](rt), MEMwsel, WBwsel, MEMRegWr, WBRegWr from datapath, 
	gives out fowardselA, forwardselB to datapath in the EX stage
*/

`ifndef FOWARDING_UNIT_IF_VH
`define FOWARDING_UNIT_IF_VH
`include "cpu_types_pkg.vh"

interface forwarding_unit_if;

  // import types
  import cpu_types_pkg::*;
	//Look at file description for input/output
	regbits_t		WBwsel, MEMwsel, rs, rt;
	logic				MEMRegWr, WBRegWr;
	logic [1:0]	fowardselA, forwardselB;

	// request unit ports to control unit and cache
	modport fu(
		input		WBwsel, MEMwsel, rs, rt, MEMRegWr, WBRegWr,
		output	fowardselA, forwardselB
	);

	modport futb(
		input		fowardselA, forwardselB,
		output	WBwsel, MEMwsel, rs, rt, MEMRegWr, WBRegWr
	);

endinterface

`endif  //FORWARDING_UNIT_IF_VH
