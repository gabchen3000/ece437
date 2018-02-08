`ifndef ID_EX_IF_VH
`define ID_EX_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface id_ex_if;
  // import types
  import cpu_types_pkg::*;

  //inputs
	
	//common/general
	logic idex_ip_doflush, idex_ip_ihit, idex_ip_dhit;
	word_t idex_ip_imemload, idex_ip_npc;
	
	//from control unit
	logic idex_ip_dREN, idex_ip_dWEN, idex_ip_RegWr, idex_ip_MemtoReg, idex_ip_jal, idex_ip_jr, idex_ip_halt, idex_ip_lui, idex_ip_imemREN, idex_ip_branch, idex_ip_jump, idex_ip_bne, idex_ip_beq;
	aluop_t				idex_ip_ALUOP;	
	logic [1:0]		idex_ip_RegDest, idex_ip_ALUSrc;		

	//all other
	word_t idex_ip_ext, idex_ip_rdat1, idex_ip_rdat2;
	logic [4:0] idex_ip_shamt;
	

	//outputs

	//common/general
	word_t idex_op_imemload, idex_op_npc;
	
	//from control unit
	logic idex_op_dREN, idex_op_dWEN, idex_op_RegWr, idex_op_MemtoReg, idex_op_jal, idex_op_jr, idex_op_halt, idex_op_lui, idex_op_imemREN, idex_op_branch, idex_op_jump, idex_op_bne, idex_op_beq;
	aluop_t				idex_op_ALUOP;	
	logic [1:0]		idex_op_RegDest, idex_op_ALUSrc;	
	
	//all other
	word_t idex_op_ext, idex_op_rdat1, idex_op_rdat2;
	logic [4:0] idex_op_shamt;

	
  // id ex latch ports
  modport a2 (
    input   idex_ip_doflush, idex_ip_ihit, idex_ip_dhit,
						idex_ip_imemload, idex_ip_npc,
						idex_ip_dREN, idex_ip_dWEN, idex_ip_RegWr, 		idex_ip_MemtoReg, idex_ip_jal, idex_ip_jr, idex_ip_halt, idex_ip_lui, idex_ip_imemREN, idex_ip_branch, idex_ip_jump, idex_ip_bne, idex_ip_beq,
						idex_ip_ext, idex_ip_rdat1, idex_ip_rdat2, idex_ip_shamt, idex_ip_RegDest, idex_ip_ALUSrc, idex_ip_ALUOP,
    output  idex_op_imemload, idex_op_npc,
						idex_op_dREN, idex_op_dWEN, idex_op_RegWr, 		idex_op_MemtoReg, idex_op_jal, idex_op_jr, idex_op_halt, idex_op_lui, idex_op_imemREN, idex_op_branch, idex_op_jump, idex_op_bne, idex_op_beq,
						idex_op_ext, idex_op_rdat1, idex_op_rdat2, idex_op_shamt, idex_op_RegDest, idex_op_ALUSrc, idex_op_ALUOP
  );
endinterface

`endif //ID_EX_IF_VH
