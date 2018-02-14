`ifndef FORWARD_IF_VH
`define FORWARD_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface forward_unit_if;
  // import types
  import cpu_types_pkg::*;

  //inputs
  logic [4:0] id_ex_rs, id_ex_rt, MEMwsel, WBwsel;
  logic MEMRegWr, WBRegWr;

  //outputs
  logic [1:0] forwardselA, forwardselB;

  modport fu (
    input id_ex_rs, id_ex_rt, MEMwsel, WBwsel, MEMRegWr, WBRegWr,
    output forwardselA, forwardselB
  );
endinterface

`endif //FORWARD_UNIT_IF_VH
