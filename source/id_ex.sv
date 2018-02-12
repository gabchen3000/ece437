// interface include
`include "id_ex_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module id_ex (
  input logic CLK, nRST,
  id_ex_if.a2 idex_if
);

// import types
  import cpu_types_pkg::*;

always_ff @(posedge CLK, negedge nRST) begin

	// if reset then set to 0
	if (nRST == 0) begin
		idex_if.idex_op_npc <= '0;
		idex_if.idex_op_imemload <= '0;
		idex_if.idex_op_dREN <= '0;
 		idex_if.idex_op_dWEN <= '0;
		idex_if.idex_op_RegWr <= '0;
 		idex_if.idex_op_MemtoReg <= '0;
	 	idex_if.idex_op_jal <= '0;
		idex_if.idex_op_jr <= '0;
	 	idex_if.idex_op_halt <= '0;
		idex_if.idex_op_lui <= '0;
		idex_if.idex_op_imemREN <= '0;
		idex_if.idex_op_branch <= '0;
	 	idex_if.idex_op_jump <= '0;
	 	idex_if.idex_op_bne <= '0;
		idex_if.idex_op_beq <= '0;
		idex_if.idex_op_ext <= '0;
	 	idex_if.idex_op_rdat1 <= '0;
	 	idex_if.idex_op_rdat2 <= '0;
	 	idex_if.idex_op_shamt <= '0;
		idex_if.idex_op_RegDest <= '0;
		idex_if.idex_op_ALUSrc <= '0;
	end
	// if doflush or dopause then set to 0
	else if (idex_if.idex_ip_ihit && (idex_if.idex_ip_dopause || idex_if.idex_ip_doflush)) begin
		idex_if.idex_op_npc <= '0;
		idex_if.idex_op_imemload <= '0;
		idex_if.idex_op_dREN <= '0;
 		idex_if.idex_op_dWEN <= '0;
		idex_if.idex_op_RegWr <= '0;
 		idex_if.idex_op_MemtoReg <= '0;
	 	idex_if.idex_op_jal <= '0;
		idex_if.idex_op_jr <= '0;
	 	idex_if.idex_op_halt <= '0;
		idex_if.idex_op_lui <= '0;
		idex_if.idex_op_imemREN <= '0;
		idex_if.idex_op_branch <= '0;
	 	idex_if.idex_op_jump <= '0;
	 	idex_if.idex_op_bne <= '0;
		idex_if.idex_op_beq <= '0;
		idex_if.idex_op_ext <= '0;
	 	idex_if.idex_op_rdat1 <= '0;
	 	idex_if.idex_op_rdat2 <= '0;
	 	idex_if.idex_op_shamt <= '0;
		idex_if.idex_op_RegDest <= '0;
		idex_if.idex_op_ALUSrc <= '0;
		idex_if.idex_op_ALUOP[3:0] <= '0;
	end

	//	if opcode is not LW and not SW then wait for ihit to update
	else if (idex_if.idex_ip_ihit && !idex_if.idex_ip_dopause) begin
		idex_if.idex_op_npc 			<= 		idex_if.idex_ip_npc;
		idex_if.idex_op_imemload 	<=		idex_if.idex_ip_imemload;
		idex_if.idex_op_dREN 			<= 		idex_if.idex_ip_dREN;
 		idex_if.idex_op_dWEN 			<= 		idex_if.idex_ip_dWEN;
		idex_if.idex_op_RegWr 		<= 		idex_if.idex_ip_RegWr;
 		idex_if.idex_op_MemtoReg 	<= 		idex_if.idex_ip_MemtoReg;
	 	idex_if.idex_op_jal	 			<= 		idex_if.idex_ip_jal;
		idex_if.idex_op_jr 				<= 		idex_if.idex_ip_jr;
	 	idex_if.idex_op_halt 			<= 		idex_if.idex_ip_halt;
		idex_if.idex_op_lui 			<= 		idex_if.idex_ip_lui;
		idex_if.idex_op_imemREN 	<= 		idex_if.idex_ip_imemREN;
		idex_if.idex_op_branch 		<= 		idex_if.idex_ip_branch;
	 	idex_if.idex_op_jump 			<= 		idex_if.idex_ip_jump;
	 	idex_if.idex_op_bne 			<= 		idex_if.idex_ip_bne;
		idex_if.idex_op_beq 			<= 		idex_if.idex_ip_beq;
		idex_if.idex_op_ext 			<= 		idex_if.idex_ip_ext;
	 	idex_if.idex_op_rdat1 		<= 		idex_if.idex_ip_rdat1;
	 	idex_if.idex_op_rdat2 		<= 		idex_if.idex_ip_rdat2;
	 	idex_if.idex_op_shamt 		<= 		idex_if.idex_ip_shamt;
		idex_if.idex_op_RegDest 	<= 		idex_if.idex_ip_RegDest;
		idex_if.idex_op_ALUSrc 		<= 		idex_if.idex_ip_ALUSrc;
		idex_if.idex_op_ALUOP 		<= 		idex_if.idex_ip_ALUOP;
	end
	//	if opcode is LW or SW then wait for dhit to update
	/*else if ((idex_if.idex_ip_imemload[31:26] == SW || idex_if.idex_ip_imemload[31:26] == LW) 
						&& (idex_if.idex_ip_dhit)) begin
		idex_if.idex_op_npc 			<= 		idex_if.idex_ip_npc;
		idex_if.idex_op_imemload 	<=		idex_if.idex_ip_imemload;
		idex_if.idex_op_dREN 			<= 		idex_if.idex_ip_dREN;
 		idex_if.idex_op_dWEN 			<= 		idex_if.idex_ip_dWEN;
		idex_if.idex_op_RegWr 		<= 		idex_if.idex_ip_RegWr;
 		idex_if.idex_op_MemtoReg 	<= 		idex_if.idex_ip_MemtoReg;
	 	idex_if.idex_op_jal	 			<= 		idex_if.idex_ip_jal;
		idex_if.idex_op_jr 				<= 		idex_if.idex_ip_jr;
	 	idex_if.idex_op_halt 			<= 		idex_if.idex_ip_halt;
		idex_if.idex_op_lui 			<= 		idex_if.idex_ip_lui;
		idex_if.idex_op_imemREN 	<= 		idex_if.idex_ip_imemREN;
		idex_if.idex_op_branch 		<= 		idex_if.idex_ip_branch;
	 	idex_if.idex_op_jump 			<= 		idex_if.idex_ip_jump;
	 	idex_if.idex_op_bne 			<= 		idex_if.idex_ip_bne;
		idex_if.idex_op_beq 			<= 		idex_if.idex_ip_beq;
		idex_if.idex_op_ext 			<= 		idex_if.idex_ip_ext;
	 	idex_if.idex_op_rdat1 		<= 		idex_if.idex_ip_rdat1;
	 	idex_if.idex_op_rdat2 		<= 		idex_if.idex_ip_rdat2;
	 	idex_if.idex_op_shamt 		<= 		idex_if.idex_ip_shamt;
		idex_if.idex_op_RegDest 	<= 		idex_if.idex_ip_RegDest;
		idex_if.idex_op_ALUSrc 		<= 		idex_if.idex_ip_ALUSrc;
		idex_if.idex_op_ALUOP 		<= 		idex_if.idex_ip_ALUOP;
	end*/
	//	else just keep things same as before
	else	begin
		idex_if.idex_op_npc 			<= 		idex_if.idex_op_npc;
		idex_if.idex_op_imemload 	<=		idex_if.idex_op_imemload;
		idex_if.idex_op_dREN 			<= 		idex_if.idex_op_dREN;
 		idex_if.idex_op_dWEN 			<= 		idex_if.idex_op_dWEN;
		idex_if.idex_op_RegWr 		<= 		idex_if.idex_op_RegWr;
 		idex_if.idex_op_MemtoReg 	<= 		idex_if.idex_op_MemtoReg;
	 	idex_if.idex_op_jal	 			<= 		idex_if.idex_op_jal;
		idex_if.idex_op_jr 				<= 		idex_if.idex_op_jr;
	 	idex_if.idex_op_halt 			<= 		idex_if.idex_op_halt;
		idex_if.idex_op_lui 			<= 		idex_if.idex_op_lui;
		idex_if.idex_op_imemREN 	<= 		idex_if.idex_op_imemREN;
		idex_if.idex_op_branch 		<= 		idex_if.idex_op_branch;
	 	idex_if.idex_op_jump 			<= 		idex_if.idex_op_jump;
	 	idex_if.idex_op_bne 			<= 		idex_if.idex_op_bne;
		idex_if.idex_op_beq 			<= 		idex_if.idex_op_beq;
		idex_if.idex_op_ext 			<= 		idex_if.idex_op_ext;
	 	idex_if.idex_op_rdat1 		<= 		idex_if.idex_op_rdat1;
	 	idex_if.idex_op_rdat2 		<= 		idex_if.idex_op_rdat2;
	 	idex_if.idex_op_shamt 		<= 		idex_if.idex_op_shamt;
		idex_if.idex_op_RegDest 	<= 		idex_if.idex_op_RegDest;
		idex_if.idex_op_ALUSrc 		<= 		idex_if.idex_op_ALUSrc;
		idex_if.idex_op_ALUOP 		<= 		idex_if.idex_op_ALUOP;
	end

end

endmodule
