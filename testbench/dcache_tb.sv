// mapped needs this
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;

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
  dcache DUT(CLK, nRST, dcif, cif);
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

	logic [3:0]  idx1 				= 4'd1;
	logic [25:0] tag1_frame1 	= 26'd1;
	logic [25:0] tag1_frame2 	= 26'd11;

	logic [3:0]  idx4					= 4'd4;
	logic [25:0] tag4				 	= 26'd20;
	logic [3:0]	 idx7					= 4'd7;

	logic [25:0] tag_junk 		= 26'd69;
	logic [25:0] tag_hit			=	26'd69;
	logic [25:0] tag_new			= 26'd18;
	logic [25:0] tag_last			= 26'd500;
	logic [25:0] tag_last2			= 26'd600;

	logic offset0 						= 1'b0;
	logic offset1 						= 1'b1;

	logic [25:0] tag_junk_2 		= 26'd99;
	
	initial begin
		
		//to test:
		// cif.iREN
		// cif.iaddr
		// dcif.imemload
		// dcif.ihit
    
		//inputs
		//	dcif.dmemaddr 	-- tag idx offst
		//	cif.dload 			-- data from memory
		//	cif.dwait 			-- controls state machine
		//	dcif.halt				-- controls halt
		//	dcif.dmemREN
		//	dcif.dmemWEN

		cif.ccwait 			= '0;		
		cif.ccinv  			= '0;
		cif.ccsnoopaddr = '0;


		dcif.dmemaddr		= '0;
		dcif.imemREN		= '0;
		dcif.dmemREN		= 0;
		dcif.dmemWEN 		= 0;
		cif.dload				= '0;
		cif.dwait				= '0;
		#(PERIOD); //waits a while
		nRST = 0; //start with nreset
		
		//fill cache
		@(posedge CLK);
		nRST = 1;
		
		dcif.dmemWEN		= '0;
		dcif.dmemREN		= 1;
		
		//frame 1		
		@(posedge CLK);
		cif.dwait = 1;
		dcif.dmemaddr =  {tag1_frame1, idx1, offset0, 2'b00};
		cif.dload = 32'd1;
		
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;

		@(posedge CLK);
		dcif.dmemaddr =  {tag1_frame1, idx1, offset1, 2'b00};
		cif.dload = 32'd2;
		
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		
		//frame 2
		@(posedge CLK);
		dcif.dmemaddr =  {tag1_frame2, idx1, offset0, 2'b00};
		cif.dload = 32'd3;

		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;

		@(posedge CLK);
		dcif.dmemaddr =  {tag1_frame2, idx1, offset1, 2'b00};
		cif.dload = 32'd4;

		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		
		//@(posedge CLK);		@(posedge CLK);		@(posedge CLK);
		
		//tests 1-4 : test reading from cache (all hits)
		//case 1 and 2 is ONE LOADWORD from cache into a single block
		//case 1:
		
		dcif.dmemaddr =  {tag1_frame1, idx1, offset0, 2'b00};//hit1
		++testcase;

		@(posedge CLK);
		if (dcif.dhit && (dcif.dmemload == 32'd1)) begin
			$display("Passed test %d: reading 1 from cache frame 1 word 1", testcase);
		end
		else begin
			$display("Failed test %d: could not read 1 from cache frame 1 word 1", testcase);
		end 

		//case 2:
		
		dcif.dmemaddr =  {tag1_frame1, idx1, offset1, 2'b00};//hit2
		++testcase;

		@(posedge CLK);
		if (dcif.dhit && (dcif.dmemload == 32'd2)) begin
			$display("Passed test %d: reading 2 from cache frame 1 word 2", testcase);
		end
		else begin
			$display("Failed test %d: could not read 2 from cache frame 1 word 2", testcase);
		end 
		
		//case 3 and 4 reading from the second frame in the cache
		//case 3:
		
		dcif.dmemaddr =  {tag1_frame2, idx1, offset0, 2'b00};//hit3
		++testcase;

		@(posedge CLK);
		if (dcif.dhit && (dcif.dmemload == 32'd3)) begin
			$display("Passed test %d: reading 3 from cache frame 2 word 1", testcase);
		end
		else begin
			$display("Failed test %d: could not read 3 from cache frame 2 word 1", testcase);
		end 

		//case 4:
		
		dcif.dmemaddr =  {tag1_frame2, idx1, offset1, 2'b00};//hit4
		++testcase;

		@(posedge CLK);
		@(posedge CLK);
		if (dcif.dhit && (dcif.dmemload == 32'd4)) begin
			$display("Passed test %d: reading 4 from cache frame 2 word 1", testcase);
		end
		else begin
			$display("Failed test %d: could not read 4 from cache frame 2 word 2", testcase);
		end 
		
		
		//case 5: testing miss, trying to read from new tag -- eviction of cache first word
		dcif.dmemaddr =  {tag_junk, idx1, offset0, 2'b00};//miss
		cif.dload = 32'd69;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		
		++testcase;

		if (!dcif.dhit) begin
			$display("Passed test %d: It's a miss, load word eviction, first word loaded to cache", testcase);
		end
		else begin
			$display("Failed test %d: It was a hit, load word eviction did not happen", testcase);
		end 
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;

		//case 6: testing hit, trying to read from new tag -- second word//hit5
		@(posedge CLK);
		dcif.dmemaddr =  {tag_junk, idx1, offset1, 2'b00};
		cif.dload = 32'd67;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		++testcase;

		if (dcif.dhit) begin
			$display("Passed test %d: It's a hit, second word loaded to cache", testcase);
		end
		else begin
			$display("Failed test %d: It was a hit, load word eviction did not happen", testcase);
		end 
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;

		//case 7: test dhit and dmemload on replace data first word // hit6
		dcif.dmemaddr =  {tag_junk, idx1, offset0, 2'b00};
		++testcase;

		@(posedge CLK);
		if (dcif.dhit && (dcif.dmemload == 32'd69)) begin
			$display("Passed test %d: dhit on rewritten data, correct data", testcase);
		end
		else begin
			$display("Failed test %d: no dhit on rewritten data, data is %d", testcase, dcif.dmemload);
		end 

		//case 8: test dhit and dmemload on replace data first word //hit7
		dcif.dmemaddr =  {tag_junk, idx1, offset1, 2'b00};
		++testcase;

		@(posedge CLK);
		if (dcif.dhit && (dcif.dmemload == 32'd69)) begin
			$display("Passed test %d: dhit on rewritten data, correct data", testcase);
		end
		else begin
			$display("Failed test %d: no dhit on rewritten data, data is %d", testcase, dcif.dmemload);
		end 

		//case 9 test hit and setting dirty bit and imemREN = 1 (should ignore)
		dcif.dmemREN = 0;
		dcif.imemREN = 1;	//should ignore
		dcif.dmemWEN = 1;
		dcif.dmemaddr = {tag_hit, idx1, offset0, 2'b0}; //hit8
		dcif.dmemstore = 32'd40;
		++testcase;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		dcif.dmemaddr = {tag_hit, idx1, offset1, 2'b0}; //hit9
		dcif.dmemstore = 32'd50;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;


		if (dcif.dhit) begin
			$display("Passed test %d: dhit on a write", testcase);
		end
		else begin
			$display("Failed test %d: no dhit on a write", testcase);
		end

		@(posedge CLK);

		//case 10 test hit and setting dirty bit
		++testcase;
		dcif.dmemREN = 0;
		dcif.dmemWEN = 1;
		dcif.dmemaddr = {tag1_frame2, idx1, offset0, 2'b0};
		dcif.dmemstore = 32'd41;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		dcif.dmemaddr = {tag1_frame2, idx1, offset1, 2'b0};
		dcif.dmemstore = 32'd51;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;


		if (dcif.dhit) begin
			$display("Passed test %d: dhit on a write", testcase);
		end
		else begin
			$display("Failed test %d: no dhit on a writedcif", testcase);
		end

		@(posedge CLK);

		//case 11 test rewrite on data, this is eviction with a store word one
		++testcase;
		dcif.imemREN = 0;	//should ignore
		dcif.dmemaddr = {tag_new, idx1, offset0, 2'b0};
		dcif.dmemstore = 32'd49;
		@(posedge CLK);
		cif.dwait = 0;

		if (!dcif.dhit && cif.dstore == 40) begin
			$display("Passed test %d: dhit on a write, new dstore into memory", testcase);
		end
		else begin
			$display("Failed test %d: no dhit on a write dstore value = %d", testcase, cif.dstore);
		end
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);



		//case 12 test rewrite on data, this is eviction with a store word two
		++testcase;
		dcif.dmemaddr = {tag_new, idx1, offset1, 2'b0};
		dcif.dmemstore = 32'd59;
		@(posedge CLK);
		cif.dwait = 0;

		if (!dcif.dhit && cif.dstore == 50) begin
			$display("Passed test %d: dhit on a write, new dstore into memory", testcase);
		end
		else begin
			$display("Failed test %d: no dhit on a write dstore value = %d", testcase, cif.dstore);
		end
		@(posedge CLK);
		cif.dwait = 1;

		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		
		/*		
		//case 13 write into one more index, test flush all dirty data with halt signal
		++testcase;
		//frame 1				
		@(posedge CLK);
		dcif.dmemaddr = {tag_last, idx7, offset0, 2'b0};
		dcif.dmemstore = 32'hAA;
		cif.dload = 32'hff;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		dcif.dmemaddr = {tag_last, idx7, offset1, 2'b0};
		dcif.dmemstore = 32'hAB;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);

		dcif.dmemaddr = {tag_last, idx7, offset0, 2'b0};
		dcif.dmemstore = 32'hAA;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		dcif.dmemaddr = {tag_last, idx7, offset1, 2'b0};
		dcif.dmemstore = 32'hAB;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);

		//frame 2
		@(posedge CLK);
		dcif.dmemaddr = {tag_last2, idx7, offset0, 2'b0};
		dcif.dmemstore = 32'hBA;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		dcif.dmemaddr = {tag_last2, idx7, offset1, 2'b0};
		dcif.dmemstore = 32'hBB;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);

		dcif.dmemaddr = {tag_last2, idx7, offset0, 2'b0};
		dcif.dmemstore = 32'hBA;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		dcif.dmemaddr = {tag_last2, idx7, offset1, 2'b0};
		dcif.dmemstore = 32'hBB;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		
		//dcif.halt = 1; Commenting out halt.......................
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		//frame 1 index 1 flush1 and 2
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		//frame 1 index 7 flush 1 and 2
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		//frame2 index 1 flush 1 and 2
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		//frame 2 index 7 flush 1 and flush 2
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		
		if (cif.dstore == 34) begin
			$display("Passed test %d: count value is correct", testcase);
		end
		else begin
			$display("Failed test %d: count value is not correct: %d", testcase, cif.dstore);
		end

		@(posedge CLK);dcif.dmemaddr =  {tag_junk, idx1, offset1, 2'b00};
		cif.dload = 32'd67;
		@(posedge CLK);
		cif.dwait = 0;
		@(posedge CLK);
		cif.dwait = 1;
		//finish writing count.
		++testcase;
		if (dcif.flushed == 1) begin
			$display("Passed test %d: data is flushed", testcase);
		end
		else begin
			$display("Failed test %d: data not flushed: %d", testcase, dcif.flushed);
		end
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
	
		*/
		//#(PERIOD);
		//nRST = 0;
		//@(posedge CLK);
		//nRST = 1;
		@(posedge CLK);
	
		//test 13
		//test IDLE -> SNOOPING (stagmiss) _> IDLE
		/// when dcache is the responding cache
		cif.ccwait = '1;
		//finish writing count.
		
		@(posedge CLK);
		++testcase;
		if (cif.cctrans == 1 && cif.ccwrite == 0) begin
			$display("Passed test %d: dcache is in snooping, on stagmiss: has set cctrans and reset ccwrite", testcase);
		end
		else begin
			$display("Failed test %d: failed idle to snooping, stagmiss case", testcase, dcif.flushed);
		end
		
		@(posedge CLK);

		//test 14
		//test IDLE -> SNOOPING (!stagmiss && !dirty) _> IDLE
		// match tag, frame1, dirty
		/*Note:
			assign snooptag = cif.ccsnoopaddr[31:6];
			assign snoopidx = cif.ccsnoopaddr[5:3];
			assign snoopoffset = cif.ccsnoopaddr[2];
		*/

		cif.ccwait = '0;
		@(posedge CLK);
		cif.ccwait = '1;
		cif.ccsnoopaddr = 32'haa;
		
		@(posedge CLK);
		++testcase;
		if (cif.cctrans == 1 && cif.ccwrite == 0) begin
			$display("Passed test %d: dcache is in snooping, on staghit && not dirty: has set cctrans and reset ccwrite", testcase);
		end
		else begin
			$display("Failed test %d: failed idle to snooping, stagmiss case", testcase, dcif.flushed);
		end
		
		//test 15
		//test IDLE -> SNOOPING (!stagmiss && dirty) -> coherence write backs		
		@(posedge CLK);
		cif.ccsnoopaddr = 32'h90c;
	
		@(posedge CLK);
		++testcase;
		if (cif.cctrans == 1 && cif.ccwrite == 1) begin
			$display("Passed test %d: dcache is in snooping, on staghit && dirty: has set cctrans and ccwrite", testcase);
		end
		else begin
			$display("Failed test %d: failed idle to snooping, !stagmiss case", testcase, dcif.flushed);
		end
		@(posedge CLK);

		//test 16
		//test CO_WBO		
		@(posedge CLK);
		++testcase;
		if (cif.dWEN == 1 && cif.dstore == 32'h43 && cif.ccwrite == 1) begin
			$display("Passed test %d: dcache is in CO_WBO, dWEN is high and dstore is same as frame1_data_1", testcase);
		end
		else begin
			$display("Failed test %d: failed -- didn't get expected CO_WB1 beahvior", testcase);
		end
		@(posedge CLK);

		//test 17
		//test CO_WB1
		cif.dwait = '0;		
		@(posedge CLK);
		++testcase;
		if (cif.dWEN == 1 && cif.dstore == 32'h3b && cif.ccwrite == 1) begin
			$display("Passed test %d: dcache is in CO_WB1, dWEN is high and dstore is same as frame1_data_2", testcase);
		end
		else begin
			$display("Failed test %d: failed -- didn't get expected CO_WB1 beahvior", testcase);
		end
		@(posedge CLK);

		//send back to IDLE 
		cif.dwait = '0;
		cif.ccwait = '0;		
		@(posedge CLK);				

		//test 18
		//test transition writeback1 to snooping 
		dcif.dmemaddr =  {tag_junk, idx1, offset0, 2'b00};//miss
		@(posedge CLK);
		//now dcache is in writeback1
		cif.ccwait = 1;
		cif.ccsnoopaddr = 32'haa;
		@(posedge CLK);
		
		++testcase;
		if (cif.cctrans == 1 && cif.ccwrite == 0) begin
			$display("Passed test %d: dcache is in snooping after writeback1, and on stagmiss: has set cctrans and reset ccwrite", testcase);
		end		
		else begin
			$display("Failed test %d: failed writeback1 to snooping transition", testcase);
		end
		@(posedge CLK);
		
		//test 19
		//test transition load1 to snooping 
		cif.dwait = '0;
		cif.ccwait = '0;	
		dcif.dmemaddr =  {tag_junk_2, idx4, offset0, 2'b00};//miss
		@(posedge CLK);
		//now dcache is in load1
		cif.ccwait = 1;
		cif.ccsnoopaddr = 32'haa;
		@(posedge CLK);
		
		++testcase;
		if (cif.cctrans == 1 && cif.ccwrite == 0) begin
			$display("Passed test %d: dcache is in snooping after load1, and on stagmiss: has set cctrans and reset ccwrite", testcase);
		end		
	else begin
			$display("Failed test %d: failed load1 to snooping transition", testcase);
		end
		@(posedge CLK);

		$display("Failed: didn't write test case for flush to snooping transition");		
  end

endprogram
