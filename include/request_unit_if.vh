/*
	request unit interface file
	takes in dREN, dWEN from Control unit,
	takes in ihit and dhit from Cache, 
	gives out dmemWEN, and dmemREN to Cache
*/

`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH
`include "cpu_types_pkg.vh"

interface request_unit_if;

  // import types
  import cpu_types_pkg::*;
	//Look at file description for input/output
	logic				dWEN, dREN, dhit, ihit, dmemWEN, dmemREN;

	// request unit ports to control unit and cache
	modport ru(
		input		dWEN, dREN, dhit, ihit,
		output	dmemWEN, dmemREN
	);

	modport rutb(
		input		dmemWEN, dmemREN,
		output	dWEN, dREN, dhit, ihit
	);

endinterface

`endif  //REQUEST_UNIT_IF_VH
