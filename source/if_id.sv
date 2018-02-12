/*
request unit module
*/

// interface include
`include "if_id_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module if_id (
  input logic CLK, nRST,
  if_id_if.a ifid_if
);

// import types
  import cpu_types_pkg::*;

always_ff @(posedge CLK, negedge nRST) begin

	// if reset then set to 0
	if (nRST == 0) begin
		ifid_if.ifid_op_npc <= '0;
		ifid_if.ifid_op_imemload <= '0;
	end
	// if ifiddopause then set to 0
	else if ((ifid_if.ifid_ip_ihit && ifid_if.ifid_ip_dopause) || ifid_if.ifid_ip_doflush) begin
		ifid_if.ifid_op_npc <= '0;
		ifid_if.ifid_op_imemload <= '0;
	end
	//if IDEXdopause, then send the same data as before
	else if (ifid_if.ifid_ip_ihit && !ifid_if.idex_ip_dopause) begin
		ifid_if.ifid_op_npc <= ifid_if.ifid_ip_npc;
		ifid_if.ifid_op_imemload <= ifid_if.ifid_ip_imemload;
	end
	//	else just keep things same as before
	else	begin
		ifid_if.ifid_op_npc <= ifid_if.ifid_op_npc;
		ifid_if.ifid_op_imemload <= ifid_if.ifid_op_imemload;
	end

end

endmodule
