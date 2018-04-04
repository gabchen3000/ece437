onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -radix decimal /dcache_tb/PROG/testcase
add wave -noupdate /dcache_tb/cif/dload
add wave -noupdate /dcache_tb/dcif/dmemREN
add wave -noupdate /dcache_tb/dcif/dmemaddr
add wave -noupdate -group dcache -expand -subitemconfig {{/dcache_tb/DUT/frame1[7]} -expand {/dcache_tb/DUT/frame1[1]} -expand} /dcache_tb/DUT/frame1
add wave -noupdate -group dcache -expand -subitemconfig {{/dcache_tb/DUT/frame2[7]} -expand {/dcache_tb/DUT/frame2[2]} -expand {/dcache_tb/DUT/frame2[1]} -expand} /dcache_tb/DUT/frame2
add wave -noupdate -group lru -expand /dcache_tb/DUT/lru
add wave -noupdate -group lru /dcache_tb/DUT/nxt_lru
add wave -noupdate /dcache_tb/dcif/halt
add wave -noupdate -expand -group state /dcache_tb/DUT/cur_state
add wave -noupdate -expand -group state /dcache_tb/DUT/nxt_state
add wave -noupdate -expand -group data_in_cache /dcache_tb/DUT/frame1_data_1
add wave -noupdate -expand -group data_in_cache /dcache_tb/DUT/frame1_data_2
add wave -noupdate -expand -group data_in_cache /dcache_tb/DUT/frame2_data_1
add wave -noupdate -expand -group data_in_cache /dcache_tb/DUT/frame2_data_2
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /dcache_tb/DUT/stagmiss
add wave -noupdate /dcache_tb/DUT/snoopdone
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/iwait
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/dwait
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/iREN
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/dREN
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/dWEN
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/iload
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/dload
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/dstore
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/iaddr
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/daddr
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/ccwait
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/ccinv
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/ccwrite
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/cctrans
add wave -noupdate -expand -group cif /dcache_tb/DUT/cif/ccsnoopaddr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /dcache_tb/PROG/dcif/dhit
add wave -noupdate /dcache_tb/PROG/dcif/dmemload
add wave -noupdate /dcache_tb/PROG/dcif/dmemWEN
add wave -noupdate /dcache_tb/PROG/dcif/dmemstore
add wave -noupdate /dcache_tb/DUT/frame1_dirty
add wave -noupdate /dcache_tb/DUT/frame2_dirty
add wave -noupdate /dcache_tb/DUT/frame1_valid
add wave -noupdate /dcache_tb/DUT/frame2_valid
add wave -noupdate /dcache_tb/cif/dwait
add wave -noupdate /dcache_tb/cif/dstore
add wave -noupdate /dcache_tb/DUT/flushcount
add wave -noupdate /dcache_tb/DUT/dirtyloop
add wave -noupdate /dcache_tb/DUT/count
add wave -noupdate /dcache_tb/DUT/nxt_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {792 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 151
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
WaveRestoreZoom {599 ns} {807 ns}
