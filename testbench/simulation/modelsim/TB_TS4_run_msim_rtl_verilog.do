transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/sausy/Projects/lighthouse/lighthouse2tracking/testbench {/home/sausy/Projects/lighthouse/lighthouse2tracking/testbench/TB_TS4.v}

