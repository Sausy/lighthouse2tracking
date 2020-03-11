module data_pars #(parameter CLK_FREQ_HZ = 48_000_000)
(
  input clock,  // clock
  input reset,  // reset

  input [31:0] data_frames[0:200],

  output debug_cstatus,
  output debug_nstatus
);


//uint32_t r = data[i];
//		uint32_t is_interesting = r != 0x00000000 && r != 0xffffffff;
endmodule
