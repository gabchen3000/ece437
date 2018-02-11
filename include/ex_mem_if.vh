`ifndef EX_MEM_IF_VH
`define EX_MEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface ex_mem_if;
  // import types
  import cpu_types_pkg::*;

  //inputs

  //common/general
  logic exmem_ip_doflush, exmem_ip_ihit, exmem_ip_dhit;
  word_t exmem_ip_npc, exmem_ip_imemload, exmem_ip_branchaddr;

  //from control unit
  logic exmem_ip_dREN, exmem_ip_dWEN, exmem_ip_RegWr, exmem_ip_MemtoReg,
        exmem_ip_jal, exmem_ip_jr, exmem_ip_halt, exmem_ip_lui, exmem_ip_imemREN,
        exmem_ip_branch, exmem_ip_jump, exmem_ip_bne, exmem_ip_beq;

  //all other
  word_t        exmem_ip_rdat1, exmem_ip_rdat2, exmem_ip_ALUOUT, exmem_ip_ZERO;
  logic [4:0]   exmem_ip_wsel;


  //outputs

  word_t exmem_op_npc, exmem_op_imemload, exmem_op_branchaddr;

  //from control unit
  logic exmem_op_dmemREN, exmem_op_dmemWEN, exmem_op_RegWr, exmem_op_MemtoReg,
        exmem_op_jal, exmem_op_jr, exmem_op_halt, exmem_op_lui, exmem_op_imemREN,
        exmem_op_branch, exmem_op_jump, exmem_op_bne, exmem_op_beq;


  //all other
  word_t        exmem_op_rdat1, exmem_op_rdat2, exmem_op_ALUOUT, exmem_op_ZERO;
  logic [4:0]   exmem_op_wsel;

  // id ex latch ports
  modport a3 (
    input exmem_ip_doflush, exmem_ip_ihit, exmem_ip_dhit,
          exmem_ip_npc, exmem_ip_imemload, exmem_ip_branchaddr,
          exmem_ip_dREN, exmem_ip_dWEN, exmem_ip_RegWr, exmem_ip_MemtoReg,
          exmem_ip_jal, exmem_ip_jr, exmem_ip_halt, exmem_ip_lui, exmem_ip_imemREN,
          exmem_ip_branch, exmem_ip_jump, exmem_ip_bne, exmem_ip_beq,
          exmem_ip_rdat1, exmem_ip_rdat2, exmem_ip_ALUOUT, exmem_ip_ZERO,
          exmem_ip_wsel,

    output exmem_op_npc, exmem_op_imemload, exmem_op_branchaddr,
        exmem_op_dmemREN, exmem_op_dmemWEN, exmem_op_RegWr, exmem_op_MemtoReg,
        exmem_op_jal, exmem_op_jr, exmem_op_halt, exmem_op_lui, exmem_op_imemREN,
        exmem_op_branch, exmem_op_jump, exmem_op_bne, exmem_op_beq,
        exmem_op_rdat1, exmem_op_rdat2, exmem_op_ALUOUT, exmem_op_ZERO,
        exmem_op_wsel
  );
endinterface

`endif //EX_MEM_IF_VH

