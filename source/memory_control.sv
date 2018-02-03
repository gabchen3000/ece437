/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

//ramWEn will always = dWEN
//ramstore will always = cache store
//dload will always be ramload
assign ccif.ramWEN = ccif.dWEN;
assign ccif.ramstore = ccif.dstore;
//assign ccif.dload = ccif.ramload;
assign ccif.ramREN = ccif.dREN || (ccif.iREN && !ccif.dWEN && !ccif.dREN);
//assign ccif.iload = ccif.ramload;

//ramaddr will either be iaddr or daddr deepending on iren, dren and dwen
always_comb begin
	ccif.ramaddr = 0;
	if (ccif.dWEN || ccif.dREN) begin
		ccif.ramaddr = ccif.daddr;
	end
	else begin
		ccif.ramaddr = ccif.iaddr;
	end
end

//set ramren to 1 if either dREN is asserted or (iREN && !dWEN)
/*always_comb begin
	ccif.ramREN = 0;
	if (ccif.dREN || (ccif.iREN == 1 && ccif.dWEN == 0)) begin
		ccif.ramREN = 1;
	end
	else begin
		ccif.ramREN = 0;
	end
end*/

//deal with dwait and iwait, load data from ram when ramstate = ACCESS

always_comb begin
	ccif.dwait = 1;
	ccif.iwait = 1;
	ccif.dload = 0;
	ccif.iload = 0;
	if (ccif.ramstate == ACCESS) begin
		if (ccif.dWEN) begin
			ccif.dwait = 0;
		end
		else if (ccif.dREN) begin
			ccif.dwait = 0;
			ccif.dload = ccif.ramload;
		end
		else begin
			ccif.iwait = 0;
			ccif.iload = ccif.ramload;
		end
	end
end


endmodule
