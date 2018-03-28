onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate /memory_control_tb/DUT/cur_state
add wave -noupdate /memory_control_tb/DUT/nxt_state
add wave -noupdate /memory_control_tb/PROG/testcase
add wave -noupdate /memory_control_tb/ramif/ramstate
add wave -noupdate /memory_control_tb/ccif/ramstate
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/CPUS
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/iwait
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/dwait
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/iREN
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/dREN
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/dWEN
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/iload
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/dload
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/dstore
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/iaddr
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/daddr
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/ccwait
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/ccinv
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/ccwrite
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/cctrans
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/ccsnoopaddr
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/ramWEN
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/ramREN
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/ramstate
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/ramaddr
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/ramstore
add wave -noupdate -expand -group ccif /memory_control_tb/PROG/ccif/ramload
add wave -noupdate /memory_control_tb/DUT/iselect
add wave -noupdate /memory_control_tb/DUT/prev_iselect
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {120 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 336
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {38 ns} {182 ns}
