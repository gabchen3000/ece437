/*
program counter module
*/

// interface include
`include "program_counter_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module program_counter (
  input logic CLK, nRST,
  program_counter_if.pc pcif
);

  // import types
  import cpu_types_pkg::*;

	assign pcif.npc = pcif.cur_pc + 4;

	always_ff @(posedge CLK, negedge nRST) begin

		if (nRST == 0) begin
			pcif.cur_pc <= 0;
		end
		else if (pcif.IDdopause || pcif.IFdopause) begin
			pcif.cur_pc <= pcif.cur_pc;
		end
		else if (pcif.ihit) begin
			pcif.cur_pc <= pcif.next_pc;
		end

	end

endmodule
