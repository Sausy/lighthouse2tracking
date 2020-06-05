module DdrBmcDecoder (
      input   io_signal_v_0,
      input   io_signal_v_1,
      input   io_enable,
      output  io_output_valid,
      output  io_output_payload,
      output  io_synchronized,
      input   Core_clk);
  wire  _zz_1_;
  wire  _zz_2_;
  wire  _zz_3_;
  wire  _zz_4_;
  wire  _zz_5_;
  wire  _zz_6_;
  wire  _zz_7_;
  wire  _zz_8_;
  wire  _zz_9_;
  wire  _zz_10_;
  reg  data_valid;
  reg  data_payload;
  reg [21:0] counter_sr = (22'b0000000000000000000001);
  reg  synchronized = 1'b0;
  reg  decodingOne = 1'b0;
  reg [21:0] sample = (22'b0000000000000000000000);
  reg  io_signal_v_1_regNext;
  reg  io_signal_v_1_regNext_1_;
  reg  io_signal_v_1_regNext_2_;
  assign _zz_1_ = (! io_enable);
  assign _zz_2_ = (! synchronized);
  assign _zz_3_ = (counter_sr[21 : 21] != (1'b0));
  assign _zz_4_ = (io_signal_v_1_regNext_2_ ^ io_signal_v_0);
  assign _zz_5_ = (counter_sr[10 : 0] != (11'b00000000000));
  assign _zz_6_ = (! io_enable);
  assign _zz_7_ = (! synchronized);
  assign _zz_8_ = (counter_sr[21 : 21] != (1'b0));
  assign _zz_9_ = (io_signal_v_0 ^ io_signal_v_1);
  assign _zz_10_ = (counter_sr[9 : 0] != (10'b0000000000));
  assign io_output_valid = data_valid;
  assign io_output_payload = data_payload;
  assign io_synchronized = synchronized;
  always @ (*) begin
    data_valid = 1'b0;
    if(! _zz_1_) begin
      if(! _zz_2_) begin
        if(! _zz_3_) begin
          if(_zz_4_)begin
            if(_zz_5_)begin
              if(decodingOne)begin
                data_valid = 1'b1;
              end
            end else begin
              data_valid = 1'b1;
            end
          end
        end
      end
    end
    if(! _zz_6_) begin
      if(! _zz_7_) begin
        if(! _zz_8_) begin
          if(_zz_9_)begin
            if(_zz_10_)begin
              if(decodingOne)begin
                data_valid = 1'b1;
              end
            end else begin
              data_valid = 1'b1;
            end
          end
        end
      end
    end
  end

  always @ (*) begin
    data_payload = 1'b0;
    if(! _zz_1_) begin
      if(! _zz_2_) begin
        if(! _zz_3_) begin
          if(_zz_4_)begin
            if(_zz_5_)begin
              if(decodingOne)begin
                data_payload = 1'b1;
              end
            end else begin
              data_payload = 1'b0;
            end
          end
        end
      end
    end
    if(! _zz_6_) begin
      if(! _zz_7_) begin
        if(! _zz_8_) begin
          if(_zz_9_)begin
            if(_zz_10_)begin
              if(decodingOne)begin
                data_payload = 1'b1;
              end
            end else begin
              data_payload = 1'b0;
            end
          end
        end
      end
    end
  end

  always @ (posedge Core_clk) begin
    if((io_signal_v_1_regNext ^ io_signal_v_0))begin
      counter_sr <= (22'b0000000000000000000010);
      sample <= counter_sr;
    end else begin
      if((io_signal_v_0 ^ io_signal_v_1))begin
        counter_sr <= (22'b0000000000000000000001);
        sample <= {counter_sr[20 : 0],counter_sr[21 : 21]};
      end else begin
        counter_sr <= {counter_sr[19 : 0],counter_sr[21 : 20]};
      end
    end
    if(_zz_1_)begin
      synchronized <= 1'b0;
    end else begin
      if(_zz_2_)begin
        decodingOne <= 1'b0;
        if((io_signal_v_1_regNext_1_ ^ io_signal_v_0))begin
          synchronized <= 1'b1;
        end
      end else begin
        if(_zz_3_)begin
          synchronized <= 1'b0;
          decodingOne <= 1'b0;
        end else begin
          if(_zz_4_)begin
            if(_zz_5_)begin
              if(decodingOne)begin
                decodingOne <= 1'b0;
              end else begin
                decodingOne <= 1'b1;
              end
            end else begin
              decodingOne <= 1'b0;
            end
          end
        end
      end
    end
    if(_zz_6_)begin
      synchronized <= 1'b0;
    end else begin
      if(_zz_7_)begin
        decodingOne <= 1'b0;
        if((io_signal_v_0 ^ io_signal_v_1))begin
          synchronized <= 1'b1;
        end
      end else begin
        if(_zz_8_)begin
          synchronized <= 1'b0;
          decodingOne <= 1'b0;
        end else begin
          if(_zz_9_)begin
            if(_zz_10_)begin
              if(decodingOne)begin
                decodingOne <= 1'b0;
              end else begin
                decodingOne <= 1'b1;
              end
            end else begin
              decodingOne <= 1'b0;
            end
          end
        end
      end
    end
  end

  always @ (posedge Core_clk) begin
    io_signal_v_1_regNext <= io_signal_v_1;
  end

  always @ (posedge Core_clk) begin
    io_signal_v_1_regNext_1_ <= io_signal_v_1;
  end

  always @ (posedge Core_clk) begin
    io_signal_v_1_regNext_2_ <= io_signal_v_1;
  end

endmodule
