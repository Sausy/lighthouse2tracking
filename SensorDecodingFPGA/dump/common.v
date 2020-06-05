module dbg_init_delay(
    input clk,
    input start,
    output reg flag_delayEnd = 0
  );


  parameter CLK_FREQ_HZ = 48_000_000;
  parameter WAITING_TIME_uS = 10_000;

  localparam CNT_MAX = WAITING_TIME_uS * (CLK_FREQ_HZ / 1_000_000);


  //localparam real CNT_MAX = 4800;


  reg [31:0] delay_cnt = 0;
  reg delayed_reset = 1;

  always @ ( posedge clk ) begin
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
  end

endmodule
//========================================

module dbg_inout #(parameter CLK_FREQ_HZ = 48_000_000)
  (
      input clk,
      input reset,

      inout io_e_0,
      inout io_d_0,

      output [3:0] dbg_flags
  );
  wire cfg_done;

  reg dbg_d0_in;
  wire dbg_d0_out;
  wire dbg_d0_oe;

  reg dbg_e0_in;
  wire dbg_e0_out;
  wire dbg_e0_oe;

  assign io_e_0 = (dbg_e0_oe)?dbg_e0_out:1'bz;
  assign io_d_0 = (dbg_d0_oe)?dbg_d0_out:1'bz;


  wire slow_clk;
    reg reg_clk24MHz = 1'b0;
    assign slow_clk = reg_clk24MHz;//(start_lighthouse)?reg_clk12MHz:1'b0;// reg_clk12MHz;

  wire clk12MHz;
    reg reg_clk12MHz = 1'b0;
    assign clk12MHz = reg_clk12MHz;//(start_lighthouse)?reg_clk12MHz:1'b0;// reg_clk12MHz;


  wire clk6MHz;
    reg reg_clk6MHz = 1'b0;
    assign clk6MHz = reg_clk6MHz;//(start_lighthouse)?reg_clk6MHz:1'b0;// reg_clk12MHz;

  always @(posedge clk) begin : half_clk1
      reg_clk24MHz <= !reg_clk24MHz;
      if(reg_clk24MHz)begin
        reg_clk12MHz <= !reg_clk12MHz;
        if(reg_clk12MHz)begin
          reg_clk6MHz <= !reg_clk6MHz;
        end
      end
  end




  always @ ( posedge clk ) begin
      dbg_d0_in <= 0;
      dbg_e0_in <= 0;
      if(io_e_0) begin
        dbg_e0_in <= 1;
      end
      if(io_d_0) begin
        dbg_d0_in <= 1;
      end
  end

  reg foo_shithead = 0;

  always @ ( posedge slow_clk ) begin
    dbg_flags[2] <= foo_shithead;
    foo_shithead <= !foo_shithead;
  end

  assign dbg_flags[0] = delay_done;
  assign dbg_flags[1] = delay_done;

 wire delay_done;

  TS4231_init #(
      .CLK_FREQ_HZ(48_000_000)
    ) ts4231Configurator_1_ (
        .clk                (clk),
        .clk_slow           (clk6MHz),
        .reset              (1'b0),

        .d_io               (dbg_d0_in),
        .oD_out             (dbg_d0_out),
        .oD_state_out       (dbg_d0_oe),

        .e_io               (dbg_e0_in),
        .oE_out             (dbg_e0_out),
        .oE_state_out       (dbg_e0_oe),

        .debug_cstatus      (delay_done),
        .cfg_done           (cfg_done),
        .CONFIG_inital_delay   (1'b1)

   )/* synthesis syn_noprune=1 */;



  //always @ ( posedge clk48MHz ) begin
   //PIN_19 <= clk6MHz;//cfg_done;//dbg_e0_out;
  //end
  /*
  dbg_init_delay dbg_udelay(clk,1'b0,cfg_done);

  reg [21:0] delayed_reset_cnt = 0;
  reg delayed_reset = 1;
  always @ (posedge slow_clk ) begin

    //cfg_done <= 1;

    delayed_reset_cnt <= 0;
    delayed_reset <= 0;
    //PIN_19 <= 0;

    case (delayed_reset_cnt)
        8'd0  : dbg_e0_oe   <= 1;
        8'd1  : dbg_d0_oe   <= 1;
        8'd2  : dbg_d0_out  <= 1;
        8'd3  : dbg_e0_out  <= 1;
        8'd4  : dbg_d0_out  <= 0;
        8'd5  : dbg_e0_out  <= 0;
        8'd6  : dbg_d0_out  <= 1;
        8'd7  : dbg_e0_out  <= 1;
        8'd8  : dbg_d0_out  <= 0;
        8'd9  : dbg_d0_oe   <= 0;
        8'd10 : dbg_e0_oe   <= 0;
        default : ;
    endcase


    if(cfg_done) begin
      delayed_reset_cnt <= delayed_reset_cnt + 1;
    end else begin
      dbg_d0_out <= 1'b0;
      dbg_d0_oe  <= 1'b0;

      dbg_e0_out <= 1'b0;
      dbg_e0_oe  <= 1'b1;
    end

    if(delayed_reset_cnt == 32'd1000000)begin
      delayed_reset <= 1;
      //PIN_19 <= 1;
      delayed_reset_cnt <= 32'd1000001;
    end
    if(delayed_reset_cnt == 32'd1000100)begin
      delayed_reset <= 0;
      delayed_reset_cnt <= 32'd1000100;
    end

  end*/

endmodule
