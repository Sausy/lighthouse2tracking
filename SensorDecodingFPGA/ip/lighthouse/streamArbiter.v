module StreamFifo_8_ (
      input   io_push_valid,
      output  io_push_ready,
      input  [4:0] io_push_payload_id,
      input  [15:0] io_push_payload_pulse_width,
      input  [23:0] io_push_payload_pulse_timestamp,
      input  [16:0] io_push_payload_beamWord,
      output  io_pop_valid,
      input   io_pop_ready,
      output [4:0] io_pop_payload_id,
      output [15:0] io_pop_payload_pulse_width,
      output [23:0] io_pop_payload_pulse_timestamp,
      output [16:0] io_pop_payload_beamWord,
      input   io_flush,
      output [7:0] io_occupancy,
      output [7:0] io_availability,
      input   Slow_clk);
  reg [61:0] _zz_5_;
  wire [0:0] _zz_6_;
  wire [6:0] _zz_7_;
  wire [0:0] _zz_8_;
  wire [6:0] _zz_9_;
  wire [6:0] _zz_10_;
  wire  _zz_11_;
  wire [61:0] _zz_12_;
  reg  _zz_1_;
  reg  logic_pushPtr_willIncrement;
  reg  logic_pushPtr_willClear;
  reg [6:0] logic_pushPtr_valueNext;
  reg [6:0] logic_pushPtr_value = (7'b0000000);
  wire  logic_pushPtr_willOverflowIfInc;
  wire  logic_pushPtr_willOverflow;
  reg  logic_popPtr_willIncrement;
  reg  logic_popPtr_willClear;
  reg [6:0] logic_popPtr_valueNext;
  reg [6:0] logic_popPtr_value = (7'b0000000);
  wire  logic_popPtr_willOverflowIfInc;
  wire  logic_popPtr_willOverflow;
  wire  logic_ptrMatch;
  reg  logic_risingOccupancy = 1'b0;
  wire  logic_pushing;
  wire  logic_popping;
  wire  logic_empty;
  wire  logic_full;
  reg  _zz_2_ = 1'b0;
  wire [61:0] _zz_3_;
  wire [39:0] _zz_4_;
  wire [6:0] logic_ptrDif;
  reg [61:0] logic_ram [0:127];
  assign _zz_6_ = logic_pushPtr_willIncrement;
  assign _zz_7_ = {6'd0, _zz_6_};
  assign _zz_8_ = logic_popPtr_willIncrement;
  assign _zz_9_ = {6'd0, _zz_8_};
  assign _zz_10_ = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_11_ = 1'b1;
  assign _zz_12_ = {io_push_payload_beamWord,{{io_push_payload_pulse_timestamp,io_push_payload_pulse_width},io_push_payload_id}};
  always @ (posedge Slow_clk) begin
    if(_zz_11_) begin
      _zz_5_ <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @ (posedge Slow_clk) begin
    if(_zz_1_) begin
      logic_ram[logic_pushPtr_value] <= _zz_12_;
    end
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    if(logic_pushing)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing)begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == (7'b1111111));
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @ (*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_7_);
    if(logic_pushPtr_willClear)begin
      logic_pushPtr_valueNext = (7'b0000000);
    end
  end

  always @ (*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping)begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == (7'b1111111));
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @ (*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_9_);
    if(logic_popPtr_willClear)begin
      logic_popPtr_valueNext = (7'b0000000);
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_2_ && (! logic_full))));
  assign _zz_3_ = _zz_5_;
  assign _zz_4_ = _zz_3_[44 : 5];
  assign io_pop_payload_id = _zz_3_[4 : 0];
  assign io_pop_payload_pulse_width = _zz_4_[15 : 0];
  assign io_pop_payload_pulse_timestamp = _zz_4_[39 : 16];
  assign io_pop_payload_beamWord = _zz_3_[61 : 45];
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_10_};
  always @ (posedge Slow_clk) begin
    logic_pushPtr_value <= logic_pushPtr_valueNext;
    logic_popPtr_value <= logic_popPtr_valueNext;
    _zz_2_ <= (logic_popPtr_valueNext == logic_pushPtr_value);
    if((logic_pushing != logic_popping))begin
      logic_risingOccupancy <= logic_pushing;
    end
    if(io_flush)begin
      logic_risingOccupancy <= 1'b0;
    end
  end

endmodule

module StreamArbiter (
      input   io_inputs_0_valid,
      output  io_inputs_0_ready,
      input  [4:0] io_inputs_0_payload_id,
      input  [15:0] io_inputs_0_payload_pulse_width,
      input  [23:0] io_inputs_0_payload_pulse_timestamp,
      input  [16:0] io_inputs_0_payload_beamWord,
      input   io_inputs_1_valid,
      output  io_inputs_1_ready,
      input  [4:0] io_inputs_1_payload_id,
      input  [15:0] io_inputs_1_payload_pulse_width,
      input  [23:0] io_inputs_1_payload_pulse_timestamp,
      input  [16:0] io_inputs_1_payload_beamWord,
      input   io_inputs_2_valid,
      output  io_inputs_2_ready,
      input  [4:0] io_inputs_2_payload_id,
      input  [15:0] io_inputs_2_payload_pulse_width,
      input  [23:0] io_inputs_2_payload_pulse_timestamp,
      input  [16:0] io_inputs_2_payload_beamWord,
      input   io_inputs_3_valid,
      output  io_inputs_3_ready,
      input  [4:0] io_inputs_3_payload_id,
      input  [15:0] io_inputs_3_payload_pulse_width,
      input  [23:0] io_inputs_3_payload_pulse_timestamp,
      input  [16:0] io_inputs_3_payload_beamWord,
      input   io_inputs_4_valid,
      output  io_inputs_4_ready,
      input  [4:0] io_inputs_4_payload_id,
      input  [15:0] io_inputs_4_payload_pulse_width,
      input  [23:0] io_inputs_4_payload_pulse_timestamp,
      input  [16:0] io_inputs_4_payload_beamWord,
      input   io_inputs_5_valid,
      output  io_inputs_5_ready,
      input  [4:0] io_inputs_5_payload_id,
      input  [15:0] io_inputs_5_payload_pulse_width,
      input  [23:0] io_inputs_5_payload_pulse_timestamp,
      input  [16:0] io_inputs_5_payload_beamWord,
      input   io_inputs_6_valid,
      output  io_inputs_6_ready,
      input  [4:0] io_inputs_6_payload_id,
      input  [15:0] io_inputs_6_payload_pulse_width,
      input  [23:0] io_inputs_6_payload_pulse_timestamp,
      input  [16:0] io_inputs_6_payload_beamWord,
      input   io_inputs_7_valid,
      output  io_inputs_7_ready,
      input  [4:0] io_inputs_7_payload_id,
      input  [15:0] io_inputs_7_payload_pulse_width,
      input  [23:0] io_inputs_7_payload_pulse_timestamp,
      input  [16:0] io_inputs_7_payload_beamWord,
      output  io_output_valid,
      input   io_output_ready,
      output [4:0] io_output_payload_id,
      output [15:0] io_output_payload_pulse_width,
      output [23:0] io_output_payload_pulse_timestamp,
      output [16:0] io_output_payload_beamWord,
      output [2:0] io_chosen,
      output [7:0] io_chosenOH,
      input   Slow_clk);
  reg [4:0] _zz_14_;
  reg [15:0] _zz_15_;
  reg [23:0] _zz_16_;
  reg [16:0] _zz_17_;
  wire [7:0] _zz_18_;
  reg  locked = 1'b0;
  wire  maskProposal_0;
  wire  maskProposal_1;
  wire  maskProposal_2;
  wire  maskProposal_3;
  wire  maskProposal_4;
  wire  maskProposal_5;
  wire  maskProposal_6;
  wire  maskProposal_7;
  reg  maskLocked_0;
  reg  maskLocked_1;
  reg  maskLocked_2;
  reg  maskLocked_3;
  reg  maskLocked_4;
  reg  maskLocked_5;
  reg  maskLocked_6;
  reg  maskLocked_7;
  wire  maskRouted_0;
  wire  maskRouted_1;
  wire  maskRouted_2;
  wire  maskRouted_3;
  wire  maskRouted_4;
  wire  maskRouted_5;
  wire  maskRouted_6;
  wire  maskRouted_7;
  wire [7:0] _zz_1_;
  wire [7:0] _zz_2_;
  wire  _zz_3_;
  wire  _zz_4_;
  wire  _zz_5_;
  wire [2:0] _zz_6_;
  wire  _zz_7_;
  wire  _zz_8_;
  wire  _zz_9_;
  wire  _zz_10_;
  wire  _zz_11_;
  wire  _zz_12_;
  wire  _zz_13_;
  assign _zz_18_ = (_zz_1_ - (8'b00000001));
  always @(*) begin
    case(_zz_6_)
      3'b000 : begin
        _zz_14_ = io_inputs_0_payload_id;
        _zz_15_ = io_inputs_0_payload_pulse_width;
        _zz_16_ = io_inputs_0_payload_pulse_timestamp;
        _zz_17_ = io_inputs_0_payload_beamWord;
      end
      3'b001 : begin
        _zz_14_ = io_inputs_1_payload_id;
        _zz_15_ = io_inputs_1_payload_pulse_width;
        _zz_16_ = io_inputs_1_payload_pulse_timestamp;
        _zz_17_ = io_inputs_1_payload_beamWord;
      end
      3'b010 : begin
        _zz_14_ = io_inputs_2_payload_id;
        _zz_15_ = io_inputs_2_payload_pulse_width;
        _zz_16_ = io_inputs_2_payload_pulse_timestamp;
        _zz_17_ = io_inputs_2_payload_beamWord;
      end
      3'b011 : begin
        _zz_14_ = io_inputs_3_payload_id;
        _zz_15_ = io_inputs_3_payload_pulse_width;
        _zz_16_ = io_inputs_3_payload_pulse_timestamp;
        _zz_17_ = io_inputs_3_payload_beamWord;
      end
      3'b100 : begin
        _zz_14_ = io_inputs_4_payload_id;
        _zz_15_ = io_inputs_4_payload_pulse_width;
        _zz_16_ = io_inputs_4_payload_pulse_timestamp;
        _zz_17_ = io_inputs_4_payload_beamWord;
      end
      3'b101 : begin
        _zz_14_ = io_inputs_5_payload_id;
        _zz_15_ = io_inputs_5_payload_pulse_width;
        _zz_16_ = io_inputs_5_payload_pulse_timestamp;
        _zz_17_ = io_inputs_5_payload_beamWord;
      end
      3'b110 : begin
        _zz_14_ = io_inputs_6_payload_id;
        _zz_15_ = io_inputs_6_payload_pulse_width;
        _zz_16_ = io_inputs_6_payload_pulse_timestamp;
        _zz_17_ = io_inputs_6_payload_beamWord;
      end
      default : begin
        _zz_14_ = io_inputs_7_payload_id;
        _zz_15_ = io_inputs_7_payload_pulse_width;
        _zz_16_ = io_inputs_7_payload_pulse_timestamp;
        _zz_17_ = io_inputs_7_payload_beamWord;
      end
    endcase
  end

  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
  assign maskRouted_2 = (locked ? maskLocked_2 : maskProposal_2);
  assign maskRouted_3 = (locked ? maskLocked_3 : maskProposal_3);
  assign maskRouted_4 = (locked ? maskLocked_4 : maskProposal_4);
  assign maskRouted_5 = (locked ? maskLocked_5 : maskProposal_5);
  assign maskRouted_6 = (locked ? maskLocked_6 : maskProposal_6);
  assign maskRouted_7 = (locked ? maskLocked_7 : maskProposal_7);
  assign _zz_1_ = {io_inputs_7_valid,{io_inputs_6_valid,{io_inputs_5_valid,{io_inputs_4_valid,{io_inputs_3_valid,{io_inputs_2_valid,{io_inputs_1_valid,io_inputs_0_valid}}}}}}};
  assign _zz_2_ = (_zz_1_ & (~ _zz_18_));
  assign maskProposal_0 = io_inputs_0_valid;
  assign maskProposal_1 = _zz_2_[1];
  assign maskProposal_2 = _zz_2_[2];
  assign maskProposal_3 = _zz_2_[3];
  assign maskProposal_4 = _zz_2_[4];
  assign maskProposal_5 = _zz_2_[5];
  assign maskProposal_6 = _zz_2_[6];
  assign maskProposal_7 = _zz_2_[7];
  assign io_output_valid = ((((((((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1)) || (io_inputs_2_valid && maskRouted_2)) || (io_inputs_3_valid && maskRouted_3)) || (io_inputs_4_valid && maskRouted_4)) || (io_inputs_5_valid && maskRouted_5)) || (io_inputs_6_valid && maskRouted_6)) || (io_inputs_7_valid && maskRouted_7));
  assign _zz_3_ = (((maskRouted_1 || maskRouted_3) || maskRouted_5) || maskRouted_7);
  assign _zz_4_ = (((maskRouted_2 || maskRouted_3) || maskRouted_6) || maskRouted_7);
  assign _zz_5_ = (((maskRouted_4 || maskRouted_5) || maskRouted_6) || maskRouted_7);
  assign _zz_6_ = {_zz_5_,{_zz_4_,_zz_3_}};
  assign io_output_payload_id = _zz_14_;
  assign io_output_payload_pulse_width = _zz_15_;
  assign io_output_payload_pulse_timestamp = _zz_16_;
  assign io_output_payload_beamWord = _zz_17_;
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready);
  assign io_inputs_2_ready = (maskRouted_2 && io_output_ready);
  assign io_inputs_3_ready = (maskRouted_3 && io_output_ready);
  assign io_inputs_4_ready = (maskRouted_4 && io_output_ready);
  assign io_inputs_5_ready = (maskRouted_5 && io_output_ready);
  assign io_inputs_6_ready = (maskRouted_6 && io_output_ready);
  assign io_inputs_7_ready = (maskRouted_7 && io_output_ready);
  assign io_chosenOH = {maskRouted_7,{maskRouted_6,{maskRouted_5,{maskRouted_4,{maskRouted_3,{maskRouted_2,{maskRouted_1,maskRouted_0}}}}}}};
  assign _zz_7_ = io_chosenOH[3];
  assign _zz_8_ = io_chosenOH[5];
  assign _zz_9_ = io_chosenOH[6];
  assign _zz_10_ = io_chosenOH[7];
  assign _zz_11_ = (((io_chosenOH[1] || _zz_7_) || _zz_8_) || _zz_10_);
  assign _zz_12_ = (((io_chosenOH[2] || _zz_7_) || _zz_9_) || _zz_10_);
  assign _zz_13_ = (((io_chosenOH[4] || _zz_8_) || _zz_9_) || _zz_10_);
  assign io_chosen = {_zz_13_,{_zz_12_,_zz_11_}};
  always @ (posedge Slow_clk) begin
    if(io_output_valid)begin
      locked <= 1'b1;
    end
    if((io_output_valid && io_output_ready))begin
      locked <= 1'b0;
    end
  end

  always @ (posedge Slow_clk) begin
    if(io_output_valid)begin
      maskLocked_0 <= maskRouted_0;
      maskLocked_1 <= maskRouted_1;
      maskLocked_2 <= maskRouted_2;
      maskLocked_3 <= maskRouted_3;
      maskLocked_4 <= maskRouted_4;
      maskLocked_5 <= maskRouted_5;
      maskLocked_6 <= maskRouted_6;
      maskLocked_7 <= maskRouted_7;
    end
  end

endmodule
