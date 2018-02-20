/*
  hazard_unit test bench
*/

// mapped needs this
`include "forward_unit_if.vh"
`include "cpu_types_pkg.vh"
// import types
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module forward_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
	forward_unit_if fuif();

  // test program
  test PROG (CLK, nRST, fuif);
  // DUT
`ifndef MAPPED
  forward_unit DUT(fuif);
`endif

endmodule

program test(
	input logic CLK,
	output logic nRST,
	forward_unit_if.fu fuif
);

	parameter PERIOD = 10;
	int testcase = 0;
	initial begin
    nRST = 0;
		#(PERIOD);
		#(PERIOD);
		#(PERIOD);
		nRST = 1;
		@(posedge CLK);

		//initialize values
		fuif.id_ex_rs 	=  '0; 
		fuif.id_ex_rt		=  '0;
		fuif.MEMwsel		=  '0;
		fuif.WBwsel			=  '0;
		fuif.MEMRegWr		=  '0;
		fuif.WBRegWr		=  '0;
		fuif.MEMlui			=  '0;
		fuif.WBlui			=  '0;

		@(posedge CLK);		
		//testcase 1:	ignore hazards when rs = rt = 0
		testcase++;
		fuif.MEMRegWr		=  1;
		fuif.WBRegWr		=  1;
		
		@(posedge CLK);	
		if (fuif.forwardselA == 0 && fuif.forwardselB == 0) begin
			$display("Passed testcase %d", testcase);
		end
		else begin
			$display("Failed testcase %d", testcase);
		end

		@(posedge CLK);		
		//testcase 2:	when rs == MEMwsel 
		testcase++;
		fuif.MEMRegWr		= 		 1;
		fuif.WBRegWr		=  		 0;
		fuif.id_ex_rs		=		5'd4;
		fuif.MEMwsel		=		5'd4;
		
		@(posedge CLK);	
		if (fuif.forwardselA == 2 && fuif.forwardselB == 0) begin
			$display("Passed testcase %d", testcase);
		end
		else begin
			$display("Failed testcase %d", testcase);
		end

		@(posedge CLK);		
		//testcase 3:	when rs == MEMwsel and instr is lui 
		testcase++;
		fuif.MEMRegWr		= 		 1;
		fuif.WBRegWr		=  		 0;
		fuif.id_ex_rs		=		5'd4;
		fuif.MEMwsel		=		5'd4;
		fuif.MEMlui			=			 1;
		
		@(posedge CLK);	
		if (fuif.forwardselA == 3 && fuif.forwardselB == 0) begin
			$display("Passed testcase %d", testcase);
		end
		else begin
			$display("Failed testcase %d", testcase);
		end

		@(posedge CLK);		
		//testcase 4:	when rt == MEMwsel 
		testcase++;
		fuif.MEMRegWr		= 		 1;
		fuif.WBRegWr		=  		 0;
		fuif.id_ex_rs		=		5'd4;
		fuif.id_ex_rt		=		5'd5;
		fuif.MEMwsel		=		5'd5;
		fuif.MEMlui			=			 0;
		
		@(posedge CLK);	
		if (fuif.forwardselA == 0 && fuif.forwardselB == 2) begin
			$display("Passed testcase %d", testcase);
		end
		else begin
			$display("Failed testcase %d", testcase);
		end

		@(posedge CLK);		
		//testcase 5:	when rt == MEMwsel and instr is lui 
		testcase++;
		fuif.MEMRegWr		= 		 1;
		fuif.WBRegWr		=  		 0;
		fuif.id_ex_rs		=		5'd4;
		fuif.id_ex_rt		=		5'd5;
		fuif.MEMwsel		=		5'd5;
		fuif.MEMlui			=			 1;
		
		@(posedge CLK);	
		if (fuif.forwardselA == 0 && fuif.forwardselB == 3) begin
			$display("Passed testcase %d", testcase);
		end
		else begin
			$display("Failed testcase %d", testcase);
		end

		@(posedge CLK);		
		//testcase 6:	when rs == WBsel
		testcase++;
		fuif.MEMRegWr		= 		 0;
		fuif.WBRegWr		=  		 1;
		fuif.id_ex_rs		=		5'd4;
		fuif.id_ex_rt		=		5'd5;
		fuif.WBwsel			=		5'd4;
		fuif.MEMlui			=			 0;
		
		@(posedge CLK);	
		if (fuif.forwardselA == 1 && fuif.forwardselB == 0) begin
			$display("Passed testcase %d", testcase);
		end
		else begin
			$display("Failed testcase %d", testcase);
		end

		@(posedge CLK);		
		//testcase 7:	when rt == WBsel
		testcase++;
		fuif.MEMRegWr		= 		 0;
		fuif.WBRegWr		=  		 1;
		fuif.id_ex_rs		=		5'd4;
		fuif.id_ex_rt		=		5'd5;
		fuif.WBwsel			=		5'd5;
		fuif.MEMlui			=			 0;
		
		@(posedge CLK);	
		if (fuif.forwardselA == 0 && fuif.forwardselB == 1) begin
			$display("Passed testcase %d", testcase);
		end
		else begin
			$display("Failed testcase %d", testcase);
		end


		@(posedge CLK);		
		//testcase 8:	when both MEMRegWr and WBRegWr are asserted and when rs == WBsel, when rt == MEMwsel
		testcase++;
		fuif.MEMRegWr		= 		 1;
		fuif.WBRegWr		=  		 1;
		fuif.id_ex_rs		=		5'd4;
		fuif.id_ex_rt		=		5'd5;
		fuif.WBwsel			=		5'd4;
		fuif.MEMwsel		=		5'd5;
		fuif.MEMlui			=			 0;
		
		@(posedge CLK);	
		if (fuif.forwardselA == 1 && fuif.forwardselB == 2) begin
			$display("Passed testcase %d", testcase);
		end
		else begin
			$display("Failed testcase %d", testcase);
		end

		@(posedge CLK);		
		//testcase 9:	when both MEMRegWr and WBRegWr are deasserted and when rs == WBsel, when rt == MEMwsel
		testcase++;
		fuif.MEMRegWr		= 		 0;
		fuif.WBRegWr		=  		 0;
		fuif.id_ex_rs		=		5'd4;
		fuif.id_ex_rt		=		5'd5;
		fuif.WBwsel			=		5'd4;
		fuif.MEMwsel		=		5'd5;
		fuif.MEMlui			=			 0;
		
		@(posedge CLK);	
		if (fuif.forwardselA == 0 && fuif.forwardselB == 0) begin
			$display("Passed testcase %d", testcase);
		end
		else begin
			$display("Failed testcase %d", testcase);
		end
	end

endprogram

