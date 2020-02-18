module ts4231_datastream #(parameter CLK_FREQ_HZ = 50_000_000)
  (
    input clock,  // clock
    input reset,  // reset

    input bit_datstream,
    input N_is_valid, //this flag is delayed

    output debug_cstatus
  );

  //AFTER a time of 600-900ns (just say 1us) where Data is low
  //
  //

  reg [0:500] byte_stream[0:10];
  reg flag_DATA_present;
  reg [7:0] ring_loop_cnt;
  reg [7:0] bit_cnt;

  //reg rec_data;
  reg flag_stream_valid;

  always @(posedge clock, posedge reset) begin: BIT2BYTE
    if(reset)begin
      flag_DATA_present <= 0;
      ring_loop_cnt <= 0;
      bit_cnt <= 0;
      flag_stream_valid <= 0;

    end else begin
      if(N_is_valid == 0)begin
        flag_stream_valid <= 1;
      end
      if(flag_stream_valid)begin
        if(N_is_valid)begin
          ring_loop_cnt <= ring_loop_cnt + 8'd1;
          flag_stream_valid <= 0;
          bit_cnt <= 0;
          flag_DATA_present <= 0;
        end
      end


      if(bit_datstream)begin
        if(flag_DATA_present == 0)begin
          flag_DATA_present <= 1;
          byte_stream[ring_loop_cnt][0] <= bit_datstream;
          bit_cnt <= 8'd1;
        end
      end
      if(flag_DATA_present)begin
          byte_stream[ring_loop_cnt][0] <= bit_datstream;
          bit_cnt <= 8'd1;
      end

      if(bit_cnt == 499)begin
        bit_cnt <= 0;
        bit_datstream <= 0;
        flag_DATA_present <= 0;
      end
      if(ring_loop_cnt == 9)begin
        ring_loop_cnt <= 0;
      end

    end

  end

  endmodule
