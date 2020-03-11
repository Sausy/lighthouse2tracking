//`include "timescale.v"
//the first modul is necessary otherwise quartus wouldn't allow Analysis&Synthesis
//this is literaly 
module TB_TS4(input clock,input reset);
	reg foo;
	always @(posedge clock)
		foo <= 0;
endmodule

module tb_interface();

reg         clock                   ;
reg         reset                   ;
wire        d_io                    ;
reg	       d_io_direct            ;
reg	       d_io_value             ;
wire        e_io                    ;
reg	       e_io_direct            ;
reg	       e_io_value             ;
wire        cfg_done                ;
wire        debug_cstatus           ;
wire        debug_nstatus           ;
wire        debug_difclk            ;
 reg        debug_difclk_reg            ;
wire        debug_flag_read_done    ;
wire[15:0]  debug_LUT_cnt;

reg start_cfg;
wire lighthouse_detected;
wire [0:14] cfg_data_reply;

localparam defOUT = 1;
localparam defIN = 0;

assign d_io = d_io_direct ? d_io_value:1'bz;
assign e_io = e_io_direct ? e_io_value:1'bz;

TS43231_init uut (
    .clock                   (    clock                   ),
    .reset                   (    reset                   ),
    .d_io                    (    d_io                    ),
    .e_io                    (    e_io                    ),
    .cfg_done                (    cfg_done                ),
    .debug_cstatus           (    debug_cstatus           ),
    .debug_nstatus           (    debug_nstatus           ),
    .debug_difclk            (    debug_difclk            ),
    .debug_flag_read_done    (    debug_flag_read_done    ),
	 .debug_LUT_cnt			  ( 	 debug_LUT_cnt),
	 .start_cfg (start_cfg),
	 .lighthouse_detected(lighthouse_detected),
	 .cfg_data_reply (cfg_data_reply)
);

TB_TS4 u0(
	.clock                   (    clock                   ),
   .reset                   (    reset                   )
);

parameter PERIOD = 10;
integer i = 0;

initial begin

	 clock = 1'b0;
	 start_cfg = 1'b0;
	 for (i = 0; i < 600; i = i + 1) begin
		#(PERIOD/2) clock = 0;
		case (i)
			1: begin 
				reset = 0;
				d_io_direct = defIN; 
				e_io_direct = defIN; 
			end
			2: reset = 1;
			3: reset = 0;
			5: begin 
					d_io_direct = defOUT; 
					d_io_value = 1;
				end
			20: d_io_value = 1'b0; 
			25: d_io_direct = defIN; 
			250:begin
					d_io_direct = defOUT; 
					d_io_value = 1;
				end
			/*261:d_io_value = 0;
			262:d_io_value = 1;
			263:d_io_value = 0;
			264:d_io_value = 1;
			265:d_io_value = 0;
			266:d_io_value = 1;
			267:d_io_value = 0;
			268:d_io_value = 1;
			269:d_io_value = 0;
			270:d_io_value = 1;
			271:d_io_value = 0;
			272:d_io_value = 1;*/
			400:start_cfg = 1;
			420:start_cfg = 0;
			430:begin
					d_io_direct = defOUT; 
					d_io_value = 1;
				 end
			440: d_io_value = 1'b0; 
			445: d_io_direct = defIN; 
		endcase
		#(PERIOD/2) clock = 1;
	 end
	 /*
	 for (i = 0; i < 240; i = i + 1) begin
		#(PERIOD/2) clock = 0;
		case (i)
			1: begin 
				reset = 0;
				d_io_direct = defIN; 
				e_io_direct = defIN; 
			end
			2: reset = 1;
			3: reset = 0;
			5: begin 
					d_io_direct = defOUT; 
					d_io_value = 1;
				end
			20: d_io_value = 1'b0; 
			25: d_io_direct = defIN; 
		endcase
		#(PERIOD/2) clock = 1;
	 end*/
end

endmodule




