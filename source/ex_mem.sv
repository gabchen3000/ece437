// interface include
`include "ex_mem_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module ex_mem (
  input logic CLK, nRST,
  ex_mem_if.a3 exmem_if
);

// import types
  import cpu_types_pkg::*;

always_ff @(posedge CLK, negedge nRST) begin

  // if reset then set to 0
  if (nRST == 0) begin
    exmem_if.exmem_op_npc         <=  '0;
    exmem_if.exmem_op_imemload    <=  '0;
    exmem_if.exmem_op_branchaddr  <=  '0;
    exmem_if.exmem_op_RegWr       <=  '0;
    exmem_if.exmem_op_MemtoReg    <=  '0;
    exmem_if.exmem_op_jal         <=  '0;
    exmem_if.exmem_op_jr          <=  '0;
    exmem_if.exmem_op_halt        <=  '0;
    exmem_if.exmem_op_lui         <=  '0;
    exmem_if.exmem_op_imemREN     <=  '0;
    exmem_if.exmem_op_branch      <=  '0;
    exmem_if.exmem_op_jump        <=  '0;
    exmem_if.exmem_op_bne         <=  '0;
    exmem_if.exmem_op_beq         <=  '0;
    exmem_if.exmem_op_rdat1       <=  '0;
    exmem_if.exmem_op_rdat2       <=  '0;
    exmem_if.exmem_op_ALUOUT      <=  '0;
    exmem_if.exmem_op_ZERO        <=  '0;
    exmem_if.exmem_op_wsel        <=  '0;
  end
  //  if opcode is not LW and not SW then wait for ihit to update
  else if (exmem_if.exmem_ip_ihit) begin
    exmem_if.exmem_op_npc         <=    exmem_if.exmem_ip_npc;
    exmem_if.exmem_op_imemload    <=    exmem_if.exmem_ip_imemload;
    exmem_if.exmem_op_branchaddr  <=    exmem_if.exmem_ip_branchaddr;
    exmem_if.exmem_op_RegWr       <=    exmem_if.exmem_ip_RegWr;
    exmem_if.exmem_op_MemtoReg    <=    exmem_if.exmem_ip_MemtoReg;
    exmem_if.exmem_op_jal         <=    exmem_if.exmem_ip_jal;
    exmem_if.exmem_op_jr          <=    exmem_if.exmem_ip_jr;
    exmem_if.exmem_op_halt        <=    exmem_if.exmem_ip_halt;
    exmem_if.exmem_op_lui         <=    exmem_if.exmem_ip_lui;
    exmem_if.exmem_op_imemREN     <=    1;
    exmem_if.exmem_op_branch      <=    exmem_if.exmem_ip_branch;
    exmem_if.exmem_op_jump        <=    exmem_if.exmem_ip_jump;
    exmem_if.exmem_op_bne         <=    exmem_if.exmem_ip_bne;
    exmem_if.exmem_op_beq         <=    exmem_if.exmem_ip_beq;
    exmem_if.exmem_op_rdat1       <=    exmem_if.exmem_ip_rdat1;
    exmem_if.exmem_op_rdat2       <=    exmem_if.exmem_ip_rdat2;
    exmem_if.exmem_op_ALUOUT      <=    exmem_if.exmem_ip_ALUOUT;
    exmem_if.exmem_op_ZERO        <=    exmem_if.exmem_ip_ZERO;
    exmem_if.exmem_op_wsel        <=    exmem_if.exmem_ip_wsel;
  end
  //  if opcode is LW or SW then wait for dhit to update
  /*else if ((exmem_if.exmem_ip_imemload[31:26] == SW ||
            exmem_if.exmem_ip_imemload[31:26] == LW)
            && (exmem_if.exmem_ip_dhit)) begin
    exmem_if.exmem_op_npc         <=    exmem_if.exmem_ip_npc;
    exmem_if.exmem_op_imemload    <=    exmem_if.exmem_ip_imemload;
    exmem_if.exmem_op_branchaddr  <=    exmem_if.exmem_ip_branchaddr;
    exmem_if.exmem_op_dmemREN     <=    0;
    exmem_if.exmem_op_dmemWEN     <=    0;
    exmem_if.exmem_op_RegWr       <=    exmem_if.exmem_ip_RegWr;
    exmem_if.exmem_op_MemtoReg    <=    exmem_if.exmem_ip_MemtoReg;
    exmem_if.exmem_op_jal         <=    exmem_if.exmem_ip_jal;
    exmem_if.exmem_op_jr          <=    exmem_if.exmem_ip_jr;
    exmem_if.exmem_op_halt        <=    exmem_if.exmem_ip_halt;
    exmem_if.exmem_op_lui         <=    exmem_if.exmem_ip_lui;
    exmem_if.exmem_op_imemREN     <=    1;
    exmem_if.exmem_op_branch      <=    exmem_if.exmem_ip_branch;
    exmem_if.exmem_op_jump        <=    exmem_if.exmem_ip_jump;
    exmem_if.exmem_op_bne         <=    exmem_if.exmem_ip_bne;
    exmem_if.exmem_op_beq         <=    exmem_if.exmem_ip_beq;
    exmem_if.exmem_op_rdat1       <=    exmem_if.exmem_ip_rdat1;
    exmem_if.exmem_op_rdat2       <=    exmem_if.exmem_ip_rdat2;
    exmem_if.exmem_op_ALUOUT      <=    exmem_if.exmem_ip_ALUOUT;
    exmem_if.exmem_op_ZERO        <=    exmem_if.exmem_ip_ZERO;
    exmem_if.exmem_op_wsel        <=    exmem_if.exmem_ip_wsel;
  end*/
  //  else just keep things same as before
  else  begin
    exmem_if.exmem_op_npc         <=    exmem_if.exmem_op_npc;
    exmem_if.exmem_op_imemload    <=    exmem_if.exmem_op_imemload;
    exmem_if.exmem_op_branchaddr  <=    exmem_if.exmem_op_branchaddr;
    exmem_if.exmem_op_RegWr       <=    exmem_if.exmem_op_RegWr;
    exmem_if.exmem_op_MemtoReg    <=    exmem_if.exmem_op_MemtoReg;
    exmem_if.exmem_op_jal         <=    exmem_if.exmem_op_jal;
    exmem_if.exmem_op_jr          <=    exmem_if.exmem_op_jr;
    exmem_if.exmem_op_halt        <=    exmem_if.exmem_op_halt;
    exmem_if.exmem_op_lui         <=    exmem_if.exmem_op_lui;
    exmem_if.exmem_op_imemREN     <=    1;
    exmem_if.exmem_op_branch      <=    exmem_if.exmem_op_branch;
    exmem_if.exmem_op_jump        <=    exmem_if.exmem_op_jump;
    exmem_if.exmem_op_bne         <=    exmem_if.exmem_op_bne;
    exmem_if.exmem_op_beq         <=    exmem_if.exmem_op_beq;
    exmem_if.exmem_op_rdat1       <=    exmem_if.exmem_op_rdat1;
    exmem_if.exmem_op_rdat2       <=    exmem_if.exmem_op_rdat2;
    exmem_if.exmem_op_ALUOUT      <=    exmem_if.exmem_op_ALUOUT;
    exmem_if.exmem_op_ZERO        <=    exmem_if.exmem_op_ZERO;
    exmem_if.exmem_op_wsel        <=    exmem_if.exmem_op_wsel;
  end
end

always_ff @(posedge CLK, negedge nRST) begin
	if (nRST == 0) begin
	  exmem_if.exmem_op_dmemREN     <=    0;
    exmem_if.exmem_op_dmemWEN     <=    0;
	end
	else if (exmem_if.exmem_ip_dhit) begin
	  exmem_if.exmem_op_dmemREN     <=    0;
    exmem_if.exmem_op_dmemWEN     <=    0;
	end
	else if (exmem_if.exmem_ip_ihit) begin
    exmem_if.exmem_op_dmemREN     <=    exmem_if.exmem_ip_dREN;
    exmem_if.exmem_op_dmemWEN     <=    exmem_if.exmem_ip_dWEN;
	end
	else begin
    exmem_if.exmem_op_dmemREN     <=    exmem_if.exmem_op_dmemREN;
    exmem_if.exmem_op_dmemWEN     <=    exmem_if.exmem_op_dmemWEN;
	end

end

endmodule
