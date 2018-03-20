onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group {PC signals} /system_tb/DUT/CPU/DP/pcif/next_pc
add wave -noupdate -expand -group {PC signals} /system_tb/DUT/CPU/DP/pcif/cur_pc
add wave -noupdate -expand -group {PC signals} /system_tb/DUT/CPU/DP/pcif/npc
add wave -noupdate -expand -group {PC signals} /system_tb/DUT/CPU/DP/pcif/ihit
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/ID_r_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/ID_i_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/ID_j_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/EX_r_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/EX_i_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/EX_j_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/MEM_r_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/MEM_i_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/MEM_j_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/WB_r_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/WB_i_type
add wave -noupdate -expand -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/WB_j_type
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/imemload
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ALUOP
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/RegDest
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ExtOp
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/RegWr
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/jal
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/jr
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/lui
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/imemREN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/branch
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/jump
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/sll
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/srl
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/bne
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/beq
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/CLK
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/nRST
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/PCSrc
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IFnpc
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IFimemload
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IFflushed
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/ID_r_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/ID_i_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/ID_j_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDALUSrc
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDRegDest
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDnpc
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDimemload
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDrdat1
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDrdat2
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDext
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDshamt
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDflushed
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDjump
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDjr
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDbne
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDbeq
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDbranch
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDimemREN
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDhalt
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDdWEN
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDdREN
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDjal
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDlui
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDMemtoReg
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDRegWr
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDALUOP
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EX_r_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EX_i_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EX_j_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXnpc
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXimemload
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXrdat1
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXrdat2
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXext
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXshamt
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXALU_OUT
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXbranchaddr
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXflushed
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXjump
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXjr
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXbne
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXbeq
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXbranch
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXhalt
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXimemREN
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXdWEN
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXdREN
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXjal
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXlui
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXMemtoReg
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXRegWr
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXZERO
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXALUSrc
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXRegDest
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXALUOP
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXwsel
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEM_r_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEM_i_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEM_j_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMimemload
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMbranchaddr
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMnpc
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMrdat1
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMrdat2
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMALU_OUT
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMdmemload
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMjumpaddr
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMjump
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMjr
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMbne
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMbeq
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMbranch
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMhalt
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMimemREN
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMdmemWEN
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMdmemREN
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMjal
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMlui
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMMemtoReg
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMRegWr
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMZERO
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMbranchAND
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMwsel
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WB_r_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WB_i_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WB_j_type
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBimemload
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBnpc
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBALU_OUT
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBdmemload
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBwdat
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBjal
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBlui
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBMemtoReg
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBRegWr
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBdhit
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBihit
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBwdatsel
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBwsel
add wave -noupdate -expand -group {Datapath Signals} /system_tb/DUT/CPU/DP/MUX_XXX
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/ALUOP
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/PORT_A
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/PORT_B
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/OUT
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/NEG
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/OVERFLOW
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/ZERO
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/halt
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/ihit
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/imemREN
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/imemload
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/imemaddr
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/dhit
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/datomic
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/dmemREN
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/dmemWEN
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/flushed
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/dmemload
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/dmemstore
add wave -noupdate -expand -group {datapath output signals} /system_tb/DUT/CPU/CM/dcif/dmemaddr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/REGF/registers
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/ifid_ip_ihit
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/ifid_ip_dhit
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/ifid_ip_imemload
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/ifid_ip_npc
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/ifid_op_npc
add wave -noupdate -group iiif /system_tb/DUT/CPU/DP/iiif/ifid_op_imemload
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_doflush
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_ihit
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_dhit
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_npc
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_imemload
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_branchaddr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_dREN
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_dWEN
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_RegWr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_MemtoReg
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_jal
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_jr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_halt
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_lui
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_imemREN
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_branch
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_jump
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_bne
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_beq
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_rdat1
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_rdat2
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_ALUOUT
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_ZERO
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_ip_wsel
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_npc
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_imemload
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_branchaddr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_dmemREN
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_dmemWEN
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_RegWr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_MemtoReg
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_jal
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_jr
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_halt
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_lui
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_imemREN
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_branch
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_jump
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_bne
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_beq
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_rdat1
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_rdat2
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_ALUOUT
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_ZERO
add wave -noupdate -group emif /system_tb/DUT/CPU/DP/emif/exmem_op_wsel
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/EXwsel
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/MEMwsel
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/rs
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/rt
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/MEMRegWr
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/EXRegWr
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/IDdopause
add wave -noupdate -group huif /system_tb/DUT/CPU/DP/huif/PCSrc
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_doflush
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_ihit
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_dhit
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_dopause
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_imemload
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_npc
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_dREN
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_dWEN
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_RegWr
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_MemtoReg
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_jal
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_jr
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_halt
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_lui
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_imemREN
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_branch
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_jump
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_bne
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_beq
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_ALUOP
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_RegDest
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_ALUSrc
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_ext
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_rdat1
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_rdat2
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_shamt
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_imemload
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_npc
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_dREN
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_dWEN
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_RegWr
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_MemtoReg
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_jal
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_jr
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_halt
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_lui
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_imemREN
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_branch
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_jump
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_bne
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_beq
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_ALUOP
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_RegDest
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_ALUSrc
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_ext
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_rdat1
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_rdat2
add wave -noupdate -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_shamt
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/id_ex_rs
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/id_ex_rt
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/MEMwsel
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/WBwsel
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/MEMRegWr
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/WBRegWr
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/forwardselA
add wave -noupdate -group FU /system_tb/DUT/CPU/DP/fuif/forwardselB
add wave -noupdate -group prif /system_tb/DUT/prif/ramREN
add wave -noupdate -group prif /system_tb/DUT/prif/ramWEN
add wave -noupdate -group prif /system_tb/DUT/prif/ramaddr
add wave -noupdate -group prif /system_tb/DUT/prif/ramstore
add wave -noupdate -group prif /system_tb/DUT/prif/ramload
add wave -noupdate -group prif /system_tb/DUT/prif/ramstate
add wave -noupdate -group prif /system_tb/DUT/prif/memREN
add wave -noupdate -group prif /system_tb/DUT/prif/memWEN
add wave -noupdate -group prif /system_tb/DUT/prif/memaddr
add wave -noupdate -group prif /system_tb/DUT/prif/memstore
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -expand -group dcache -expand /system_tb/DUT/CPU/CM/DCACHE/frame1
add wave -noupdate -expand -group dcache -expand -subitemconfig {{/system_tb/DUT/CPU/CM/DCACHE/frame2[7]} -expand {/system_tb/DUT/CPU/CM/DCACHE/frame2[6]} -expand {/system_tb/DUT/CPU/CM/DCACHE/frame2[0]} -expand} /system_tb/DUT/CPU/CM/DCACHE/frame2
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/cur_state
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_state
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/frame1_dirty
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/frame2_dirty
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/flushcountIDX
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/flushcount
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {453755804 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 181
configure wave -valuecolwidth 166
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {453206831 ps} {454890348 ps}
