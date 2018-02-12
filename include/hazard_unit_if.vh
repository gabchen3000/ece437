/*
	hazard unit interface file
	takes in IDimemload[25:21](rs), IDimemload[20:16](rt), MEMwsel, EXwsel, MEMRegWr, EXRegWr from datapath, 
	gives out fowardselA, forwardselB to datapath in the EX stage
*/

`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH
`include "cpu_types_pkg.vh"

interface hazard_unit_if;

  // import types
  import cpu_types_pkg::*;
	//Look at file description for input/output
	regbits_t		EXwsel, MEMwsel, rs, rt;
	logic				MEMRegWr, EXRegWr, IFdopause, IDdopause, ihit, dhit;
	logic [1:0]	PCSrc;

	// request unit ports to control unit and cache
	modport hu(
		input		EXwsel, MEMwsel, rs, rt, MEMRegWr, EXRegWr, PCSrc, ihit, dhit,
		output	IFdopause, IDdopause
	);

	modport tb(
		input		IFdopause, IDdopause,
		output	EXwsel, MEMwsel, rs, rt, MEMRegWr, EXRegWr, PCSrc, ihit, dhit
	);

endinterface

`endif  //HAZARD_UNIT_IF_VH
