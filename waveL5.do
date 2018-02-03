onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/CLK
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/nRST
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/branchAND
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/branchlogic
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/imm
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/baddr
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/shamt
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/ext
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/branchaddr
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/jumpaddr
add wave -noupdate -group {Datapath Internal} /system_tb/DUT/CPU/DP/jaddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
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
add wave -noupdate -expand -group pcif /system_tb/DUT/CPU/DP/pcif/next_pc
add wave -noupdate -expand -group pcif /system_tb/DUT/CPU/DP/pcif/cur_pc
add wave -noupdate -expand -group pcif /system_tb/DUT/CPU/DP/pcif/npc
add wave -noupdate -expand -group pcif /system_tb/DUT/CPU/DP/pcif/ihit
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/ALUOP
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/PORT_A
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/PORT_B
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/OUT
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/NEG
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/OVERFLOW
add wave -noupdate -expand -group aif /system_tb/DUT/CPU/DP/aif/ZERO
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -expand -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group rfif -expand /system_tb/DUT/CPU/DP/REGF/registers
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/dhit
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/ihit
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/dmemWEN
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/dmemREN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate /system_tb/DUT/CPU/ccif/iload
add wave -noupdate /system_tb/DUT/CPU/ccif/dload
add wave -noupdate /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate /system_tb/DUT/CPU/ccif/ramload
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29932 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {512 ns}
