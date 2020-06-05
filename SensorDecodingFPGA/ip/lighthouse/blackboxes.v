
//=======================
//===[MAIN MODUL]========
//=======================
module TS4231_init #(parameter CLK_FREQ_HZ = 48_000_000)
  (
    input clk,
    input clk_slow,
    input reset,  // reset

    input d_io,
      output reg oD_state_out = 0,
      output reg oD_out = 0,
    input e_io,
      output oE_state_out ,
      output oE_out,

    //output [0:14] cfg_data_reply,
    output cfg_done,
    output debug_flag_read_done,
    output debug_flag_write_done,

    input CONFIG_inital_delay,

    output [15:0] debug_LUT_cnt,
    output debug_cstatus,
    output debug_nstatus,
    output debug_difclk
  );

  //==== BASIC ENABLE/DISABLE block ======

  wire flag_start_config;
  reg last_start_config = 0;

  wire local_reset;
  //assign local_reset = reset | (!flag_start_config);///(reset)?1'b1:!reset0;
  assign local_reset = (!flag_start_config);

  //reg clk_slow = 0;
  /*wire clk_slow;

  reg[31:0] clk_counter=32'd0;
	localparam DIVISOR = 32'd20;
  localparam hDIVISOR = 32'd(DIVISOR/2);

  always @(posedge clk, posedge local_reset)begin
    if(local_reset)begin
      clk_counter <= 0;
    end else begin
      clk_counter <= clk_counter + 32'd1;
      if(clk_counter>=(DIVISOR-32'd1))begin
        clk_counter <= 32'd0;
      end

  //    clk_slow <= 1;
  //    if(counter < hDIVISOR)
    //    clk_slow <= 0;

    end
  end

  assign clk_slow = (counter < hDIVISOR)?1'b0:1'b1;//clock_out_reg;
*/

  //wire clock;
  //  assign clock = (flag_start_config)? 1'b0:clk;
  //wire clock_slow;
  //  assign clock_slow = (flag_start_config)? 1'b0:clk_slow;


  TS4231_init_delay #(
      .CLK_FREQ_HZ(CLK_FREQ_HZ),
      .WAITING_TIME_uS(600_000)
    ) TS4231_init_U0 (
      .clk   (clk),
      .start (reset),
      .flag_delayEnd  (flag_start_config)
    );




  localparam ISOUT = 1;
  localparam ISIN = 0;



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
  //localparam [0:14]config_value = 16'h392B; //shall be sent from the begining to the and ... starting with 3 1

  reg [0:19] LUT_E_INIT_INOUT   = 20'b0111_1111_1000_0000_0000; // //b0011_1111_1111_1111_1110
  reg [0:19] LUT_E_INIT         = 20'b0010_0111_1111_1111_1111; //  //b0000_1110_0011_1111_1111
  //first block init_w/r_cfg-data(16bit))
  //(init)_(w/r)_cfg_cfg_cfg
  //config _data 0011_1001_0010_1011
  reg [0:19] LUT_D_INIT_INOUT  =  20'b0000_0011_0000_0000_0000; // // b0000_0000_0000_0111_1110
  reg [0:19] LUT_D_INIT        =  20'b0100_0001_1000_1111_1111; // // b0000_0000_0000_0000_1111


  reg [0:47] LUT_E_INOUT        = 48'b0111_1111_11111111_11111111_11111111_111111_111111_1110;// b0011_1111_11111111_11111111_11111111_111111_111111_1110
  reg [0:47] LUT_E              = 48'b0111_1000_10101010_10101010_10101010_101010_000111_1111; //0111    b0011_1010_10101010_10101010_10101010_101010_111111_1110
  //first block init_w/r_cfg-data(16bit))
  //(init)_(w/r)_cfg_cfg_cfg
  //config _data 0011_1001_0010_1011
  reg [0:47] LUT_D_INOUT        = 48'b0011_1111_11111111_11111111_11111111_111111_111111_1110;//    b0001_1111_11111111_11111111_11111111_111111_111111_1110
  reg [0:47] LUT_D              = 48'b0011_0000_00111111_00001100_00110011_001111_000000_1111;//    b0001_0000_00111111_00001100_00110011_001111_111100_0000


  reg [0:51] LUT_E_READ_INOUT   = 52'b0111_1111_1111_11111111_11111111_11111111_111111_111111_1110;// b0011_1111_11111111_11111111_11111111_111111_111111_1110
  reg [0:51] LUT_E_READ         = 52'b1111_1000_1100_10101010_10101010_10101010_101010_000011_1111;// b0011_1010_10101010_10101010_10101010_101010_111001_1111
  //first block init_w/r_cfg-data(16bit))
  //(init)_(w/r)_cfg_cfg_cfg
  //config _data 0011_1001_0010_1011
  reg [0:51] LUT_D_READ_INOUT  =  52'b0011_1111_1000_00000000_00000000_00000000_000000_001111_1110;//b0011_1110_00000000_00000000_00000000_000000_111111_1111
  reg [0:51] LUT_D_READ        =  52'b1110_0011_1111_00000000_00000000_00000000_000000_000000_1111;// b0011_0011_00000000_00000000_00000000_000000_011100_0000

  //Trigger Watch_State
  /*reg [0:15] LUT_E_WATCH_INOUT   = 16'b0111_1000_0000_0000; //b0111_1100_0000_0000 //b0011_1000_0000_0000
  reg [0:15] LUT_E_WATCH         = 16'b1100_1100_0000_0000; // b1110_0111_0000_0000 //b1000_1100_0000_0000
  //first block init_w/r_cfg-data(16bit))
  //(init)_(w/r)_cfg_cfg_cfg
  //config _data 0011_1001_0010_1011
  reg [0:15] LUT_D_WATCH_INOUT  =  16'b0011_0000_0000_0000; //b0011_1000_0000_0000 // b0111_0000_0000_0000
  reg [0:15] LUT_D_WATCH        =  16'b1110_0000_0000_0000; //b111_0000_0000_0000 //b1110_0000_0000_0000
  */

  //reg [0:15] read_back_data;

  //localparam  LUT_STATE_WAIT = param_value;

  //regs for IN-OUT
  //reg e_state_out = 1;
  //reg D_out = 0;
  reg E_out_del = 0;
  reg E_state_out_del = 0;
  reg E_out = 0;
  reg E_state_out = 0;
  //reg E_out_delayed = 0;

  reg flag_E_delayed = 0;

  assign oE_out = (flag_E_delayed)?E_out_del:E_out;
  assign oE_state_out = (flag_E_delayed)?E_state_out_del:E_state_out;

  //assign d_io = (d_state_out)?D_out:1'bz;
  //assign e_io = (e_state_out)?E_out_delayed:1'bz;

  //===========================================

  reg [3:0] e_out_delay_cnt = 0;
  always @(posedge clk, posedge local_reset) begin: output_to_clk_delay
    if(local_reset)begin
      //oE_out <= 1;
      e_out_delay_cnt <= 0;
      E_out_del <= 0;
      E_state_out_del <= 1;

    end else begin
      e_out_delay_cnt <= e_out_delay_cnt + 1;
      if(e_out_delay_cnt >= 4'd3)begin
        E_out_del <= E_out;
        E_state_out_del <= E_state_out;
        e_out_delay_cnt <= 0;

      end

    end
  end


  //===========================================

  //===========================================

  reg flag_restart_watch;
  reg flag_restart_watch_approved;
  //reg [31:0] watch_time_out;


  //===========================================
  reg [7:0] LUT_cnt = 8'd0;

  reg flag_startup_trigger_delay;
  reg flag_allow_write = 0;
  reg flag_allow_read = 0;
  reg flag_write_done = 0;
  reg flag_read_done = 0;
  reg flag_LUT_overflow_triggerd;

  reg flag_data_recording;
  reg flag_data_recording_done;


  reg flag_lighthouse_detected;
  //reg [0:14] reg_cfg_data_reply = 0;
  reg flag_cfg_done = 0;
  //assign outputs with ther responding regs
  assign lighthouse_detected  = flag_lighthouse_detected;
  //assign cfg_data_reply       = reg_cfg_data_reply;//sync_reg;//reg_cfg_data_reply;
  assign cfg_done             = flag_cfg_done;


  //reg [0:15] sync_reg;
  //reg [15:0] foo_cnt = 0;

  //reg loopBACK_wasHIGH;
  //reg loopBACK_wasLOW;
  //reg [7:0] cnt_highlow_swaps;
  //reg flag_init_done;

  //TODO...when D never goes to LOW TS43231 chip needs to be reseted
  //BASICLY a timeouta

  //reg reg_d_io
  //reg flag_time_out_triggerd =0;
  //reg [15:0] reg_time_out = 0;
  //reg flag_first_boot = 0;
  /*
  always @(posedge clk, posedge local_reset)begin: sync_block//posedge dif_clk, posedge reset) begin: sync_block
    if(local_reset)begin
        cnt_highlow_swaps <= 0;
        loopBACK_wasHIGH  <= 0;
        flag_init_done <= 0;
        sync_reg <= 0;
        reg_time_out <= 0;
        flag_time_out_triggerd <= 0;
        flag_first_boot <= 0;
        //loopBACK_wasLOW   <= 0;
    end else begin
      ;//
    end
  end
  */

  /*
  always @(posedge oE_out, posedge local_reset)begin: reply_sync//posedge dif_clk, posedge reset) begin: sync_block
    if(local_reset)begin
        reg_cfg_data_reply <= 0;
    end else begin
      //DEBUG:Coment for normal
      //flag_data_recording <= 1;
      if(flag_allow_read)begin
        if(!oD_state_out)begin
          if(LUT_cnt <= 8'd37)begin
            if(LUT_cnt >= 8'd8)begin
              //flag_data_recording <= 1;
               //E is shiftet by one clock impuls ... and the low impuls is important there for data is greped befor we switch to high.
              if(d_io == 1'b1)begin
                  reg_cfg_data_reply <= (reg_cfg_data_reply<<1) | 1;//LUT_D_INOUT[LUT_cnt]<<LUT_cnt;//(reg_cfg_data_reply << 1) | LUT_D_INOUT[LUT_cnt]; //

              end else if(d_io == 1'b0) begin
                  reg_cfg_data_reply <= (reg_cfg_data_reply<<1) | 0;
              end

            end //else begin
              //reg_cfg_data_reply <= 0;
            //end
          end  //else begin ///if(LUT_cnt <= 16'd36)begin

          //end
        end//if(!oD_state_out)begin
      end//if(flag_allow_read)begin
    end
  end
  */

  reg [15:0] IDLE_CNT = 0;

  reg [31:0] INIT_IDLE = 0;
  reg [7:0] INIT_CNT_LUT = 0;

  reg [7:0] POST_CNT = 0;

  reg flag_start_post = 0;

  always @(posedge clk_slow) begin: INIT //, posedge local_reset
      /*if(local_reset)begin

        flag_write_done <= 0;
        INIT_IDLE <= 0;
        INIT_CNT_LUT <= 0;
        LUT_cnt <= 0;


        IDLE_CNT <= 0;
        INIT_IDLE <= 0;
        INIT_CNT_LUT <= 0;
        POST_CNT <= 0;
        flag_start_post <= 0;
        LUT_cnt <= 8'd0;
        flag_allow_write <= 0;
        flag_allow_read <= 0;
        flag_write_done <= 0;
        flag_read_done <= 0;
        flag_cfg_done <= 0;
      end else begin*/
      if(!flag_write_done)begin
          flag_start_post <= 0;
          flag_cfg_done <= 0;
          flag_read_done <= 0;
          if(flag_allow_write)begin
            LUT_cnt <= LUT_cnt + 8'd1;
          end else begin
            //hard_reset_delay
            LUT_cnt <= 8'd0;
            //if(hard_reset_ts4321 == 1'b0)begin
            //  hard_reset_ts4321 <= 1;
            //end else begin
              /*if(flag_init_done)begin
                flag_lighthouse_detected <= 1;
                flag_allow_write <= 1;
              end*/
            //end
          end

          oD_state_out <= LUT_D_INOUT[LUT_cnt];
          E_state_out <= LUT_E_INOUT[LUT_cnt];
          oD_out <= LUT_D[LUT_cnt];
          E_out <= LUT_E[LUT_cnt];

//always @ (posedge clk24MHz) begin : IDLE_RECONFIG
        	INIT_IDLE <= INIT_IDLE + 1;
          if(!flag_allow_write) begin
          	if(INIT_IDLE >= 32'd60000)begin
              flag_E_delayed <= 1;
              if(INIT_IDLE <= 32'd60100)begin
                oD_state_out <= LUT_D_INIT_INOUT[INIT_CNT_LUT];
                E_state_out <= LUT_E_INIT_INOUT[INIT_CNT_LUT];
                oD_out <= LUT_D_INIT[INIT_CNT_LUT];
                E_out <= LUT_E_INIT[INIT_CNT_LUT];
              end else begin
                INIT_CNT_LUT <= INIT_CNT_LUT + 1;
                if(INIT_CNT_LUT == 8'd19)begin
                  INIT_CNT_LUT <= 8'd19;
                end else begin
                  INIT_IDLE <= 32'd60000;
                end

              end
              if(INIT_IDLE == 32'd70100)begin
                flag_lighthouse_detected <= 1;
                flag_allow_write <= 1;
              end

          	end

          end




          if(LUT_cnt == 8'd47)begin
            LUT_cnt <= 0;
            flag_allow_write <= 0;
            flag_write_done <= 1;
    				flag_read_done <= 0;
    				flag_data_recording <= 0;
            //reg_cfg_data_reply <= 0;
            flag_allow_read <= 0;
            //hard_reset_ts4321 <= 0;
            //DEBUG
            //flag_cfg_done <= 1;
            //flag_allow_read <= 1;
            //flag_read_done <= 1;
          end
        end else begin
  		    if(!flag_read_done)begin
    				 if(flag_allow_read)begin
    				     LUT_cnt <= LUT_cnt + 8'd1;
    				 end else begin
      					oD_state_out <= 0;
      					E_state_out <= 0;
      					LUT_cnt <= 0;
    					//if(e_io)begin
    					  flag_allow_read <= 1;
    					//end
    				 end
    				 oD_state_out <= LUT_D_READ_INOUT[LUT_cnt];
    				 E_state_out <= LUT_E_READ_INOUT[LUT_cnt];
    				 oD_out <= LUT_D_READ[LUT_cnt];
    				 E_out <= LUT_E_READ[LUT_cnt];


    				 if(LUT_cnt == 8'd51)begin
      					LUT_cnt <= 0;
                flag_allow_read <= 0;
      					flag_read_done <= 1;
      					flag_start_post <= 1;
      					flag_data_recording_done <= 0;
      					flag_data_recording <= 0;
                flag_LUT_overflow_triggerd <= 1;
                IDLE_CNT <= 0;
    				 end
          end
        end
        if(flag_start_post)begin

          IDLE_CNT <= IDLE_CNT + 1;
          if(IDLE_CNT >= 16'd20000)begin
            POST_CNT <= POST_CNT + 1;


            case (POST_CNT)
              8'd0  : E_out         <= 1;
              8'd1  : E_state_out   <= 1;
              8'd2  : oD_out        <= 1;
              8'd3  : oD_state_out  <= 1;
              8'd4  : E_out         <= 0;
              8'd5  : oD_out        <= 0;
              8'd6  : oD_state_out  <= 0;
              8'd7  : E_out         <= 1;
              8'd8  : E_state_out   <= 0;
              8'd9  : flag_cfg_done <= 1;
              default : POST_CNT <= 8'd20;
            endcase

            if(IDLE_CNT == 16'd20020)begin
              LUT_cnt <= LUT_cnt + 1;
              IDLE_CNT <= 16'd20000;
            end

            if(LUT_cnt == 8'd15)begin
               LUT_cnt <= 8'd15;
               IDLE_CNT <= 0;
            end






          end


        end


        if(!flag_start_config)begin
          LUT_cnt <= 8'd0;

          IDLE_CNT <= 0;
          INIT_IDLE <= 0;
          INIT_CNT_LUT <= 0;
          POST_CNT <= 0;

          oD_state_out <= 0;
          E_state_out <= 0;
          oD_out <= 0;
          E_out <= 1;
          flag_write_done <= 0;
          flag_read_done <= 0;
          flag_allow_write <= 0;
          flag_allow_read <= 0;
          flag_startup_trigger_delay <= 0;
          flag_data_recording <= 0;
          flag_lighthouse_detected <= 0;
          flag_data_recording_done <= 0;
          flag_cfg_done <= 0;
          flag_start_post <= 0;
          //reg_cfg_data_reply <=16'd0;// 16'h392B;
          //sync_reg <= 16'h0010;
          //hard_reset_ts4321 <= 0;
          flag_restart_watch_approved <= 0;
          //hard_reset_delay <= 0;
          flag_LUT_overflow_triggerd <= 0;
          flag_E_delayed <= 0;


          flag_cfg_done <= 0;
        end
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
  //assign debug_difclk = dif_clk;
  /*
  assign debug_flag_write_done = flag_write_done;//flag_allow_read;//flag_write_done;//flag_write_done;
  assign debug_flag_read_done = flag_read_done;
  assign debug_cstatus = flag_start_config;
  assign debug_nstatus = flag_LUT_overflow_triggerd;
  assign debug_LUT_cnt = sync_reg;
  */

endmodule



module TS4231_init_delay(
    input clk,
    input start,
    output reg flag_delayEnd = 0
  );


  parameter CLK_FREQ_HZ = 48_000_000;
  parameter WAITING_TIME_uS = 10_000;

  localparam CNT_MAX = WAITING_TIME_uS * (CLK_FREQ_HZ / 1_000_000);


  //localparam real CNT_MAX = 4800;


  reg [27:0] delay_cnt = 0;
  reg delayed_reset = 1;

  always @ ( posedge clk ) begin
    /*if(start)begin
      delay_cnt <= 0;
      delayed_reset <= 1;
      flag_delayEnd <= 0;
    end else begin*/
      delay_cnt <= delay_cnt + 1;
      flag_delayEnd <= 0;
      if(delay_cnt == CNT_MAX) begin
        flag_delayEnd <= 1;
        delay_cnt <= CNT_MAX;
      end

      if(start) begin
        flag_delayEnd <= 0;
        delay_cnt <= 0;
      end
    //end
  end

endmodule
