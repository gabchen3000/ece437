// mapped needs this
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module icache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
	datapath_cache_if dcif ();
  caches_if cif ();
	
  // test program
  test PROG (CLK, nRST, dcif, cif);
  // DUT
`ifndef MAPPED
  icache DUT(CLK, nRST, dcif, cif);
`endif

endmodule

program test(
	input logic CLK,
	output logic nRST,
	datapath_cache_if.cache dcif,
  caches_if.dcache cif
);

	parameter PERIOD = 10;
	int testcase = 0;
	int hitcount = 0;
	logic [25:0] tag1 	= 26'd10;
	logic [3:0]  idx1 	= 4'd1;

	logic [25:0] tag2 	= 26'd12;
	logic [3:0]  idx2		= 4'd2;
	
	logic [25:0] tag3 	= 26'd13;
	logic [3:0]  idx3 	= 4'd3;

	logic [25:0] tag_junk 	= 26'd69;

	initial begin
		
		//to test:
		// cif.iREN
		// cif.iaddr
		// dcif.imemload
		// dcif.ihit
    
		//inputs
		//	dcif.imemaddr
		//	dcif.imemREN
		//	dcif.dmemREN
		//	dcif.dmemWEN
		//	cif.iload
		//	cif.iwait

		dcif.imemaddr		= '0;
		dcif.imemREN		= '0;
		dcif.dmemREN		= '0;
		dcif.dmemWEN		= '0;
		cif.iload				= '0;
		cif.iwait				= '0;
		#(PERIOD); //waits a while
		nRST = 0; //start with nreset
		
		//fill cache
		@(posedge CLK);
		nRST = 1;
		@(posedge CLK);
		dcif.imemaddr =  {tag1, idx1, 2'b00};
		cif.iload = 32'd1;
		cif.iwait = 0;
		@(posedge CLK);
		dcif.imemaddr =  {tag2, idx2, 2'b00};
		cif.iload = 32'd2;
		cif.iwait = 0;
		@(posedge CLK);
		dcif.imemaddr =  {tag3, idx3, 2'b00};
		cif.iload = 32'd3;
		cif.iwait = 0;
		@(posedge CLK);
	
		//pre-test initialize
		dcif.imemREN		= 1;

		//case 1: test hit
		cif.iwait = 1;
		dcif.imemaddr =  {tag1, idx1, 2'b00};
		++testcase;

		@(posedge CLK);
		if (dcif.ihit && (dcif.imemload == 32'd1)) begin
			$display("Passed test %d: ihit is asserted and imemload has correct data", testcase);
		end
		else begin
			$display("Failed test %d: for expected hit-- ihit = %d and imemload = %d", testcase, dcif.ihit, dcif.imemload);
		end 
		#(PERIOD);

		//case 2: test miss
		dcif.imemaddr 	=  {tag_junk, idx1, 2'b00};
		cif.iwait				= 1;
		cif.iload 			= 32'd69;
		++testcase;

		@(posedge CLK);
		if (!dcif.ihit && (dcif.imemload == cif.iload)) begin
			$display("Passed test %d: ihit is deasserted for miss and imemload is same as cif.iload", testcase);
		end
		else begin
			$display("Failed test %d: for expected miss-- ihit = %d and imemload = %d", testcase, dcif.ihit, dcif.imemload);
		end 
		#(PERIOD);

		//case 3: test 2 consecutive hits
		@(posedge CLK);
		dcif.imemaddr =  {tag2, idx2, 2'b00};
		
		@(posedge CLK);
		if (dcif.ihit && (dcif.imemload == 32'd2)) begin
			hitcount++;
		end

		@(posedge CLK);
		dcif.imemaddr =  {tag3, idx3, 2'b00};
		++testcase;

		@(posedge CLK);
		if (dcif.ihit && (dcif.imemload == 32'd3)) begin
			hitcount++;
		end

		@(posedge CLK);
		if (hitcount == 2) begin
			$display("Passed test %d: correct beahvior for 2 consecutive hits", testcase);
		end
		else begin
			$display("Failed test %d: incorrect beahvior for 2 consecutive hits, %d, %d", testcase, dcif.ihit, dcif.imemload);
		end
		#(PERIOD);
	
		//case 4: test 2 consecutive missies    
		@(posedge CLK);
		dcif.imemaddr =  {tag_junk, idx2, 2'b00};
		cif.iwait				= 1;
		cif.iload 			= 32'd9;
	
		@(posedge CLK);
		if (!dcif.ihit && (dcif.imemload == cif.iload)) begin
			hitcount--;
		end

		@(posedge CLK);
		dcif.imemaddr =  {tag_junk, idx3, 2'b00};
		++testcase;

		@(posedge CLK);
		if (!dcif.ihit && (dcif.imemload == cif.iload)) begin
			hitcount--;
		end

		@(posedge CLK);
		if (hitcount == 0) begin
			$display("Passed test %d: correct beahvior for 2 consecutive misses", testcase);
		end
		else begin
			$display("Failed test %d: incorrect beahvior for 2 consecutive misses, %d, %d", testcase, dcif.ihit, hitcount);
		end
		#(PERIOD);

		//case 5: dMEM    
		@(posedge CLK);
		dcif.imemREN		= '0;
		++testcase;
		@(posedge CLK);
		if (!dcif.ihit && (dcif.imemload == '0)) begin
			$display("Passed test %d: correct beahvior for when dmemREN is deasserted", testcase);
		end
		else begin
			$display("Failed test %d: incorrect beahvior for when dmemREN is deasserted", testcase);
		end
		#(PERIOD);
		nRST = 0;
  end

endprogram
