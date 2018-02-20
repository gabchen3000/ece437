`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface mem_wb_if;
  // import types
  import cpu_types_pkg::*;

  //inputs

  //common/general
  logic memwb_ip_ihit, memwb_ip_dhit, memwb_ip_halt;
  word_t memwb_ip_npc, memwb_ip_imemload, memwb_ip_dmemload;

  //from control unit
  logic memwb_ip_jal, memwb_ip_lui, memwb_ip_MemToReg, memwb_ip_RegWr;

  //all other
  word_t        memwb_ip_ALUOUT;
  logic [4:0]   memwb_ip_wsel;

  //outputs
  //common/general
  logic memwb_op_ihit, memwb_op_dhit, memwb_op_halt;
  word_t memwb_op_npc, memwb_op_imemload, memwb_op_dmemload;

  //from control unit
  logic memwb_op_jal, memwb_op_lui, memwb_op_MemToReg, memwb_op_RegWr;

  //all other
  word_t        memwb_op_ALUOUT;
  logic [4:0]   memwb_op_wsel;

  // ex mem latch ports
  modport a4(
   input  memwb_ip_ihit, memwb_ip_dhit, memwb_ip_halt,
          memwb_ip_npc, memwb_ip_imemload, memwb_ip_dmemload,
          memwb_ip_jal, memwb_ip_lui, memwb_ip_MemToReg, memwb_ip_RegWr,
          memwb_ip_ALUOUT,
          memwb_ip_wsel,
   output memwb_op_ihit, memwb_op_dhit, memwb_op_halt,
          memwb_op_npc, memwb_op_imemload, memwb_op_dmemload,
          memwb_op_jal, memwb_op_lui, memwb_op_MemToReg, memwb_op_RegWr,
          memwb_op_ALUOUT,
          memwb_op_wsel
  );

endinterface

`endif //MEM_WB_IF_VH
