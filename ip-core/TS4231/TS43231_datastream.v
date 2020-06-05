module ts4231_datastream #(parameter CLK_FREQ_HZ = 48_000_000,parameter BUFFER_REG_LENGTH = 512,parameter BUFFER_ARRAY_SIZE_MAX = 10)
  (
    input clock,  // clock
    input reset,  // reset

    input allow_capture,

    input envelope_input,
    input data_input,

    output [0:BUFFER_REG_LENGTH-1] data[0:BUFFER_ARRAY_SIZE_MAX],
    output [7:0] register_counter_data,
    output capture_done,

    output dbg_out1
  );

  localparam BUFFER_REGISTER_MAXidizes = BUFFER_REG_LENGTH - 1;
  localparam SLOW_DATA_f = 50; //one Revolution 50Hz == 20ms
  //lfsr poly only changes every Revolution
  localparam CLK_WAIT_CNT_MAX = CLK_FREQ_HZ*1/SLOW_DATA_f; //for 10ms ... shlould equal 480000
  reg [31:0] CLK_WAIT_CNT;

  wire dif_clk_data;
  clock_divider2 uclk_dif3 (
		.clock_in 	(clock),
		.reset 		 (reset),
		.clock_out 	(dif_clk_data)
	);

  //AFTER a time of 600-900ns (just say 1us) where Data is low
  //
  //
  localparam TIMEOUT_MAX = 50;//CLK_FREQ_HZ/1_000_000;

  reg [0:BUFFER_REGISTER_MAXidizes] byte_stream [0:BUFFER_ARRAY_SIZE_MAX]; //PS.: acess byte_stream[0-10]    byte_stream[0-10][0:500]
  reg flag_DATA_present;
  reg [7:0] ring_loop_cnt;//output [7:0] register_counter_data;
  //reg [7:0] bit_cnt;

  reg [15:0] bit_cnt;

  //reg rec_data;
  reg flag_stream_valid;

  reg flag_data_timeout;
  reg [15:0] flag_data_timeout_cnt;

  //DEBUG
  reg [15:0] dbg_cnt;

  reg flag_cap_data;
  reg [3:0] flag_slow_triger;
  reg envelope_event_cnt;

  integer i;
  always @(posedge dif_clk_data, posedge reset) begin: BIT2BYTE
    if(reset)begin
      flag_DATA_present <= 0;
      ring_loop_cnt <= 0;
      //bit_cnt <= 0;
      flag_stream_valid <= 0;
      flag_data_timeout <= 0;
      flag_data_timeout_cnt <= 0;
      capture_done <= 0;
      for (i=0; i<=BUFFER_ARRAY_SIZE_MAX; i=i+1)
            byte_stream[i] <= 0;
      dbg_cnt <= 0;
      register_counter_data <= 0;
      flag_cap_data <= 0;
      bit_cnt <= 0;
      flag_slow_triger <= 0;
    end else begin
      capture_done <= 0;
      if(flag_cap_data)begin
        bit_cnt <= bit_cnt + 1;
        CLK_WAIT_CNT <= CLK_WAIT_CNT + 1;
        if(!envelope_input)begin
          CLK_WAIT_CNT <= 0;
          envelope_event_cnt <= envelope_event_cnt + 1;
        end
      end else begin
        //CLK_WAIT_CNT <= 0x; 
      end

      if(CLK_WAIT_CNT == CLK_WAIT_CNT_MAX)begin
          ring_loop_cnt <= ring_loop_cnt +1;
          flag_cap_data <= 0;
      end




      if(data_input == 1'b1)begin
          flag_cap_data <= 1;
          byte_stream[ring_loop_cnt] <= (byte_stream[ring_loop_cnt] << 1) |  data_input;//LUT_D_INOUT[LUT_cnt]<<LUT_cnt;//(reg_cfg_data_reply << 1) | LUT_D_INOUT[LUT_cnt]; //
      end else if(data_input == 1'b0) begin
          byte_stream[ring_loop_cnt] <= (byte_stream[ring_loop_cnt] << 1) |  1;
      end

      if(bit_cnt == (BUFFER_REG_LENGTH-1))begin
        bit_cnt <= 0;

        capture_done <= 1;
        ring_loop_cnt <= ring_loop_cnt +1;
      end

      if(CLK_WAIT_CNT == CLK_WAIT_CNT_MAX)begin
          capture_done <= 1;
          ring_loop_cnt <= ring_loop_cnt +1;
          flag_cap_data <= 0;
          bit_cnt <= 0;
      end

      if(ring_loop_cnt <= 1)begin
        register_counter_data <= 0;
      end else begin
        register_counter_data <= ring_loop_cnt-1;
      end

      /*

      if(!envelope_input)begin
        flag_stream_valid <= 1;
        flag_data_timeout_cnt <= 0;
      end

      //collects data in buffer
      if(data_input == 1'b1)begin
          byte_stream[ring_loop_cnt] <= (byte_stream[ring_loop_cnt] << 1) |  data_input;//LUT_D_INOUT[LUT_cnt]<<LUT_cnt;//(reg_cfg_data_reply << 1) | LUT_D_INOUT[LUT_cnt]; //
      end else if(data_input == 1'b0) begin
          byte_stream[ring_loop_cnt] <= (byte_stream[ring_loop_cnt] << 1) |  data_input;
      end

      if(ring_loop_cnt <= 1)begin
        register_counter_data <= 0;
      end else begin
        register_counter_data <= ring_loop_cnt-1;
      end

      dbg_cnt <= dbg_cnt + 1;
      if(dbg_cnt == BUFFER_REGISTER_MAXidizes)begin
        dbg_cnt <= 0;
        ring_loop_cnt <= ring_loop_cnt +1;
        byte_stream[ring_loop_cnt+1] <= 0;
      end


      /*
      if(!data_input)begin
        flag_data_timeout_cnt <= flag_data_timeout_cnt + 1;
        if(flag_data_timeout_cnt >= TIMEOUT_MAX)begin //1us / (1/50 MHz) = 50 ... TIMEOUT_MAX
          byte_stream[ring_loop_cnt] <= 0;
        end
      end else begin
        flag_data_timeout <= 0;
        flag_data_timeout_cnt <= 0;
      end*/


    //DEBUG uncoment=normal

    //=== Starts and validates Datastream==
    /*
    if(data_input)begin
      flag_DATA_present <= 1;
      if(!flag_DATA_present)
        byte_stream[ring_loop_cnt] <= 0;
    end

    if(!envelope_input)begin
      capture_done <= 0;
      if(!flag_stream_valid)
        flag_stream_valid <= 1;
    end*/

    //=== finishes data capture ==
    /*
    if(flag_stream_valid)begin
      if(envelope_input)begin
        capture_done <= 1;
        ring_loop_cnt <= ring_loop_cnt + 8'd1;
        byte_stream[ring_loop_cnt+1] <= 0;
        flag_stream_valid <= 0;
        flag_DATA_present <= 0;
      end
    end*/

    /*
    if(envelope_input)begin
    end

    if(!allow_capture)begin
      flag_DATA_present <= 0;
      ring_loop_cnt <= 0;
      flag_stream_valid <= 0;
      dbg_cnt <= 0;
      for (i=0; i<=BUFFER_ARRAY_SIZE_MAX; i=i+1)
            byte_stream[i] <= 0;
    end*/

    if(envelope_input == 1'bz)begin
        flag_DATA_present <= 0;
        ring_loop_cnt <= 0;
        flag_stream_valid <= 0;
        dbg_cnt <= 0;
        for (i=0; i<=BUFFER_ARRAY_SIZE_MAX; i=i+1)
              byte_stream[i] <= 0;
    end

    //=== Overflow prevention ==
    if(ring_loop_cnt == BUFFER_ARRAY_SIZE_MAX)begin
      ring_loop_cnt <= 0;
      byte_stream[0] <= 0;
    end

  end
 end
endmodule

module clock_divider2 (
      input clock_in,
      input reset,
      output clock_out
      //input [27:0] divider
    );
    reg[31:0] counter=32'd0;
	 localparam DIVISOR = 32'd4;


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
