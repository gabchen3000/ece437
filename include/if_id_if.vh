`ifndef IF_ID_IF_VH
`define IF_ID_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface if_id_if;
  // import types
  import cpu_types_pkg::*;

  //inputs
	logic ifid_ip_doflush, ifid_ip_ihit, ifid_ip_dhit;
	word_t ifid_ip_imemload, ifid_ip_npc;
	
	//outputs
	word_t ifid_op_npc, ifid_op_imemload;

  // if if latch ports
  modport a (
    input   ifid_ip_doflush, ifid_ip_ihit, ifid_ip_dhit,
    			  ifid_ip_imemload, ifid_ip_npc,
		output 	ifid_op_imemload, ifid_op_npc
  );
endinterface

`endif //IF_ID_IF_VH
