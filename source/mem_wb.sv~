// interface include
`include "mem_wb_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module mem_wb (
  input logic CLK, nRST,
  mem_wb_if.a4 memwb_if
);

// import types
  import cpu_types_pkg::*;

always_ff @(posedge CLK, negedge nRST) begin

  // if reset then set to 0
  if (nRST == 0) begin
    memwb_if.memwb_op_npc         <=  '0;
    memwb_if.memwb_op_imemload    <=  '0;
    memwb_if.memwb_op_dmemload    <=  '0;
    memwb_if.memwb_op_jal         <=  '0;
    memwb_if.memwb_op_lui         <=  '0;
    memwb_if.memwb_op_MemToReg    <=  '0;
    memwb_if.memwb_op_RegWr       <=  '0;
    memwb_if.memwb_op_ALUOUT      <=  '0;
    memwb_if.memwb_op_wsel        <=  '0;
		memwb_if.memwb_op_halt        <=  '0;
 end
  //  if opcode is LW or SW then wait for dhit to update
  else if ((memwb_if.memwb_ip_imemload[31:26] == SW ||
            memwb_if.memwb_ip_imemload[31:26] == LW)
            && (memwb_if.memwb_ip_dhit)) begin
    memwb_if.memwb_op_npc         <=    memwb_if.memwb_ip_npc;
    memwb_if.memwb_op_imemload    <=    memwb_if.memwb_ip_imemload;
    memwb_if.memwb_op_dmemload    <=    memwb_if.memwb_ip_dmemload;
    memwb_if.memwb_op_jal         <=    memwb_if.memwb_ip_jal;
    memwb_if.memwb_op_lui         <=    memwb_if.memwb_ip_lui;
    memwb_if.memwb_op_MemToReg    <=    memwb_if.memwb_ip_MemToReg;
    memwb_if.memwb_op_RegWr       <=    memwb_if.memwb_ip_RegWr;
    memwb_if.memwb_op_ALUOUT      <=    memwb_if.memwb_ip_ALUOUT;
    memwb_if.memwb_op_wsel        <=    memwb_if.memwb_ip_wsel;
    memwb_if.memwb_op_halt        <=    memwb_if.memwb_ip_halt;
  end
  //  if opcode is not LW and not SW then wait for ihit to update
  else if (memwb_if.memwb_ip_ihit) begin
    memwb_if.memwb_op_npc         <=    memwb_if.memwb_ip_npc;
    memwb_if.memwb_op_imemload    <=    memwb_if.memwb_ip_imemload;
    memwb_if.memwb_op_dmemload    <=    memwb_if.memwb_op_dmemload;	//ihit shouldnt change dmemload at all
    memwb_if.memwb_op_jal         <=    memwb_if.memwb_ip_jal;
    memwb_if.memwb_op_lui         <=    memwb_if.memwb_ip_lui;
    memwb_if.memwb_op_MemToReg    <=    memwb_if.memwb_ip_MemToReg;
    memwb_if.memwb_op_RegWr       <=    memwb_if.memwb_ip_RegWr;
    memwb_if.memwb_op_ALUOUT      <=    memwb_if.memwb_ip_ALUOUT;
    memwb_if.memwb_op_wsel        <=    memwb_if.memwb_ip_wsel;
    memwb_if.memwb_op_halt        <=    memwb_if.memwb_ip_halt;
	end
  //  else just keep things same as before
  else  begin
    memwb_if.memwb_op_npc         <=    memwb_if.memwb_op_npc;
    memwb_if.memwb_op_imemload    <=    memwb_if.memwb_op_imemload;
    memwb_if.memwb_op_dmemload    <=    memwb_if.memwb_op_dmemload;
    memwb_if.memwb_op_jal         <=    memwb_if.memwb_op_jal;
    memwb_if.memwb_op_lui         <=    memwb_if.memwb_op_lui;
    memwb_if.memwb_op_MemToReg    <=    memwb_if.memwb_op_MemToReg;
    memwb_if.memwb_op_RegWr       <=    memwb_if.memwb_op_RegWr;
    memwb_if.memwb_op_ALUOUT      <=    memwb_if.memwb_op_ALUOUT;
    memwb_if.memwb_op_wsel        <=    memwb_if.memwb_op_wsel;
    memwb_if.memwb_op_halt        <=    memwb_if.memwb_op_halt;
  end

end

	assign memwb_if.memwb_op_ihit        =    memwb_if.memwb_ip_ihit;
	assign memwb_if.memwb_op_dhit        =    memwb_if.memwb_ip_dhit;
endmodule


