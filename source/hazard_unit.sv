/*
hazard unit module
*/

// interface include
`include "hazard_unit_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module hazard_unit (
  input logic CLK, nRST,
  hazard_unit_if.hu huif
);

	//assign huif.IFdopause = ((huif.PCSrc == 3) ? 0 : 1);

	assign huif.IDdopause = ((huif.rs != 0) && (huif.MEMwsel == huif.rs) && huif.MEMRegWr && huif.ihit) ||
													((huif.rt != 0) && (huif.MEMwsel == huif.rt) && huif.MEMRegWr && huif.ihit) ||
													((huif.rs != 0) && (huif.EXwsel == huif.rs) && huif.EXRegWr && huif.ihit) ||
													((huif.rt != 0) && (huif.EXwsel == huif.rt) && huif.EXRegWr && huif.ihit);
/* ||
													((huif.rs != 0) && (huif.WBwsel == huif.rs) && huif.WBRegWr && huif.ihit) ||
													((huif.rt != 0) && (huif.WBwsel == huif.rt) && huif.WBRegWr && huif.ihit);
*/
endmodule
