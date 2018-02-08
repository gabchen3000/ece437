onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group {PC signals} /system_tb/DUT/CPU/DP/pcif/next_pc
add wave -noupdate -group {PC signals} /system_tb/DUT/CPU/DP/pcif/cur_pc
add wave -noupdate -group {PC signals} /system_tb/DUT/CPU/DP/pcif/npc
add wave -noupdate -group {PC signals} /system_tb/DUT/CPU/DP/pcif/ihit
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/ID_r_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/ID_i_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/ID_j_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/EX_r_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/EX_i_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/EX_j_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/MEM_r_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/MEM_i_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/MEM_j_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/WB_r_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/WB_i_type
add wave -noupdate -group {PC signals} -expand -group {datapath imemload types} /system_tb/DUT/CPU/DP/WB_j_type
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
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/CLK
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/nRST
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/PCSrc
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IFnpc
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IFimemload
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IFflushed
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/ID_r_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/ID_i_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/ID_j_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDALUSrc
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDRegDest
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDnpc
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDimemload
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDrdat1
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDrdat2
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDext
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDshamt
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDflushed
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDjump
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDjr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDbne
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDbeq
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDbranch
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDimemREN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDhalt
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDdWEN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDdREN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDjal
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDlui
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDMemtoReg
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDRegWr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/IDALUOP
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EX_r_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EX_i_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EX_j_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXnpc
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXimemload
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXrdat1
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXrdat2
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXext
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXshamt
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXALU_OUT
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXbranchaddr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXjump
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXjr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXbne
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXbeq
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXbranch
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXhalt
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXimemREN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXdWEN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXdREN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXjal
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXlui
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXMemtoReg
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXRegWr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXZERO
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXALUSrc
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXRegDest
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXALUOP
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/EXwsel
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEM_r_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEM_i_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEM_j_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMimemload
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMbranchaddr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMnpc
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMrdat1
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMrdat2
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMALU_OUT
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMdmemload
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMjumpaddr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMjump
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMjr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMbne
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMbeq
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMbranch
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMhalt
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMimemREN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMdmemWEN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMdmemREN
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMjal
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMlui
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMMemtoReg
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMRegWr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMZERO
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMbranchAND
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/MEMwsel
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WB_r_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WB_i_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WB_j_type
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBimemload
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBnpc
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBALU_OUT
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBdmemload
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBwdat
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBjal
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBlui
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBMemtoReg
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBRegWr
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBdhit
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBihit
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBwdatsel
add wave -noupdate -group {Datapath Signals} /system_tb/DUT/CPU/DP/WBwsel
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
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_doflush
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_ihit
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_dhit
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_imemload
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_npc
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_dREN
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_dWEN
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_RegWr
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_MemtoReg
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_jal
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_jr
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_halt
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_lui
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_imemREN
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_branch
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_jump
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_bne
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_beq
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_ALUOP
add wave -noupdate -expand -group ieif -expand /system_tb/DUT/CPU/DP/ieif/idex_ip_RegDest
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_ALUSrc
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_ext
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_rdat1
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_rdat2
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_ip_shamt
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_imemload
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_npc
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_dREN
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_dWEN
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_RegWr
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_MemtoReg
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_jal
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_jr
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_halt
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_lui
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_imemREN
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_branch
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_jump
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_bne
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_beq
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_ALUOP
add wave -noupdate -expand -group ieif -expand /system_tb/DUT/CPU/DP/ieif/idex_op_RegDest
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_ALUSrc
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_ext
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_rdat1
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_rdat2
add wave -noupdate -expand -group ieif /system_tb/DUT/CPU/DP/ieif/idex_op_shamt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {353143 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 181
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {6846137 ps}
