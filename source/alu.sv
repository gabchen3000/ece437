/*
  alu file lab 2
	alu functions: logical shift left, logical shift right, and, or, xor, nor, signed add, signed subtract
									set less than signed, set less than unsigned
	Able to output negative, zero and overflow flag bits
*/

// interface
`include "alu_if.vh"
`include "cpu_types_pkg.vh"

module alu (
	alu_if.alu aif
);
//import types
import cpu_types_pkg::*;

/*
opcodes: 
    ALU_SLL     = 4'b0000,
    ALU_SRL     = 4'b0001,
    ALU_ADD     = 4'b0010,
    ALU_SUB     = 4'b0011,
    ALU_AND     = 4'b0100,
    ALU_OR      = 4'b0101,
    ALU_XOR     = 4'b0110,
    ALU_NOR     = 4'b0111,
    ALU_SLT     = 4'b1010,
    ALU_SLTU    = 4'b1011
*/

//Setting zero and negative flag
//zero flag if output is 0, negative flag if out[31] is 1
always_comb begin
	if (aif.OUT == 0) begin
		aif.ZERO = 1;
	end
	else begin
		aif.ZERO = 0;
	end

	if (aif.OUT[31] == 1) begin
		aif.NEG = 1;
	end
	else begin
		aif.NEG = 0;
	end
end

//overflow only happens when + and -
//add overflow: (same most sig bit of A and B) LOGICALAND (diff most sig bit of A and OUT)
//sub overflow: (diff most sig bit of A and B) LOGICALAND (diff most sig bit of A and OUT)
//& bitwise and, && logical and
always_comb begin
	aif.OUT = 0;
	aif.OVERFLOW = 0;

	casez (aif.ALUOP)

		ALU_SLL		: aif.OUT = aif.PORT_A << aif.PORT_B;

		ALU_SRL		: aif.OUT = aif.PORT_A >> aif.PORT_B;

    ALU_ADD		: begin
								aif.OUT = $signed(aif.PORT_A) + $signed(aif.PORT_B);
								aif.OVERFLOW = (aif.PORT_A[31] == aif.PORT_B[31]) && (aif.PORT_A[31] != aif.OUT[31]);
		end

    ALU_SUB		: begin
								aif.OUT = $signed(aif.PORT_A) - $signed(aif.PORT_B);
								aif.OVERFLOW = (aif.PORT_A[31] != aif.PORT_B[31]) && (aif.PORT_A[31] != aif.OUT[31]);
		end

    ALU_AND		: aif.OUT = aif.PORT_A & aif.PORT_B;

    ALU_OR		:	aif.OUT = aif.PORT_A | aif.PORT_B;

    ALU_XOR		: aif.OUT = aif.PORT_A ^ aif.PORT_B;

    ALU_NOR		: aif.OUT = ~(aif.PORT_A | aif.PORT_B);

    ALU_SLT		: aif.OUT = $signed(aif.PORT_A) < $signed(aif.PORT_B);

    ALU_SLTU	: aif.OUT = aif.PORT_A < aif.PORT_B;

	endcase
end

endmodule

