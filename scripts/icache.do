onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate /icache_tb/PROG/testcase
add wave -noupdate -expand -group icache /icache_tb/DUT/tag
add wave -noupdate -expand -group icache -expand /icache_tb/DUT/idx
add wave -noupdate -expand -group icache /icache_tb/DUT/frame
add wave -noupdate -expand -group icache /icache_tb/DUT/hit
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/halt
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/ihit
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/imemREN
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/imemload
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/imemaddr
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/dhit
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/datomic
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/dmemREN
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/dmemWEN
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/flushed
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/dmemload
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/dmemstore
add wave -noupdate -expand -group dcif /icache_tb/DUT/dcif/dmemaddr
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/iwait
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/dwait
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/iREN
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/dREN
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/dWEN
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/iload
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/dload
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/dstore
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/iaddr
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/daddr
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/ccwait
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/ccinv
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/ccwrite
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/cctrans
add wave -noupdate -expand -group cif /icache_tb/DUT/cif/ccsnoopaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {87 ns} 0}
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
WaveRestoreZoom {0 ns} {296 ns}
