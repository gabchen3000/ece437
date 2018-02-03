/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(
	input logic CLK,
	output logic nRST,
	register_file_if.tb rfiftb
);

	parameter PERIOD = 10;

	initial begin
    
		#(PERIOD); //waits a while
		nRST = 0; //start with nreset

		//case 1 write value 1 into register 20
		#(PERIOD);
		@(posedge CLK);
		nRST = 1;
		rfiftb.WEN = 1;
		@(posedge CLK);
		rfiftb.wsel = 5'd20;
		rfiftb.wdat = 1'd1;
		rfiftb.rsel1 = 5'd20;
		@(posedge CLK);

		if (rfiftb.rdat1 == 1) begin
			$display("==Case 1 is correct==");
		end
		else begin
			$display("----------------Case 1 is wrong, rdat = %d", rfiftb.rdat1);
		end 
		#(PERIOD);
		nRST = 0;    


    //case 2 write value to register 0, it should stay 0
		#(PERIOD);
		@(posedge CLK);
		nRST = 1;
		rfiftb.WEN = 1;
		rfiftb.wsel = 5'd0;
		rfiftb.wdat = 2'd3;
		rfiftb.rsel1 = 5'd0;
		@(posedge CLK);

		if (rfiftb.rdat1 == 0) begin
			$display("==Case 2 is correct==");
		end
		else begin
			$display("----------------Case 2 is wrong, rdat = %d", rfiftb.rdat1);
		end 
		#(PERIOD);
		nRST = 0;

		//case 3 write highest value into any register, then read from rdat2
		#(PERIOD);
		@(posedge CLK);
		nRST = 1;
		rfiftb.WEN = 1;
		rfiftb.wsel = 5'd31;
		rfiftb.wdat = '1;
		rfiftb.rsel2 = 5'd31;
		@(posedge CLK);

		if (rfiftb.rdat2 == '1) begin
			$display("==Case 3 is correct==");
		end
		else begin
			$display("----------------Case 3 is wrong, rdat = %d", rfiftb.rdat2);
		end 
		#(PERIOD);
		nRST = 0;

		//case 4 check most registers to see if they're of value 0 after nRST = 0
		@(posedge CLK);
		nRST = 1;
		rfiftb.rsel1 = 5'd0;
		rfiftb.rsel2 = 5'd1;
		if (rfiftb.rdat1 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		else if (rfiftb.rdat2 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		@(posedge CLK);
		rfiftb.rsel1 = 5'd4;
		rfiftb.rsel2 = 5'd5;
		if (rfiftb.rdat1 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		else if (rfiftb.rdat2 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		@(posedge CLK);
		rfiftb.rsel1 = 5'd8;
		rfiftb.rsel2 = 5'd9;
		if (rfiftb.rdat1 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		else if (rfiftb.rdat2 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		@(posedge CLK);
		rfiftb.rsel1 = 5'd12;
		rfiftb.rsel2 = 5'd13;
		if (rfiftb.rdat1 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		else if (rfiftb.rdat2 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		@(posedge CLK);
		rfiftb.rsel1 = 5'd16;
		rfiftb.rsel2 = 5'd17;
		if (rfiftb.rdat1 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		else if (rfiftb.rdat2 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		@(posedge CLK);
		rfiftb.rsel1 = 5'd22;
		rfiftb.rsel2 = 5'd23;
		if (rfiftb.rdat1 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		else if (rfiftb.rdat2 != 0) begin
			$display("----------------Case 4 is incorrect");
		end
		else begin
			$display("==Case 4 is correct==");
		end
		#(PERIOD);
		nRST = 0;

		//case 5 write to register w/ WEN, then write again w/o WEN, read register, expect first write's value
		@(posedge CLK);
		nRST = 1;
		rfiftb.WEN = 1;
		rfiftb.wdat = 14'd9280;
		rfiftb.wsel = 5'd18;
		rfiftb.rsel1 = 5'd18;
		@(posedge CLK);

		rfiftb.WEN = 0;
		rfiftb.wdat = 14'd8193;
		rfiftb.wsel = 5'd18;
		@(posedge CLK);
		rfiftb.rsel1 = 5'd18;
		if (rfiftb.rdat1 == 9280) begin
			$display("==Case 5 is correct==");
		end
		else begin
			$display("----------------Case 5 is incorrect, rdat = %d", rfiftb.rdat1);
		end
		#(PERIOD);
		nRST = 0;

  end

endprogram
