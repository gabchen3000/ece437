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
	// if doflush then set to 0
	else if (ifid_if.ifid_ip_doflush) begin
		ifid_if.ifid_op_npc <= '0;
		ifid_if.ifid_op_imemload <= '0;
	end
	//	if opcode is not LW and not SW then wait for ihit to update
	else if (ifid_if.ifid_ip_ihit) begin
		ifid_if.ifid_op_npc <= ifid_if.ifid_ip_npc;
		ifid_if.ifid_op_imemload <= ifid_if.ifid_ip_imemload;
	end
	//	if opcode is LW or SW then wait for dhit to update
	/*else if ((ifid_if.ifid_ip_imemload[31:26] == SW || ifid_if.ifid_ip_imemload[31:26] == LW) 
						&& (ifid_if.ifid_ip_dhit)) begin
		ifid_if.ifid_op_npc <= ifid_if.ifid_ip_npc;
		ifid_if.ifid_op_imemload <= ifid_if.ifid_ip_imemload;
	end*/
	//	else just keep things same as before
	else	begin
		ifid_if.ifid_op_npc <= ifid_if.ifid_op_npc;
		ifid_if.ifid_op_imemload <= ifid_if.ifid_op_imemload;
	end

end

endmodule