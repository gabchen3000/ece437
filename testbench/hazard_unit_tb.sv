/*
  hazard_unit test bench
*/

// mapped needs this
`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"
// import types
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
	hazard_unit_if huif();

  // test program
  test PROG (CLK, nRST, huif);
  // DUT
`ifndef MAPPED
  hazard_unit DUT(huif);
`endif

endmodule

program test(
	input logic CLK,
	output logic nRST,
	hazard_unit_if.tb huif
);

	parameter PERIOD = 10;

	initial begin
    nRST = 0;
		#(PERIOD);
		#(PERIOD);
		#(PERIOD);
		nRST = 1;
		@(posedge CLK);

		//initialize values
		huif.EXwsel = 0;
		huif.MEMwsel = 0;
		huif.rs = 0;
		huif.rt = 0;
		huif.MEMRegWr = 0;
		huif.EXRegWr = 0;
		huif.PCSrc = 3; // this means nextpc is npc
		huif.ihit = 0;
		huif.dhit = 0;

		@(posedge CLK);		
		//note: hazard is asserted with ihits - nothing to do with dhit?
		//testcase 1: EXwsel same as rs, EXRegWr = 1
		huif.ihit = 1;
		huif.EXwsel = 5'd4;
		huif.MEMwsel = 5'd1;
		huif.rs = 5'd4;
		huif.rt = 5'd2;
		huif.MEMRegWr = 0;
		huif.EXRegWr = 1;
		@(posedge CLK);	
		if (huif.IDdopause == 1) begin
			$display("==Case 1 is correct==, IDdopause = %h", huif.IDdopause);
		end
		else begin
			$display("-----------case 1 is incorrect, IDdopause = %h", huif.IDdopause);
		end

		//testcase 2: MEMwsel same as rt, MEMRegWr = 1
		huif.EXwsel = 5'd4;
		huif.MEMwsel = 5'd1;
		huif.rs = 5'd6;
		huif.rt = 5'd1;
		huif.MEMRegWr = 1;
		huif.EXRegWr = 0;
		@(posedge CLK);	
		if (huif.IDdopause == 1) begin
			$display("==Case 2 is correct==, IDdopause = %h", huif.IDdopause);
		end
		else begin
			$display("-----------case 2 is incorrect, IDdopause = %h", huif.IDdopause);
		end

		//testcase 3: EXwsel same as rt, but EXRegWr = 0
		huif.EXwsel = 5'd4;
		huif.MEMwsel = 5'd1;
		huif.rs = 5'd2;
		huif.rt = 5'd4;
		huif.MEMRegWr = 0;
		huif.EXRegWr = 0;
		@(posedge CLK);	
		if (huif.IDdopause == 0) begin
			$display("==Case 3 is correct==, IDdopause = %h", huif.IDdopause);
		end
		else begin
			$display("-----------case 3 is incorrect, IDdopause = %h", huif.IDdopause);
		end

		//testcase 4: MEMwsel same as rs, but MEMRegWr = 0
		huif.EXwsel = 5'd4;
		huif.MEMwsel = 5'd1;
		huif.rs = 5'd1;
		huif.rt = 5'd4;
		huif.MEMRegWr = 0;
		huif.EXRegWr = 0;
		@(posedge CLK);	
		if (huif.IDdopause == 0) begin
			$display("==Case 4 is correct==, IDdopause = %h", huif.IDdopause);
		end
		else begin
			$display("-----------case 4 is incorrect, IDdopause = %h", huif.IDdopause);
		end

		//testcase 5: MEMwsel and EXwsel same as rs and rt, but they are all 0
		huif.EXwsel = 5'd0;
		huif.MEMwsel = 5'd0;
		huif.rs = 5'd0;
		huif.rt = 5'd0;
		huif.MEMRegWr = 1;
		huif.EXRegWr = 1;
		@(posedge CLK);	
		if (huif.IDdopause == 0) begin
			$display("==Case 5 is correct==, IDdopause = %h", huif.IDdopause);
		end
		else begin
			$display("-----------case 5 is incorrect, IDdopause = %h", huif.IDdopause);
		end

		//testcase 6: PCSrc is not npc - when either a jump, jal or branch happens
		/*huif.EXwsel = 5'd2;
		huif.MEMwsel = 5'd1;
		huif.rs = 5'd2;
		huif.rt = 5'd1;
		huif.MEMRegWr = 1;
		huif.EXRegWr = 1;*/

		@(posedge CLK);

	end

endprogram

