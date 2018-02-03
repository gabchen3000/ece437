/*
  request unit test bench
*/

// mapped needs this
`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"
// import types
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  request_unit_if ruif ();
  // test program
  test PROG (CLK, nRST, ruif);
  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`else
  request_unit DUT(
    .\ruif.dREN (ruif.dREN),
    .\ruif.dWEN (ruif.dWEN),
    .\ruif.dhit (ruif.dhit),
    .\ruif.ihit (ruif.ihit),
    .\ruif.dmemREN (ruif.dmemREN),
    .\ruif.dmemWEN (ruif.dmemWEN),
    .\nRST (nRST),
		.\CLK (CLK)
  );
`endif

endmodule

program test(
	input logic CLK,
	output logic nRST,
	request_unit_if ruiftb
);


	parameter PERIOD = 10;

	initial begin
    
		#(PERIOD);
		nRST = 0;
		@(posedge CLK);
		nRST = 1;
		@(posedge CLK);
		ruiftb.dREN = 0;
		ruiftb.dWEN = 0;
		ruiftb.ihit = 0;
		ruiftb.dhit = 0;

		//case 1
		@(posedge CLK);
		ruiftb.dREN = 1;
		@(posedge CLK);

		if (ruiftb.dmemREN == 0 && ruiftb.dmemWEN == 0) begin
			$display("==Case 1 is correct==");
		end
		else begin
			$display("----------------Case 1 is wrong, ruiftb.dmemREN = %h, ruiftb.dmemWEN = %h", ruiftb.dmemREN, ruiftb.dmemWEN);
		end 

		//case 2
		@(posedge CLK);
		ruiftb.dWEN = 1;
		@(posedge CLK);

		if (ruiftb.dmemREN == 0 && ruiftb.dmemWEN == 0) begin
			$display("==Case 2 is correct==");
		end
		else begin
			$display("----------------Case 2 is wrong, ruiftb.dmemREN = %h, ruiftb.dmemWEN = %h", ruiftb.dmemREN, ruiftb.dmemWEN);
		end 

		//case 3
		@(posedge CLK);
		ruiftb.dhit = 1;
		ruiftb.dWEN = 0;
		ruiftb.dREN = 0;
		@(posedge CLK);

		if (ruiftb.dmemREN == 1 && ruiftb.dmemWEN == 1) begin
			$display("==Case 3 is correct==");
		end
		else begin
			$display("----------------Case 3 is wrong, ruiftb.dmemREN = %h, ruiftb.dmemWEN = %h", ruiftb.dmemREN, ruiftb.dmemWEN);
		end 

		//case 4
		@(posedge CLK);
		ruiftb.dhit = 1;
		ruiftb.ihit = 1;
		ruiftb.dWEN = 0;
		ruiftb.dREN = 0;
		@(posedge CLK);

		if (ruiftb.dmemREN == 1 && ruiftb.dmemWEN == 1) begin
			$display("==Case 4 is correct==");
		end
		else begin
			$display("----------------Case 4 is wrong, ruiftb.dmemREN = %h, ruiftb.dmemWEN = %h", ruiftb.dmemREN, ruiftb.dmemWEN);
		end 

		//case 5
		@(posedge CLK);
		ruiftb.dhit = 0;
		ruiftb.ihit = 1;
		ruiftb.dWEN = 0;
		ruiftb.dREN = 1;
		@(posedge CLK);

		if (ruiftb.dmemREN == 1 && ruiftb.dmemWEN == 0) begin
			$display("==Case 5 is correct==");
		end
		else begin
			$display("----------------Case 5 is wrong, ruiftb.dmemREN = %h, ruiftb.dmemWEN = %h", ruiftb.dmemREN, ruiftb.dmemWEN);
		end 

  end

endprogram
