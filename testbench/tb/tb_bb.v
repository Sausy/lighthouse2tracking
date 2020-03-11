
module tb (
	clk_clk,
	reset_reset_n,
	ts4231_d_io,
	ts4231_e_io,
	ts4231_current_state,
	ts4231_current_sensor,
	ts4231_sensor_state,
	ts4231_watch_state);	

	input		clk_clk;
	input		reset_reset_n;
	inout	[9:0]	ts4231_d_io;
	inout	[9:0]	ts4231_e_io;
	output	[3:0]	ts4231_current_state;
	output	[7:0]	ts4231_current_sensor;
	output	[2:0]	ts4231_sensor_state;
	output	[9:0]	ts4231_watch_state;
endmodule
