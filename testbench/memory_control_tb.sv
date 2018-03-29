/*
  memory_control test bench
*/

// mapped needs this
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"
// import types
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
	caches_if cif0();
	caches_if cif1();
  cache_control_if #(.CPUS(2)) ccif (cif0, cif1);
	cpu_ram_if ramif();
  // test program
  test PROG (CLK, nRST, ccif);
  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
`else
  memory_control DUT(
		.\CLK (CLK),
		.\nRST (nRST),
		.\ccif.iREN (ccif.iREN),
		.\ccif.dREN (ccif.dREN),
		.\ccif.dWEN (ccif.dWEN),
		.\ccif.dstore (ccif.dstore),
		.\ccif.iaddr (ccif.iaddr),
		.\ccif.daddr (ccif.daddr),
		.\ccif.ramload (ccif.ramload),
		.\ccif.ramstate (ccif.ramstate),
		.\ccif.iwait (ccif.iwait),
		.\ccif.dwait (ccif.dwait),
		.\ccif.iload (ccif.iload),
		.\ccif.dload (ccif.dload),
		.\ccif.ramstore (ccif.ramstore),
		.\ccif.ramaddr (ccif.ramaddr),
		.\ccif.ramWEN (ccif.ramWEN),
		.\ccif.ramREN (ccif.ramREN)
  );
`endif

endmodule

program test(
	input logic CLK,
	output logic nRST,
	cache_control_if ccif
);

	parameter PERIOD = 10;
	int testcase = 0;

	logic [3:0]  idx1 				= 4'd1;
	logic [25:0] tag1				 	= 26'd1;
	logic [25:0] tag2				 	= 26'hA;
	logic	[1:0]	iRENok = 0;
	logic				snoopcorrect = 0;
	word_t		instr0 = 32'hCD;
	word_t		instr1 = 32'hDD;

	logic offset0 						= 1'b0;
	logic offset1 						= 1'b1;

	initial begin
		//initialize inputs
		//ccif.ramstate = ramif.ramstate;
		ccif.ramload = ramif.ramload;

		cif0.iREN 			= '0;
		cif0.dREN 			= '0;
		cif0.dWEN 			= '0;
		cif0.dstore 		= '0;
		cif0.iaddr 		= '0;
		cif0.daddr 		= '0;
		cif0.ccwrite 	= '0;
 		cif0.cctrans 	= '0;

		cif1.iREN 			= '0;
		cif1.dREN 			= '0;
		cif1.dWEN 			= '0;
		cif1.dstore 		= '0;
		cif1.iaddr 		= '0;
		cif1.daddr 		= '0;
		cif1.ccwrite 	= '0;
 		cif1.cctrans 	= '0;

		ccif.ramstate = BUSY;
		ccif.ramload = 0;

		@(posedge CLK);		
		#(PERIOD);
		@(posedge CLK);

    nRST = 0;
		#(PERIOD);
		nRST = 1;
		#(PERIOD);
		
		++testcase;

		@(posedge CLK);
		//test 1: non coherent writeback (eviction of one of the cache)
		cif0.dWEN = 1;
		cif0.daddr = {tag1, idx1, offset0, 2'b0};
		cif0.daddr = 32'd0; //store data on first address
		cif0.dstore = 32'hAA;
		@(posedge CLK);
		ccif.ramstate = ACCESS;
		cif0.dWEN = 1;
		cif0.daddr = {tag1, idx1, offset1, 2'b0}; //store data on second address
		cif0.dstore = 32'hAB;

		@(posedge CLK);

		if ((ccif.ramWEN == 1) && (ccif.ramaddr == {tag1, idx1, offset1, 2'b0}) && (ccif.ramstore ==	32'hAB) && (ccif.dwait[0] == 1)) begin
			$display("==Case %d is correct==, ramWEN = %h, ramaddr = %h, ramstore = %h, dwait[0] = %h", testcase, ccif.ramWEN, ccif.ramaddr, ccif.ramstore, ccif.dwait[0]);
		end
		else begin
			$display("-----------Case %d is not correct==, ramWEN = %h, ramaddr = %h, ramstore = %h, dwait[0] = %h", testcase, ccif.ramWEN, ccif.ramaddr, ccif.ramstore, ccif.dwait[0]);
		end

		@(posedge CLK);
		ccif.ramstate = BUSY;
		cif0.dWEN = 0;


		//test 2: arbitrate between multiple instruction fetch from same cache, should not starve the other cache
		++testcase;
		cif0.iREN = 1;
		cif1.iREN = 1;
		@(posedge CLK);
		@(posedge CLK);
		ccif.ramstate = ACCESS;
		ccif.ramload = instr0;
		cif0.iaddr = {tag1, idx1, offset0, 2'b0};
		if (ccif.ramREN) begin
			iRENok[0] = 1;
		end
		@(posedge CLK);
		ccif.ramstate = BUSY;
		@(posedge CLK);
		ccif.ramload = instr1;
		@(posedge CLK);
		ccif.ramstate = ACCESS;
		cif0.iaddr = {tag1, idx1, offset1, 2'b0};
		if (ccif.ramREN) begin
			iRENok[1] = 1;
		end

		if ((iRENok == 3) && (cif1.iload == instr1)) begin
			$display("==Case %d is correct==, iREN = %h, iload[1] = %h", testcase, iRENok, cif1.iload);
		end
		else begin
			$display("-----------Case %d is not correct==, iREN = %h, iload[1] = %h", testcase, iRENok, cif1.iload);
		end
		iRENok = 0;

		@(posedge CLK);
		ccif.ramstate = BUSY;
		cif0.iREN = 0;
		cif1.iREN = 0;

		@(posedge CLK);

		//test 3: cache0 is the requesting cache, cache1 is responding cache, cache1 goes from modified to inv state, we should expect data to be in cache0 as well as written back to memory
		//cctrans[1] is also asserted with dREN[1], but arbitration always chooses cache0 first
		++testcase;
		cif0.cctrans = 1;
		cif0.dREN = 1;
		cif1.dREN = 1;
		cif0.daddr = {tag2, idx1, offset0, 2'b0};
		@(posedge CLK);

		@(posedge CLK);

		if (cif1.ccwait == 1 && cif1.ccsnoopaddr == {tag2, idx1, offset0, 2'b0}) begin
			$display("==Case %d.1 is correct==, snoop address is correct", testcase);
		end
		else begin
			$display("==Case %d.1 is not correct==, ccwait = %h, ccsnoopaddr = %h", testcase, cif1.ccwait, cif1.ccsnoopaddr);
		end

		cif1.cctrans = 1;
		cif1.ccwrite = 1;
		cif1.daddr = {tag2, idx1, offset0, 2'b0};
		cif1.dstore = 32'hA1;
		cif1.dWEN = 1;
		cif0.ccwrite = 1;
		@(posedge CLK);


		ccif.ramstate = ACCESS;
		if (ccif.ramaddr == {tag2, idx1, offset0, 2'b0} && ccif.ramstore == 32'hA1 && ccif.ramWEN == 1) begin
			$display("==Case %d.2 is correct==, ramaddr = %h, ramstore = %h, ramWEN = %h", testcase, ccif.ramaddr, ccif.ramstore, ccif.ramWEN);
		end
		else begin
			$display("==Case %d.2 is not correct==, ramaddr = %h, ramstore = %h, ramWEN = %h", testcase, ccif.ramaddr, ccif.ramstore, ccif.ramWEN);
		end

		@(posedge CLK);
		ccif.ramstate = BUSY;

		@(posedge CLK);
		ccif.ramstate = ACCESS;
		if (cif0.dload == 32'hA1 && cif1.ccinv == 1) begin
			$display("==Case %d.3 is correct==, dload of cache0 is correct and ccinvalidate is asserted for cache1", testcase);
		end
		else begin
			$display("==Case %d.3 is not correct==, cif0.dload = %h, ccwrite = %h", testcase, cif0.dload, cif0.ccwrite);
		end

		@(posedge CLK);
		ccif.ramstate = BUSY;
		cif0.cctrans = 0;
		cif0.dREN = 0;
		cif1.dREN = 0;
		cif1.cctrans = 0;
		cif1.ccwrite = 0;
		cif1.daddr = 0;
		cif1.dstore = 0;
		cif1.dWEN = 0;
		cif0.ccwrite = 0;
		@(posedge CLK);

		//test 4: cache0 is the requesting cache, cache1 is responding cache, cache0 inv to shared state, cache1 modified to shared
		//cctrans[1] is also asserted with dREN[1], but arbitration always chooses cache0 first
		++testcase;
		cif0.cctrans = 1;
		cif0.dREN = 1;
		cif1.dREN = 1;


		@(posedge CLK);
		cif1.cctrans = 1;
		cif1.ccwrite = 0;
		cif0.daddr = {tag2, idx1, offset0, 2'b0};
		cif0.ccwrite = 0;
		ccif.ramload = 32'hA3;
		@(posedge CLK);

		if (cif1.ccwait == 1 && cif1.ccsnoopaddr == {tag2, idx1, offset0, 2'b0}) begin
			$display("==Case %d.1 is correct==, snoop address is correct", testcase);
		end
		else begin
			$display("==Case %d.1 is not correct==, ccwait = %h, ccsnoopaddr = %h", testcase, cif1.ccwait, cif1.ccsnoopaddr);
		end


		@(posedge CLK);


		ccif.ramstate = ACCESS;
		if (ccif.ramaddr == {tag2, idx1, offset0, 2'b0} && ccif.ramREN == 1) begin
			$display("==Case %d.2 is correct==, ramaddr = %h, ramREN = %h", testcase, ccif.ramaddr, ccif.ramREN);
		end
		else begin
			$display("==Case %d.2 is not correct==, ramaddr = %h, ramREN = %h", testcase, ccif.ramaddr, ccif.ramREN);
		end

		@(posedge CLK);
		ccif.ramstate = BUSY;

		@(posedge CLK);
		ccif.ramstate = ACCESS;
		if (cif0.dload == 32'hA3 && cif1.ccinv == 0) begin
			$display("==Case %d.3 is correct==, dload of cache0 is correct and ccinvalidate is asserted for cache1", testcase);
		end
		else begin
			$display("==Case %d.3 is not correct==, cif0.dload = %h, ccinv = %h", testcase, cif0.dload, cif1.ccinv);
		end

		@(posedge CLK);
		ccif.ramstate = BUSY;
		cif0.cctrans = 0;
		cif0.dREN = 0;
		cif1.dREN = 0;
		cif1.cctrans = 0;
		cif1.ccwrite = 0;
		cif1.daddr = 0;
		cif1.dstore = 0;
		cif1.dWEN = 0;
		cif0.ccwrite = 0;

		@(posedge CLK);

		//test 5: cache0 is the requesting cache, cache1 is responding cache
		//				cache0 and cache1 is in SHARED state, cache0 is going to modified state
		//				cache1 should be invalidated
		++testcase;
		cif0.cctrans = 1;
		cif0.dREN = 0;
		cif1.dREN = 0;
		cif0.dWEN = 0;
		cif1.dWEN = 0;

		@(posedge CLK);

		if (cif1.ccinv == 1) begin
			$display("==Case %d is correct==, ccinv1 is asserted, this means that cache0 is in modified", testcase);
		end
		else begin
			$display("==Case %d is not correct==, ccinv1 = %h", testcase, cif1.ccinv);
		end


//add extra case, where DArbitrate goes back to IDLE
//when requesting cache goes from shared to modified


		@(posedge CLK);
				#(PERIOD);
		nRST = 0;
	end


endprogram

