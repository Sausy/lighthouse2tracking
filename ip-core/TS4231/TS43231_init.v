//=======================
//===[MAIN MODUL]========
//=======================
module TS43231_init #(parameter CLK_FREQ_HZ = 48_000_000)
  (
    input clock,  // clock
    input reset,  // reset

    inout d_io,
    inout e_io,

    output hard_reset_ts4321,

    input start_cfg,
    input start_watch,

    output lighthouse_detected,
    output cfg_done,
    output [0:14] cfg_data_reply,

    output [15:0] debug_LUT_cnt,
    output debug_cstatus,
    output debug_nstatus,
    output debug_difclk,
    output debug_flag_read_done,
    output debug_flag_write_done
  );


  localparam ISOUT = 1;
  localparam ISIN = 0;

  wire dif_clk;
  wire dif_clk2;
  clock_divider uclk_dif (
		.clock_in 	(clock),
		.reset 		 (reset),
		.clock_out 	(dif_clk)
	);
  clock_divider uclk_dif2 (
    .clock_in 	(dif_clk),
    .reset 		 (reset),
    .clock_out 	(dif_clk2)
  );


  //since every waiting time exeds the precision of 50MHz a 100ns delay will be used.
  //100ns was chosen because it would also work on another testboard with 4MHz clk
  localparam T_WAIT_SETUP = CLK_FREQ_HZ/1_000_000;
    //Tstart 80 ns
    //Tpw    40 ns
    //Tsetup 15 ns
    //Thold  15 ns
    //Tend   80 ns
    //Tread  20 ns
  localparam BIT_TRANSMIT_FREQ = CLK_FREQ_HZ/1_000_000;//1MHz
  //Freq Input pulse 1-10 MHz

  //config length = 14 ... !!!
  //Config  = (0x392B << 1) == 7256
  localparam [0:14]config_value = 16'h392B; //shall be sent from the begining to the and ... starting with 3 1

  reg [0:47] LUT_E_INOUT  = 48'b0011_1111_11111111_11111111_11111111_111111_111111_1000;
  reg [0:47] LUT_E        = 48'b0011_1010_10101010_10101010_10101010_101010_111111_1000;
  //first block init_w/r_cfg-data(16bit))
  //(init)_(w/r)_cfg_cfg_cfg
  //config _data 0011_1001_0010_1011
  reg [0:47] LUT_D_INOUT  = 48'b0001_1111_11111111_11111111_11111111_111111_111111_1000;
  reg [0:47] LUT_D        = 48'b0001_0000_00111111_00001100_00110011_001111_000011_1000;


  reg [0:47] LUT_E_READ_INOUT   = 48'b0011_1111_11111111_11111111_11111111_111111_111111_1000;
  reg [0:47] LUT_E_READ         = 48'b0011_1010_10101010_10101010_10101010_101010_111111_1000;
  //first block init_w/r_cfg-data(16bit))
  //(init)_(w/r)_cfg_cfg_cfg
  //config _data 0011_1001_0010_1011
  reg [0:47] LUT_D_READ_INOUT  =  48'b0011_1110_00000000_00000000_00000000_000000_011111_1000;
  reg [0:47] LUT_D_READ        =  48'b0010_0010_00000000_00000000_00000000_000000_000011_1000;

  //Trigger Watch_State
  reg [0:15] LUT_E_WATCH_INOUT   = 16'b1111_1111_1111_1110;
  reg [0:15] LUT_E_WATCH         = 16'b0000_0000_0111_1110;
  //first block init_w/r_cfg-data(16bit))
  //(init)_(w/r)_cfg_cfg_cfg
  //config _data 0011_1001_0010_1011
  reg [0:15] LUT_D_WATCH_INOUT  =  16'b0000_0001_1111_1110;
  reg [0:15] LUT_D_WATCH        =  16'b0000_0000_0000_0000;

  reg [0:15] read_back_data;

  //localparam  LUT_STATE_WAIT = param_value;

  //regs for IN-OUT
  reg d_state_out = 1;
  reg e_state_out = 1;
  reg D_out = 0;
  reg E_out = 0;
  reg E_out_delayed = 0;

  assign d_io = (d_state_out)?D_out:1'bz;
  assign e_io = (e_state_out)?E_out_delayed:1'bz;


  //===========================================

  always @(posedge clock, posedge reset) begin: output_to_clk_delay
    if(reset)begin
      E_out_delayed <= 0;
    end else begin
      E_out_delayed <= E_out;
    end
  end


  //===========================================

  //===========================================

  reg flag_restart_watch;
  reg flag_restart_watch_approved;
  reg [15:0] watch_time_out;


  always @(posedge dif_clk2, posedge reset) begin: sleep_prevent
    if(reset)begin
      flag_restart_watch <= 0;
      watch_time_out <= 0;
    end else begin
      if(e_io == 1'b1)begin
        if(d_io == 1'b1)begin
          watch_time_out <= watch_time_out + 1;
        end
      end
      if(e_io == 1'b0)begin
        watch_time_out <= 0;
      end
      if(d_io == 1'b0)begin
        watch_time_out <= 0;
      end

      if(flag_restart_watch_approved)begin
        flag_restart_watch <= 0;
      end
      if(watch_time_out == 16'd40000)begin
        flag_restart_watch <= 1;
        watch_time_out <= 0;
      end
    end
  end

  //===========================================


  //===========================================

  reg flag_start_conv;

  always @(posedge clock, posedge reset) begin: restart_config
    if(reset)begin
      flag_start_conv <= 0;
    end else begin
		  flag_start_conv <= 0;
      if(start_cfg)begin
  			if(cfg_done)begin
  				flag_start_conv <= 1;
  			end
      end
    end
  end


  //===========================================
  reg [15:0] LUT_cnt = 16'd0;

  reg flag_startup_trigger_delay;
  reg flag_allow_write;
  reg flag_allow_read;
  reg flag_write_done;
  reg flag_read_done;
  reg flag_LUT_overflow_triggerd;

  reg flag_data_recording;
  reg flag_data_recording_done;


  reg flag_lighthouse_detected;
  reg [0:14] reg_cfg_data_reply;
  reg flag_cfg_done;
  //assign outputs with ther responding regs
  assign lighthouse_detected  = flag_lighthouse_detected;
  assign cfg_data_reply       = reg_cfg_data_reply;//sync_reg;//reg_cfg_data_reply;
  assign cfg_done             = flag_cfg_done;


  reg [0:15] sync_reg;
  reg [15:0] foo_cnt = 0;

  reg loopBACK_wasHIGH;
  //reg loopBACK_wasLOW;
  reg [7:0] cnt_highlow_swaps;
  reg flag_init_done;

  //TODO...when D never goes to LOW TS43231 chip needs to be reseted
  //BASICLY a timeouta
  always @(posedge clock, posedge reset)begin: sync_block//posedge dif_clk, posedge reset) begin: sync_block
    if(reset)begin
        cnt_highlow_swaps <= 0;
        loopBACK_wasHIGH  <= 0;
        flag_init_done <= 0;
        //loopBACK_wasLOW   <= 0;
    end else begin
         if(flag_start_conv) begin
          flag_init_done <=0;
          cnt_highlow_swaps <= 8'd0;
         end

        if(hard_reset_ts4321)begin
          if(!flag_lighthouse_detected)begin
            if(!d_state_out)begin
              if(d_io == 1'b1) begin
                loopBACK_wasHIGH <= 1;
              end else if (d_io == 1'b0) begin
                loopBACK_wasHIGH <= 0;
                if(loopBACK_wasHIGH)begin
                  cnt_highlow_swaps <= cnt_highlow_swaps + 1;
                end
              end
            end
            if(cnt_highlow_swaps >= 8'd4)begin
              cnt_highlow_swaps   <= 8'd5;
              flag_init_done      <= 1;
            end
          end
        end else begin
          flag_init_done <=0;
          cnt_highlow_swaps <= 8'd0;
        end

    end
  end

  always @(posedge E_out_delayed, posedge reset)begin: reply_sync//posedge dif_clk, posedge reset) begin: sync_block
    if(reset)begin
        reg_cfg_data_reply <= 0;
    end else begin
      //DEBUG:Coment for normal
      //flag_data_recording <= 1;
      if(flag_allow_read)begin
        if(!d_state_out)begin
          if(LUT_cnt <= 16'd37)begin
            if(LUT_cnt >= 16'd8)begin
              //flag_data_recording <= 1;
               //E is shiftet by one clock impuls ... and the low impuls is important there for data is greped befor we switch to high.
              if(d_io == 1'b1)begin
                  reg_cfg_data_reply <= (reg_cfg_data_reply<<1) | 1;//LUT_D_INOUT[LUT_cnt]<<LUT_cnt;//(reg_cfg_data_reply << 1) | LUT_D_INOUT[LUT_cnt]; //
              end else if(d_io == 1'b0) begin
                  reg_cfg_data_reply <= (reg_cfg_data_reply<<1) | 0;
              end

            end else begin
              reg_cfg_data_reply <= 0;
            end
          end  //else begin ///if(LUT_cnt <= 16'd36)begin

          //end
        end//if(!d_state_out)begin
      end//if(flag_allow_read)begin
    end
  end

  //reg [7:0] hard_reset_delay;
  always @(posedge dif_clk2, posedge reset) begin: INIT
    if(reset)begin
      LUT_cnt <= 16'd0;
      d_state_out <= 1;
      e_state_out <= 1;
      D_out <= 0;
      E_out <= 0;
      flag_write_done <= 0;
      flag_read_done <= 0;
      flag_allow_write <= 0;
      flag_allow_read <= 0;
  		flag_startup_trigger_delay <= 0;
  		flag_data_recording <= 0;
  		flag_lighthouse_detected <= 0;
  		flag_data_recording_done <= 0;
      flag_cfg_done <= 0;
		  //reg_cfg_data_reply <=16'd0;// 16'h392B;
      //sync_reg <= 16'h0010;
      hard_reset_ts4321 <= 0;
      flag_restart_watch_approved <= 0;
      //hard_reset_delay <= 0;
      flag_LUT_overflow_triggerd <= 0;
    end else begin//if (dif_clk) begin
		  if(flag_start_conv) begin
				flag_write_done <= 0;
				flag_read_done <= 0;
				flag_cfg_done <= 0;
				LUT_cnt <= 16'd0;
				flag_lighthouse_detected<= 0;
        hard_reset_ts4321 <= 0;
        //hard_reset_delay <= 0;
		  end
		  if(!flag_write_done)begin
          flag_cfg_done <= 0;
          if(flag_allow_write)begin
            LUT_cnt <= LUT_cnt + 16'd1;
          end else begin
            //hard_reset_delay
            LUT_cnt <= 16'd0;
            if(hard_reset_ts4321 == 1'b0)begin
              hard_reset_ts4321 <= 1;
            end else begin
              if(flag_init_done)begin
                flag_lighthouse_detected <= 1;
                flag_allow_write <= 1;
              end
            end
          end

  				/*//DEBUG:Coment for normal
  				if(LUT_cnt <= 16'd36)begin
  					if(LUT_cnt >= 16'd8)begin
  						flag_data_recording <= 1;
              if(LUT_E_READ[LUT_cnt] == 1)begin //E is shiftet by one clock impuls ... and the low impuls is important there for data is greped befor we switch to high.
                sync_reg <= (sync_reg<<1) | LUT_D[LUT_cnt];//LUT_D_INOUT[LUT_cnt]<<LUT_cnt;//(reg_cfg_data_reply << 1) | LUT_D_INOUT[LUT_cnt]; //
              end
  					end //else begin
            //  reg_cfg_data_reply <= 0;
            //end
  				end// else begin
  				//	flag_data_recording_done <= 1;
  				//end
          //==========
*/
          //reg_cfg_data_reply <= LUT_cnt;
          /*
          if(LUT_cnt <= 16'd36)begin
            reg_cfg_data_reply <= 16'haaaa;
            if(LUT_cnt >= 16'd8)begin
              reg_cfg_data_reply <= 16'hcccc;
            end
          end else begin
            reg_cfg_data_reply <= 0;
          end

          if(LUT_cnt >= 16'd8)begin
            reg_cfg_data_reply <= 16'hcccc;
          end*/


          d_state_out <= LUT_D_INOUT[LUT_cnt];
          e_state_out <= LUT_E_INOUT[LUT_cnt];
          D_out <= LUT_D[LUT_cnt];
          E_out <= LUT_E[LUT_cnt];

          if(LUT_cnt == 16'd47)begin
            LUT_cnt <= 0;
            flag_allow_write <= 0;
            flag_write_done <= 1;
    				flag_read_done <= 0;
    				flag_data_recording <= 0;
            //reg_cfg_data_reply <= 0;
            flag_allow_read <= 0;
          end
        end else begin
  		    if(!flag_read_done)begin
    				 if(flag_allow_read)begin
    				     LUT_cnt <= LUT_cnt + 16'd1;
    				 end else begin
      					d_state_out <= 0;
      					e_state_out <= 0;
      					LUT_cnt <= 0;
    					//if(e_io)begin
    					  flag_allow_read <= 1;
    					//end
    				 end
    				 d_state_out <= LUT_D_READ_INOUT[LUT_cnt];
    				 e_state_out <= LUT_E_READ_INOUT[LUT_cnt];
    				 D_out <= LUT_D_READ[LUT_cnt];
    				 E_out <= LUT_E_READ[LUT_cnt];


    				 if(LUT_cnt == 16'd47)begin
      					LUT_cnt <= 0;
                flag_allow_read <= 0;
      					flag_read_done <= 1;
      					flag_cfg_done <= 1;
      					flag_data_recording_done <= 0;
      					flag_data_recording <= 0;
                flag_LUT_overflow_triggerd <= 1;
    				 end
          end
        end
        if(flag_cfg_done)begin
          LUT_cnt <= LUT_cnt + 1;
          //TODO: AD start_watch as additional input
          d_state_out <= LUT_D_WATCH_INOUT[LUT_cnt];
          e_state_out <= LUT_E_WATCH_INOUT[LUT_cnt];
          D_out <= LUT_D_WATCH[LUT_cnt];
          E_out <= LUT_E_WATCH[LUT_cnt];


          if(LUT_cnt == 8'd15)begin
             LUT_cnt <= 8'd15;
          end

          //if(start_watch)begin
          //  LUT_cnt <= 0;
          //end


          if(flag_restart_watch)begin
            flag_restart_watch_approved <= 1;
            LUT_cnt <= 0;
          end
          if(flag_restart_watch_approved)begin
            if(!flag_restart_watch)
              flag_restart_watch_approved <= 0;
          end


        end
    end //else begin
      //if (LUT_cnt == 0) begin
        //LUT_cnt <= 16'h0220;
        //if(LUT_cnt == 15'd47)begin
        //  LUT_cnt <= 0;
        //end
      //end
    //end
  end



  //----- [DEBUG STUFF] -----
  /*always @(posedge clock) begin: DEBUG_DATA
		debug_cstatus <= 1;
		//debug_nstatus <=
		debug_difclk <= dif_clk;
		//debug_flag_read_done <=
		debug_flag_write_done <= flag_allow_write;
  end*/
  assign debug_difclk = dif_clk;
  assign debug_flag_write_done = flag_write_done;//flag_write_done;
  assign debug_flag_read_done = flag_allow_write;
  assign debug_cstatus = LUT_D[LUT_cnt];
  assign debug_nstatus = flag_LUT_overflow_triggerd;
  assign debug_LUT_cnt = sync_reg;

endmodule


module clock_divider (
      input clock_in,
      input reset,
      output clock_out
      //input [27:0] divider
    );
    reg[31:0] counter=32'd0;
    //TODO: !!!! CHANGED FOR DEBUG
	 localparam DIVISOR = 32'd10;
	 //DEBUG: !!!!
	 //parameter DIVISOR = 28'd4;

    always @(posedge clock_in, posedge reset)
      if(reset)begin
        counter <= 0;
      end else begin
        counter <= counter + 32'd1;
        if(counter>=(DIVISOR-32'd1))begin
          counter <= 32'd0;
        end
      end

    assign clock_out = (counter<DIVISOR/2)?1'b0:1'b1;//clock_out_reg;
endmodule
