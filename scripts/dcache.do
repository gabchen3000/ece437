onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/PROG/testcase
add wave -noupdate /dcache_tb/cif/dload
add wave -noupdate /dcache_tb/dcif/dmemREN
add wave -noupdate /dcache_tb/dcif/dmemaddr
add wave -noupdate -expand -group dcache -expand -subitemconfig {{/dcache_tb/DUT/frame1[7]} -expand {/dcache_tb/DUT/frame1[1]} -expand} /dcache_tb/DUT/frame1
add wave -noupdate -expand -group dcache -expand -subitemconfig {{/dcache_tb/DUT/frame2[7]} -expand {/dcache_tb/DUT/frame2[2]} -expand {/dcache_tb/DUT/frame2[1]} -expand} /dcache_tb/DUT/frame2
add wave -noupdate -expand -group lru -expand /dcache_tb/DUT/lru
add wave -noupdate -expand -group lru /dcache_tb/DUT/nxt_lru
add wave -noupdate /dcache_tb/dcif/halt
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /dcache_tb/PROG/dcif/dhit
add wave -noupdate /dcache_tb/PROG/dcif/dmemload
add wave -noupdate /dcache_tb/PROG/dcif/dmemWEN
add wave -noupdate /dcache_tb/PROG/dcif/dmemstore
add wave -noupdate -expand -group state /dcache_tb/DUT/cur_state
add wave -noupdate -expand -group state /dcache_tb/DUT/nxt_state
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
WaveRestoreCursors {{Cursor 1} {6 ns} 0}
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
WaveRestoreZoom {916 ns} {1073 ns}
