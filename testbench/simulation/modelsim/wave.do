onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_interface/uut/lighthouse_detected
add wave -noupdate /tb_interface/uut/clock
add wave -noupdate /tb_interface/uut/debug_difclk
add wave -noupdate -label reset /tb_interface/uut/reset
add wave -noupdate -color Gold -label E-Bus /tb_interface/uut/e_io
add wave -noupdate -label Data /tb_interface/uut/d_io
add wave -noupdate -label {reply data} -radix hexadecimal /tb_interface/uut/cfg_data_reply
add wave -noupdate /tb_interface/uut/cfg_done
add wave -noupdate /tb_interface/uut/debug_flag_read_done
add wave -noupdate /tb_interface/uut/debug_flag_write_done
add wave -noupdate /tb_interface/uut/start_cfg
add wave -noupdate -radix decimal /tb_interface/uut/debug_LUT_cnt
add wave -noupdate /tb_interface/uut/debug_nstatus
add wave -noupdate /tb_interface/uut/debug_cstatus
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2962 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {1 ns}
