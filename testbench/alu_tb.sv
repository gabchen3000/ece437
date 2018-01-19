/*
  alu test bench
*/

// mapped needs this
`include "alu_if.vh"
`include "cpu_types_pkg.vh"
// import types
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  //int v1 = 1;
  //int v2 = 4721;
  //int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if aif ();
  // test program
  test PROG (CLK, aif);
  // DUT
`ifndef MAPPED
  alu DUT(aif);
`else
  alu DUT(
    .\aif.ALUOP (aif.ALUOP),
    .\aif.PORT_A (aif.PORT_A),
    .\aif.PORT_B (aif.PORT_B),
    .\aif.OUT (aif.OUT),
    .\aif.NEG (aif.NEG),
    .\aif.OVERFLOW (aif.OVERFLOW),
    .\aif.ZERO (aif.ZERO)
  );
`endif

endmodule

program test(
	input logic CLK,
	alu_if.tb aiftb
);


	parameter PERIOD = 10;

	initial begin
    
		#(PERIOD) //waits a while
/*
testcase:
    ALU_SLL
    ALU_SRL
    ALU_ADD
    ALU_SUB
    ALU_AND
    ALU_OR
    ALU_XOR
    ALU_NOR
    ALU_SLT
    ALU_SLTU
*/
		//case 1 SLL
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_SLL;
		aiftb.PORT_A = '1;
		aiftb.PORT_B = '0;
		@(posedge CLK);
		if (aiftb.OUT == (aiftb.PORT_A<<aiftb.PORT_B)) begin
			$display("==Case 1 is correct==");
		end
		else begin
			$display("----------------Case 1 is wrong, OUT = %h", aiftb.OUT);
		end 
		
		//case 2 SRL
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_SRL;
		aiftb.PORT_A = '1;
		aiftb.PORT_B = '0;
		@(posedge CLK);
		if (aiftb.OUT == (aiftb.PORT_A>>aiftb.PORT_B)) begin
			$display("==Case 2 is correct==");
		end
		else begin
			$display("----------------Case 2 is wrong, OUT = %h", aiftb.OUT);
		end 

		//case 3 ADD ++ overflow
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_ADD;
		aiftb.PORT_A = 32'h7fffffff;
		aiftb.PORT_B = 32'h7fffffff;
		@(posedge CLK);
		if (aiftb.OUT == ($signed(aiftb.PORT_A) + $signed(aiftb.PORT_B))) begin
			$display("==Case 3.0 is correct==");
		end
		else begin
			$display("----------------Case 3.0 is wrong, OUT = %h", aiftb.OUT);
		end 
		if (aiftb.OVERFLOW == 1) begin
			$display("==Case 3.1 is correct==");
		end
		else begin
			$display("----------------Case 3.1 is wrong, OVERFLOW = %h", aiftb.OVERFLOW);
		end 

		//case 4 ADD ++ no overflow
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_ADD;
		aiftb.PORT_A = 32'h000010ff;
		aiftb.PORT_B = 32'h000103fa;
		@(posedge CLK);
		if (aiftb.OUT == ($signed(aiftb.PORT_A) + $signed(aiftb.PORT_B))) begin
			$display("==Case 4.0 is correct==");
		end
		else begin
			$display("----------------Case 4.0 is wrong, OUT = %h", aiftb.OUT);
		end 
		if (aiftb.OVERFLOW == 0) begin
			$display("==Case 4.1 is correct==");
		end
		else begin
			$display("----------------Case 4.1 is wrong, OVERFLOW = %h", aiftb.OVERFLOW);
		end 

		//case 5 ADD -- overflow
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_ADD;
		aiftb.PORT_A = 32'h80000000;
		aiftb.PORT_B = 32'h80000001;
		@(posedge CLK);
		if (aiftb.OUT == ($signed(aiftb.PORT_A) + $signed(aiftb.PORT_B))) begin
			$display("==Case 5.0 is correct==");
		end
		else begin
			$display("----------------Case 5.0 is wrong, OUT = %h", aiftb.OUT);
		end 
		if (aiftb.OVERFLOW == 1) begin
			$display("==Case 5.1 is correct==");
		end
		else begin
			$display("----------------Case 5.1 is wrong, OVERFLOW = %h", aiftb.OVERFLOW);
		end 

		//case 6 SUB -- no overflow
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_SUB;
		aiftb.PORT_A = 32'hffffffff;
		aiftb.PORT_B = 32'hfffffffe;
		@(posedge CLK);
		if (aiftb.OUT == ($signed(aiftb.PORT_A) - $signed(aiftb.PORT_B))) begin
			$display("==Case 6.0 is correct==");
		end
		else begin
			$display("----------------Case 6.0 is wrong, OUT = %h", aiftb.OUT);
		end 
		if (aiftb.OVERFLOW == 0) begin
			$display("==Case 6.1 is correct==");
		end
		else begin
			$display("----------------Case 6.1 is wrong, OVERFLOW = %h", aiftb.OVERFLOW);
		end 

		//case 7 SUB +- overflow, check for negative as well
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_SUB;
		aiftb.PORT_A = 32'h7fffffff;
		aiftb.PORT_B = 32'hffffffff;
		@(posedge CLK);
		if (aiftb.OUT == ($signed(aiftb.PORT_A) - $signed(aiftb.PORT_B))) begin
			$display("==Case 7.0 is correct==");
		end
		else begin
			$display("----------------Case 7.0 is wrong, OUT = %h", aiftb.OUT);
		end 
		if (aiftb.OVERFLOW == 1) begin
			$display("==Case 7.1 is correct==");
		end
		else begin
			$display("----------------Case 7.1 is wrong, OVERFLOW = %h", aiftb.OVERFLOW);
		end 
		if (aiftb.NEG == 1) begin
			$display("==Case 7.2 is correct==");
		end
		else begin
			$display("----------------Case 7.2 is wrong, NEG = %h", aiftb.NEG);
		end 

		//case 8 AND
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_AND;
		aiftb.PORT_A = 32'hffffffff;
		aiftb.PORT_B = 32'haaaaaaaa;
		@(posedge CLK);
		if (aiftb.OUT == (aiftb.PORT_A & aiftb.PORT_B)) begin
			$display("==Case 8.0 is correct==");
		end
		else begin
			$display("----------------Case 8.0 is wrong, OUT = %h", aiftb.OUT);
		end 

		//case 9 OR
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_OR;
		aiftb.PORT_A = 32'h55555555;
		aiftb.PORT_B = 32'haaaaaaaa;
		@(posedge CLK);
		if (aiftb.OUT == (aiftb.PORT_A | aiftb.PORT_B)) begin
			$display("==Case 9.0 is correct==");
		end
		else begin
			$display("----------------Case 9.0 is wrong, OUT = %h", aiftb.OUT);
		end 

		//case 10 XOR
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_XOR;
		aiftb.PORT_A = 32'h55555552;
		aiftb.PORT_B = 32'haaaaaaa2;
		@(posedge CLK);
		if (aiftb.OUT == (aiftb.PORT_A ^ aiftb.PORT_B)) begin
			$display("==Case 10.0 is correct==");
		end
		else begin
			$display("----------------Case 10.0 is wrong, OUT = %h", aiftb.OUT);
		end 

		//case 11 NOR
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_NOR;
		aiftb.PORT_A = 32'h55555555;
		aiftb.PORT_B = 32'haaaaaaaa;
		@(posedge CLK);
		if (aiftb.OUT == ~(aiftb.PORT_A | aiftb.PORT_B)) begin
			$display("==Case 11.0 is correct==");
		end
		else begin
			$display("----------------Case 11.0 is wrong, OUT = %h", aiftb.OUT);
		end 

		//case 12 SLT
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_SLT;
		aiftb.PORT_A = 32'hf00001de;
		aiftb.PORT_B = 32'h0000ffff;
		@(posedge CLK);
		if (aiftb.OUT == ($signed(aiftb.PORT_A) < $signed(aiftb.PORT_B))) begin
			$display("==Case 12.0 is correct==");
		end
		else begin
			$display("----------------Case 12.0 is wrong, OUT = %h", aiftb.OUT);
		end 

		//case 13 SLTU
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_SLTU;
		aiftb.PORT_A = 32'hf00001de;
		aiftb.PORT_B = 32'h0000ffff;
		@(posedge CLK);
		if (aiftb.OUT == (aiftb.PORT_A < aiftb.PORT_B)) begin
			$display("==Case 13.0 is correct==");
		end
		else begin
			$display("----------------Case 13.0 is wrong, OUT = %h", aiftb.OUT);
		end 

		//case 14 ZERO
		#(PERIOD);
		@(posedge CLK);
		aiftb.ALUOP = ALU_ADD;
		aiftb.PORT_A = '0;
		aiftb.PORT_B = '0;
		@(posedge CLK);
		if (aiftb.OUT == 0) begin
			$display("==Case 14.0 is correct==");
		end
		else begin
			$display("----------------Case 14.0 is wrong, OUT = %h", aiftb.OUT);
		end 
		if (aiftb.ZERO == 1) begin
			$display("==Case 14.1 is correct==");
		end
		else begin
			$display("----------------Case 14.1 is wrong, ZERO = %h", aiftb.ZERO);
		end 

  end

endprogram
