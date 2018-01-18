/*
*   Copyright 2016 Purdue University
*
*   Licensed under the Apache License, Version 2.0 (the "License");
*   you may not use this file except in compliance with the License.
*   You may obtain a copy of the License at
*
*       http://www.apache.org/licenses/LICENSE-2.0
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*
*
*   Filename:     cpu_tracker.sv
*
*   Created by:   Jacob R. Stevens
*   Email:        steven69@purdue.edu
*   Date Created: 06/27/2016
*   Description:  Prints out a trace of the cpu executing that can be
*                 compared against the trace generated by the ISS
*/

`define TRACE_FILE_NAME "cpu_trace.log"

`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module cpu_tracker(
  input logic CLK,
  input logic wb_stall,
  input logic dhit,
  input funct_t funct,
  input opcode_t opcode,
  input regbits_t rs,
  input regbits_t rt,
  input regbits_t wsel,
  input word_t instr,
  input word_t pc,
  input word_t npc,
  input word_t branch_addr,
  input word_t imm,
  input logic [4:0] shamt,
  input logic [15:0] lui,
  input word_t store_dat,
  input word_t reg_dat,
  input word_t load_dat,
  input word_t dat_addr
);

  parameter CPUID = 0;

  integer fptr, halt_written;
  string instr_mnemonic, output_str, operands, temp_str, halt_temp_str;
  string rs_str, rt_str, ram_str, lw_str, halt_output_str, dest_str;
  opcode_t last_opcode;

  initial begin: INIT_FILE
    fptr = $fopen(`TRACE_FILE_NAME, "w");
    halt_written = 0;
  end

  always_comb begin
    rs_str    = registerAssign(rs);
    rt_str    = registerAssign(rt);
    dest_str  = registerAssign(wsel);
  end

  always_comb begin
    case (opcode)
      RTYPE: begin
        case(funct)
          ADDU, ADD, SUB,
          AND, NOR, OR,
          SLT, SLTU, SUBU,
          XOR:  $sformat(operands, "%s, %s, %s", dest_str, rs_str, rt_str);
          JR:   $sformat(operands, "%s", rs_str);
          SLL,
          SRL:  $sformat(operands,"%s, %s, %d", dest_str,rs_str, signed'(shamt));
        endcase
      end
      ADDIU, ADDI,
      ANDI, ORI,
      SLTI, SLTIU,
      XORI:     $sformat(operands, "%s, %s, %d", dest_str, rs_str, signed'(imm));
      HALT:     $sformat(operands, "");
      // BEQ is a patch until ISS is corrected
      BEQ:      $sformat(operands, "%s, %s, %d", rt_str, rs_str, branch_addr);
      BNE:      $sformat(operands, "%s, %s, %d", rs_str, rt_str, branch_addr);
      LUI:      $sformat(operands,"%s, %d", dest_str, lui);
      LW, LL,
      SW, SC:   $sformat(operands, "%s, %d(%s)", dest_str, signed'(imm), rs_str);
      J, JAL:   $sformat(operands, "%x", signed'(npc));
    endcase
  end

  always_comb begin
    case (opcode)
      J:        instr_mnemonic = "J";
      JAL:      instr_mnemonic = "JAL";
      BEQ:      instr_mnemonic = "BEQ";
      BNE:      instr_mnemonic = "BNE";
      ADDI:     instr_mnemonic = "ADDI";
      ADDIU:    instr_mnemonic = "ADDIU";
      SLTI:     instr_mnemonic = "SLTI";
      SLTIU:    instr_mnemonic = "SLTIU";
      ANDI:     instr_mnemonic = "ANDI";
      ORI:      instr_mnemonic = "ORI";
      XORI:     instr_mnemonic = "XORI";
      LUI:      instr_mnemonic = "LUI";
      LW:       instr_mnemonic = "LW";
      LBU:      instr_mnemonic = "LBU";
      LHU:      instr_mnemonic = "LHU";
      SB:       instr_mnemonic = "SB";
      SH:       instr_mnemonic = "SH";
      SW:       instr_mnemonic = "SW";
      LL:       instr_mnemonic = "LL";
      SC:       instr_mnemonic = "SC";
      HALT:     instr_mnemonic = "HALT";
      RTYPE: begin
        case(funct)
          SLL:  instr_mnemonic = "SLL";
          SRL:  instr_mnemonic = "SRL";
          JR:   instr_mnemonic = "JR";
          ADD:  instr_mnemonic = "ADD";
          ADDU: instr_mnemonic = "ADDU";
          SUB:  instr_mnemonic = "SUB";
          SUBU: instr_mnemonic = "SUBU";
          AND:  instr_mnemonic = "AND";
          OR:   instr_mnemonic = "OR";
          XOR:  instr_mnemonic = "XOR";
          NOR:  instr_mnemonic = "NOR";
          SLT:  instr_mnemonic = "SLT";
          SLTU: instr_mnemonic = "SLTU";
        endcase
      end
      default:  instr_mnemonic = "xxx";
    endcase
  end

  function string registerAssign(input logic [4:0] register);
    case (register)
      5'd0:   registerAssign = "R0";
      5'd1:   registerAssign = "R1";
      5'd2:   registerAssign = "R2";
      5'd3:   registerAssign = "R3";
      5'd4:   registerAssign = "R4";
      5'd5:   registerAssign = "R5";
      5'd6:   registerAssign = "R6";
      5'd7:   registerAssign = "R7";
      5'd8:   registerAssign = "R8";
      5'd9:   registerAssign = "R9";
      5'd10:  registerAssign = "R10";
      5'd11:  registerAssign = "R11";
      5'd12:  registerAssign = "R12";
      5'd13:  registerAssign = "R13";
      5'd14:  registerAssign = "R14";
      5'd15:  registerAssign = "R15";
      5'd16:  registerAssign = "R16";
      5'd17:  registerAssign = "R17";
      5'd18:  registerAssign = "R18";
      5'd19:  registerAssign = "R19";
      5'd20:  registerAssign = "R20";
      5'd21:  registerAssign = "R21";
      5'd22:  registerAssign = "R22";
      5'd23:  registerAssign = "R23";
      5'd24:  registerAssign = "R24";
      5'd25:  registerAssign = "R25";
      5'd26:  registerAssign = "R26";
      5'd27:  registerAssign = "R27";
      5'd28:  registerAssign = "R28";
      5'd29:  registerAssign = "R29";
      5'd30:  registerAssign = "R30";
      5'd31:  registerAssign = "R31";
    endcase
  endfunction

  // LW are a half cycle too late due to state machine inside
  // request unit. This is a work a round for that problem.
  always_ff @ (posedge CLK) begin
    if (dhit) begin
        if (last_opcode == LW) begin
          $sformat(ram_str, "    [word read");
          $sformat(ram_str, "%s from %x]\n", ram_str, {16'h0, dat_addr[15:0]});
          $sformat(ram_str, "%s    %s", ram_str, dest_str);
          $sformat(ram_str, "%s <-- %x\n", ram_str, load_dat);
          $sformat(lw_str, "%s%s\n", temp_str, ram_str);
          $fwrite(fptr, lw_str);
        end
    end
  end

  always_ff @ (posedge CLK) begin
    if (!wb_stall)
      last_opcode <= opcode;
  end

  always_ff @ (posedge CLK) begin
    if (!wb_stall && instr != 0) begin
      $sformat(temp_str, "%X (Core %d): %X", pc, CPUID + 1, instr);
      $sformat(temp_str, "%s %s %s\n", temp_str, instr_mnemonic, operands);
      $sformat(temp_str, "%s    PC <-- %X\n", temp_str, npc);
      case(opcode)
        RTYPE: case(funct)
          ADDU, ADD, AND,
          NOR, OR, SLT, SLTU,
          SLL, SRL, SUB, SUBU,
          XOR:  $sformat(temp_str, "%s    %s <-- %x\n", temp_str, dest_str, reg_dat);
        endcase
        ADDIU, ADDI, ANDI,
        LUI, ORI, SLTI,
        SLTIU,
        XORI: $sformat(temp_str, "%s    %s <-- %x\n",temp_str, dest_str,reg_dat);
        JAL:  $sformat(temp_str, "%s    %s <-- %x\n", temp_str, dest_str, reg_dat);
        SW: begin
              $sformat(temp_str,"%s    [%x]",temp_str,{16'h0, dat_addr[15:0]});
              $sformat(temp_str, "%s <-- %x\n", temp_str, store_dat);
        end
        //TODO: atomic instructions
      endcase
      $sformat(output_str, "%s\n", temp_str);
      // LW are handled differently
      if (opcode != LW)
        $fwrite(fptr, output_str);
    end
  end

  final begin: CLOSE_FILE
    $fclose(fptr);
  end

endmodule
