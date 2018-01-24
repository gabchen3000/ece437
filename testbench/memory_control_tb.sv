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
  cache_control_if #(.CPUS(1)) ccif (cif0, cif1);
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

`ifndef MAPPED
  ram DUTR(CLK, nRST, ramif);
`else
  ram DUTR(
		.\CLK (CLK),
		.\nRST (nRST),
		.\ramif.ramaddr (ramif.ramaddr),
		.\ramif.ramstore (ramif.ramstore),
		.\ramif.ramREN (ramif.ramREN),
		.\ramif.ramWEN (ramif.ramWEN),
		.\ramif.ramstate (ramif.ramstate),
		.\ramif.ramload (ramif.ramload)
);
`endif

assign ramif.ramaddr = ccif.ramaddr;
assign ramif.ramstore = ccif.ramstore;
assign ramif.ramREN = ccif.ramREN;
assign ramif.ramWEN = ccif.ramWEN;
assign ccif.ramload = ramif.ramload;
assign ccif.ramstate = ramif.ramstate;

endmodule

program test(
	input logic CLK,
	output logic nRST,
	cache_control_if ccif
);

	parameter PERIOD = 10;

	initial begin
    nRST = 0;
		#(PERIOD);
		#(PERIOD);
		#(PERIOD);
		nRST = 1;

		//initialize cache values
		cif0.iREN = 0;
		cif0.dREN = 0;
		cif0.dWEN = 0;
		cif0.iaddr = 0;
		cif0.daddr = 0;
		cif0.dstore = 0;
		@(posedge CLK);		

		#(PERIOD);
		@(posedge CLK);

		//store data

		//initialize cache values
		cif0.iREN = 0;
		cif0.dREN = 0;
		cif0.dWEN = 0;
		cif0.iaddr = 0;
		cif0.daddr = 0;
		cif0.dstore = 0;
		@(posedge CLK);		

		//Store datas on first two address
		cif0.dWEN = 1;
		cif0.daddr = 32'd0; //store data on first address
		cif0.dstore = 32'hfffffff0; //store hex fffffff0 on first address
		@(negedge cif0.dwait);
		if (ccif.ramload == cif0.dload && ccif.ramstore == cif0.dstore) begin
			$display("==Case 1 is correct==, ramload = %h, dload = %h, ramstore = %h, dstore = %h", ccif.ramload, cif0.dload, ccif.ramstore, cif0.dstore);
		end
		else begin
			$display("-----------case 1 is incorrect, ramload = %h, iload = %h, ramstore = %h, dstore = %h", ccif.ramload, cif0.dload, ccif.ramstore, cif0.dstore);
		end

		@(posedge CLK);
		cif0.dWEN = 1;
		cif0.daddr = 32'd4; //store data on first address
		cif0.dstore = 32'haaaaaaaa; //store hex aaaaaaaa on second address
		@(negedge cif0.dwait);
		if (ccif.ramload == cif0.dload && ccif.ramstore == cif0.dstore) begin
			$display("==Case 2 is correct==, ramload = %h, dload = %h, ramstore = %h, dstore = %h", ccif.ramload, cif0.dload, ccif.ramstore, cif0.dstore);
		end
		else begin
			$display("-----------case 2 is incorrect, ramload = %h, iload = %h, ramstore = %h, dstore = %h", ccif.ramload, cif0.dload, ccif.ramstore, cif0.dstore);
		end

		@(posedge CLK);
		//fetch instruction (this read should be whatever I wrote on the previous test case (aaaaaaaa)
		cif0.dWEN = 0;
		cif0.iREN = 1;
		cif0.iaddr = 32'd4; //second address, 4 bytes per address
		@(negedge cif0.iwait);
		if (cif0.iload == 32'haaaaaaaa) begin
			$display("==Case 3 is correct==, iload = %h", cif0.iload);
		end
		else begin
			$display("-----------case 3 is incorrect, ramload = %h, iload = %h", ccif.ramload, cif0.iload);
		end

		//assert both iREN and dREN
		//initialize cache values
		cif0.iREN = 0;
		cif0.dREN = 0;
		cif0.dWEN = 0;
		cif0.iaddr = 0;
		cif0.daddr = 0;
		cif0.dstore = 0;
		@(posedge CLK);		

		cif0.iREN = 1;
		cif0.dREN = 1;
		cif0.iaddr = 32'd0; //fetch instruction in first address
		cif0.daddr = 32'd12; //read data on fourth address
		@(negedge cif0.dwait);
		if (ccif.ramload == cif0.dload) begin
			$display("==Case 4 is correct==, ramload = %h, dload = %h", ccif.ramload, cif0.dload);
		end
		else begin
			$display("-----------case 4 is incorrect, ramload = %h, iload = %h", ccif.ramload, cif0.dload);
		end
		if (cif0.iwait == 1) begin
			$display("==Case 5 is correct==, iwait is 1");
		end
		else begin
			$display("-----------case 5 is incorrect, iwait is 0");
		end

		//deassert dREN to allow read instruction
		@(posedge CLK)
		cif0.dREN = 0;
		@(negedge cif0.iwait);
		if (cif0.iload == 32'hfffffff0) begin
			$display("==Case 6 is correct==, ramload = %h, iload = %h", ccif.ramload, cif0.iload);
		end
		else begin
			$display("-----------case 6 is incorrect, ramload = %h, iload = %h", ccif.ramload, cif0.iload);
		end
		if (cif0.dwait == 1) begin
			$display("==Case 5 is correct==, dwait is 1");
		end
		else begin
			$display("-----------case 5 is incorrect, dwait is 0");
		end


		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		@(posedge CLK);
		//call dump memory
		//this will show the changes made in the stores
		dump_memory();
	end


	task automatic dump_memory();
		string filename = "memcpu.hex";
		int memfd;

		cif0.dREN = 0;
		cif0.dWEN = 0;
		cif0.daddr = 0;

		memfd = $fopen(filename,"w");
		if (memfd)
		  $display("Starting memory dump.");
		else
		  begin $display("Failed to open %s.",filename); $finish; end

		for (int unsigned i = 0; memfd && i < 16384; i++)
		begin
		  int chksum = 0;
		  bit [7:0][7:0] values;
		  string ihex;

		  cif0.daddr = i << 2;
		  cif0.dREN = 1;
		  repeat (4) @(posedge CLK);
		  if (cif0.dload === 0)
		    continue;
		  values = {8'h04,16'(i),8'h00,cif0.dload};
		  foreach (values[j])
		    chksum += values[j];
		  chksum = 16'h100 - chksum;
		  ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
		  $fdisplay(memfd,"%s",ihex.toupper());
		end //for
		if (memfd)
		begin
		  cif0.dREN = 0;
		  $fdisplay(memfd,":00000001FF");
		  $fclose(memfd);
		  $display("Finished memory dump.");
		end
	endtask

endprogram

