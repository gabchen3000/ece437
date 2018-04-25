onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group PC0 /system_tb/DUT/CPU/DP0/PC/pcif/next_pc
add wave -noupdate -expand -group PC0 /system_tb/DUT/CPU/DP0/PC/pcif/cur_pc
add wave -noupdate -expand -group PC0 /system_tb/DUT/CPU/DP0/PC/pcif/npc
add wave -noupdate -expand -group PC0 /system_tb/DUT/CPU/DP0/PC/pcif/ihit
add wave -noupdate -expand -group PC0 /system_tb/DUT/CPU/DP0/PC/pcif/IDdopause
add wave -noupdate -expand -group PC0 /system_tb/DUT/CPU/DP0/PC/pcif/PCSrc
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/IF_r_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/IF_i_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/IF_j_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/ID_r_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/ID_i_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/ID_j_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/EX_r_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/EX_i_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/EX_j_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/MEM_r_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/MEM_i_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/MEM_j_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/WB_r_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/WB_i_type
add wave -noupdate -expand -group {DP0 pipeline} /system_tb/DUT/CPU/DP0/WB_j_type
add wave -noupdate /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/CLK
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/nRST
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/PCSrc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IFnpc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IFimemload
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IFflushed
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDALUSrc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDRegDest
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDnpc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDimemload
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDrdat1
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDrdat2
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDext
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDshamt
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDflushed
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDjump
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDjr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDbne
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDbeq
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDbranch
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDimemREN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDhalt
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDdWEN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDdREN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDjal
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDlui
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDMemtoReg
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDRegWr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDALUOP
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXnpc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXimemload
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXrdat1
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXrdat2
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXext
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXshamt
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXALU_OUT
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXbranchaddr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXjumpaddr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXflushed
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXjump
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXjr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXbne
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXbeq
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXbranch
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXhalt
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXimemREN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXdWEN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXdREN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXjal
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXlui
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXMemtoReg
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXRegWr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXZERO
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXALUSrc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXRegDest
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXALUOP
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/EXwsel
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMimemload
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMbranchaddr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMnpc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMrdat1
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMrdat2
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMALU_OUT
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMdmemload
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMjumpaddr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMjump
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMjr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMbne
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMbeq
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMbranch
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMhalt
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMimemREN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMdmemWEN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMdmemREN
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMjal
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMlui
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMMemtoReg
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMRegWr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMZERO
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMbranchAND
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MEMwsel
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBimemload
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBnpc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBALU_OUT
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBdmemload
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBwdat
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBjal
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBlui
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBMemtoReg
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBRegWr
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBdhit
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBihit
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBwdatsel
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBwsel
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/MUX_XXX
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/IDdopause
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/WBhalt
add wave -noupdate -expand -group PC1 /system_tb/DUT/CPU/DP1/PC/pcif/next_pc
add wave -noupdate -expand -group PC1 /system_tb/DUT/CPU/DP1/PC/pcif/cur_pc
add wave -noupdate -expand -group PC1 /system_tb/DUT/CPU/DP1/PC/pcif/npc
add wave -noupdate -expand -group PC1 /system_tb/DUT/CPU/DP1/PC/pcif/ihit
add wave -noupdate -expand -group PC1 /system_tb/DUT/CPU/DP1/PC/pcif/IDdopause
add wave -noupdate -expand -group PC1 /system_tb/DUT/CPU/DP1/PC/pcif/PCSrc
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/IF_r_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/IF_i_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/IF_j_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/ID_r_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/ID_i_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/ID_j_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/EX_r_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/EX_i_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/EX_j_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/MEM_r_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/MEM_i_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/MEM_j_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/WB_r_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/WB_i_type
add wave -noupdate -expand -group {DP1 pipeline} /system_tb/DUT/CPU/DP1/WB_j_type
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/CLK
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/nRST
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/PCSrc
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IFnpc
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IFimemload
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IFflushed
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDALUSrc
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDRegDest
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDnpc
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDimemload
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDrdat1
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDrdat2
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDext
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDshamt
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDflushed
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDjump
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDjr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDbne
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDbeq
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDbranch
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDimemREN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDhalt
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDdWEN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDdREN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDjal
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDlui
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDMemtoReg
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDRegWr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDALUOP
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXnpc
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXimemload
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXrdat1
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXrdat2
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXext
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXshamt
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXALU_OUT
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXbranchaddr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXjumpaddr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXflushed
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXjump
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXjr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXbne
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXbeq
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXbranch
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXhalt
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXimemREN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXdWEN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXdREN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXjal
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXlui
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXMemtoReg
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXRegWr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXZERO
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXALUSrc
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXRegDest
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXALUOP
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/EXwsel
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMimemload
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMbranchaddr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMnpc
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMrdat1
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMrdat2
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMALU_OUT
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMdmemload
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMjumpaddr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMjump
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMjr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMbne
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMbeq
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMbranch
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMhalt
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMimemREN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMdmemWEN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMdmemREN
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMjal
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMlui
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMMemtoReg
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMRegWr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMZERO
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMbranchAND
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MEMwsel
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBimemload
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBnpc
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBALU_OUT
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBdmemload
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBwdat
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBjal
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBlui
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBMemtoReg
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBRegWr
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBdhit
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBihit
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBwdatsel
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBwsel
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/MUX_XXX
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/IDdopause
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/WBhalt
add wave -noupdate -expand -group dp0iiif /system_tb/DUT/CPU/DP0/iiif/ifid_ip_ihit
add wave -noupdate -expand -group dp0iiif /system_tb/DUT/CPU/DP0/iiif/ifid_ip_dhit
add wave -noupdate -expand -group dp0iiif /system_tb/DUT/CPU/DP0/iiif/idex_ip_dopause
add wave -noupdate -expand -group dp0iiif /system_tb/DUT/CPU/DP0/iiif/ifid_ip_doflush
add wave -noupdate -expand -group dp0iiif /system_tb/DUT/CPU/DP0/iiif/ifid_ip_imemload
add wave -noupdate -expand -group dp0iiif /system_tb/DUT/CPU/DP0/iiif/ifid_ip_npc
add wave -noupdate -expand -group dp0iiif /system_tb/DUT/CPU/DP0/iiif/ifid_op_npc
add wave -noupdate -expand -group dp0iiif /system_tb/DUT/CPU/DP0/iiif/ifid_op_imemload
add wave -noupdate -label halt0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -label halt1 /system_tb/DUT/CPU/dcif1/halt
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group ccif -expand /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -expand -group ccif -expand /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -expand -group ccif -expand /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -expand -group ccif -expand /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -expand -group ccif -expand /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -expand -group {cache control} /system_tb/DUT/CPU/CC/CLK
add wave -noupdate -expand -group {cache control} /system_tb/DUT/CPU/CC/nRST
add wave -noupdate -expand -group {cache control} /system_tb/DUT/CPU/CC/snoopcache
add wave -noupdate -expand -group {cache control} /system_tb/DUT/CPU/CC/iselect
add wave -noupdate -expand -group {cache control} /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -expand -group {cache control} /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -expand -group {cache control} /system_tb/DUT/CPU/CC/prev_iselect
add wave -noupdate -expand -group {cache control} /system_tb/DUT/CPU/CC/wbcache
add wave -noupdate -expand -group {cache control} /system_tb/DUT/CPU/CC/cur_state
add wave -noupdate -expand -group {cache control} /system_tb/DUT/CPU/CC/nxt_state
add wave -noupdate -label registers0 /system_tb/DUT/CPU/DP0/REGF/registers
add wave -noupdate -label registers1 /system_tb/DUT/CPU/DP1/REGF/registers
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -expand -group dcache0 -expand -subitemconfig {{/system_tb/DUT/CPU/CM0/DCACHE/frame1[1]} -expand} /system_tb/DUT/CPU/CM0/DCACHE/frame1
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame2
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/tag
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame1_tag
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame2_tag
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/idx
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flushcountIDX
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flushcount
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nxt_flushcount
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/goflush
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/offset
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dirtyloop
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nxt_dirtyloop
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/miss
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame1_valid
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame2_valid
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame1_dirty
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame2_dirty
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/count
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nxt_count
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame1_data_1
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame1_data_2
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame2_data_1
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/frame2_data_2
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/stagmiss
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/snoopdone
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/snoopoffset
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/matchframe
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/snooptag
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/snoopidx
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/linked_reg
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nxt_linked_reg
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/linked_valid
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nxt_linked_valid
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/cur_state
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/nxt_state
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -expand -group dcache1 -expand -subitemconfig {{/system_tb/DUT/CPU/CM1/DCACHE/frame1[1]} -expand} /system_tb/DUT/CPU/CM1/DCACHE/frame1
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame2
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/tag
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame1_tag
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame2_tag
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/idx
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flushcountIDX
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flushcount
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nxt_flushcount
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/goflush
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/offset
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dirtyloop
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nxt_dirtyloop
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/miss
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame1_valid
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame2_valid
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame1_dirty
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame2_dirty
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/count
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nxt_count
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame1_data_1
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame1_data_2
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame2_data_1
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/frame2_data_2
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/stagmiss
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/snoopdone
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/snoopoffset
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/matchframe
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/snooptag
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/snoopidx
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/linked_reg
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nxt_linked_reg
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/linked_valid
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nxt_linked_valid
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/cur_state
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/nxt_state
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/halt
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/ihit
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/imemREN
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/imemload
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/imemaddr
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/dhit
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/datomic
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/dmemREN
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/dmemWEN
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/flushed
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/dmemload
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/dmemstore
add wave -noupdate -group dpif0 /system_tb/DUT/CPU/DP0/dpif/dmemaddr
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/halt
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/ihit
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/imemREN
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/imemload
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/imemaddr
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/dhit
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/datomic
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/dmemREN
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/dmemWEN
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/flushed
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/dmemload
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/dmemstore
add wave -noupdate -group dpif1 /system_tb/DUT/CPU/DP1/dpif/dmemaddr
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/EXwsel
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/MEMwsel
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/rs
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/rt
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/MEMRegWr
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/EXRegWr
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/IFdopause
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/IDdopause
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/ihit
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/dhit
add wave -noupdate -group hu0 /system_tb/DUT/CPU/DP1/huif/PCSrc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1831533 ps} 0}
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
WaveRestoreZoom {1513966 ps} {2595391 ps}
