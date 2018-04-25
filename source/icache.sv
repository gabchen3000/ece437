/*
  this block is the icache
*/

// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module icache (
  input logic CLK, nRST,
  datapath_cache_if.icache dcif,
  caches_if.icache cif
);
  // import types
  import cpu_types_pkg::*;

	icache_frame [15:0]	frame;//512bits in total, 32 bits per block
	logic [25:0]				tag;
	logic [3:0]					idx;
	logic								hit;
	
	assign tag = dcif.imemaddr[31:6];
	assign idx = dcif.imemaddr[5:2];
	assign cif.iREN = hit ? 0 : dcif.imemREN;
	assign cif.iaddr = dcif.imemaddr;

	always_comb begin
		if (dcif.imemREN) begin
			hit = (tag == frame[idx].tag) && frame[idx].valid;
			dcif.imemload = hit ? frame[idx].data : cif.iload;
			dcif.ihit = hit ? 1 : !cif.iwait; //ihit is when instr read is done == when iwait is 0 (given a cache miss)
		end
		else begin
			hit = 0;
			dcif.imemload = '0;
			dcif.ihit = 0;
		end
	end

	always_ff @(posedge CLK, negedge nRST) begin
		if (nRST == 0) begin
			frame[15:0] <= '0;
		end
		else if (cif.iwait == 0) begin
			frame[idx].tag <= dcif.imemaddr[31:6];
			frame[idx].data <= cif.iload;	//this is from RAM
			frame[idx].valid <= 1;
		end
	end

endmodule
