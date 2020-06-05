`define fsm_enumDefinition_defaultEncoding_type [2:0]
`define fsm_enumDefinition_defaultEncoding_boot 3'b000
`define fsm_enumDefinition_defaultEncoding_fsm_idle 3'b001
`define fsm_enumDefinition_defaultEncoding_fsm_testDelta 3'b010
`define fsm_enumDefinition_defaultEncoding_fsm_waitFinder 3'b011
`define fsm_enumDefinition_defaultEncoding_fsm_sendResult 3'b100

`define fsm_enumDefinition_1_defaultEncoding_type [2:0]
`define fsm_enumDefinition_1_defaultEncoding_boot 3'b000
`define fsm_enumDefinition_1_defaultEncoding_fsm_idle 3'b001
`define fsm_enumDefinition_1_defaultEncoding_fsm_testDelta 3'b010
`define fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder 3'b011
`define fsm_enumDefinition_1_defaultEncoding_fsm_sendResult 3'b100

module PulseTimer (
      input  [23:0] io_time,
      input   io_e,
      output  io_pulse_valid,
      output [15:0] io_pulse_payload_width,
      output [23:0] io_pulse_payload_timestamp,
      input   Slow_clk);
  wire  _zz_1_;
  wire [23:0] _zz_2_;
  reg [23:0] timestamp;
  reg [15:0] width;
  reg  valid;
  reg  valid_regNext;
  reg  io_e_regNext;
  reg  io_e_regNext_1_;
  assign _zz_1_ = (io_e && (! io_e_regNext_1_));
  assign _zz_2_ = (io_time - timestamp);
  assign io_pulse_payload_timestamp = timestamp;
  assign io_pulse_payload_width = width;
  always @ (*) begin
    valid = 1'b0;
    if(_zz_1_)begin
      valid = 1'b1;
    end
  end

  assign io_pulse_valid = valid_regNext;
  always @ (posedge Slow_clk) begin
    valid_regNext <= valid;
    io_e_regNext <= io_e;
    if(((! io_e) && io_e_regNext))begin
      timestamp <= io_time;
    end
    io_e_regNext_1_ <= io_e;
    if(_zz_1_)begin
      width <= _zz_2_[15:0];
    end
  end

endmodule

module PulseIdentifier (
      input   io_pulseIn_valid,
      output reg  io_pulseIn_ready,
      input  [1:0] io_pulseIn_payload_id,
      input  [15:0] io_pulseIn_payload_pulse_width,
      input  [23:0] io_pulseIn_payload_pulse_timestamp,
      input  [16:0] io_pulseIn_payload_beamWord,
      output reg  io_pulseOut_valid,
      input   io_pulseOut_ready,
      output [5:0] io_pulseOut_payload_npoly,
      output [15:0] io_pulseOut_payload_pulse_width,
      output [23:0] io_pulseOut_payload_pulse_timestamp,
      output [16:0] io_pulseOut_payload_beamWord,
      output [1:0] io_pulseOut_payload_id,
      input   Slow_clk);
  wire [9:0] _zz_1_;
  reg  _zz_2_;
  //wire  _zz_3_;
  wire  polyFinder_1__io_start_ready;
  wire  polyFinder_1__io_found;
  wire [4:0] polyFinder_1__io_polyFound;
  wire  polyFinder_1__io_done_valid;
  wire  _zz_4_;
  wire  _zz_5_;
  wire  _zz_6_;
  wire [21:0] _zz_7_;
  wire [21:0] _zz_8_;
  wire [21:0] _zz_9_;
  reg [16:0] lastState;
  reg [23:0] lastTimestamp;
  wire [23:0] pulseDelta;
  reg [5:0] nPoly;
  wire  fsm_wantExit;
  reg `fsm_enumDefinition_defaultEncoding_type fsm_stateReg = `fsm_enumDefinition_defaultEncoding_boot;
  reg `fsm_enumDefinition_defaultEncoding_type fsm_stateNext;

  assign _zz_4_ = (io_pulseOut_valid && io_pulseOut_ready);
  assign _zz_5_ = (_zz_9_ < (22'b0000000000010000000000));
  assign _zz_6_ = (polyFinder_1__io_done_valid && 1'b1);
  assign _zz_7_ = (_zz_8_ + (22'b0000000000000000000010));
  assign _zz_8_ = (pulseDelta >>> 2);
  assign _zz_9_ = (pulseDelta >>> 2);
  PolyFinder polyFinder_1_ (
    .io_startState(lastState),
    .io_targetState(io_pulseIn_payload_beamWord),
    .io_maxTick(_zz_1_),
    .io_start_valid(_zz_2_),
    .io_start_ready(polyFinder_1__io_start_ready),
    .io_found(polyFinder_1__io_found),
    .io_polyFound(polyFinder_1__io_polyFound),
    .io_done_valid(polyFinder_1__io_done_valid),
    .io_done_ready(1'b1),
    .Slow_clk(Slow_clk)
  );


  assign pulseDelta = (io_pulseIn_payload_pulse_timestamp - lastTimestamp);
  assign _zz_1_ = _zz_7_[9:0];
  assign io_pulseOut_payload_npoly = nPoly;
  assign io_pulseOut_payload_pulse_width = io_pulseIn_payload_pulse_width;
  assign io_pulseOut_payload_pulse_timestamp = io_pulseIn_payload_pulse_timestamp;
  assign io_pulseOut_payload_beamWord = io_pulseIn_payload_beamWord;
  assign io_pulseOut_payload_id = io_pulseIn_payload_id;
  assign fsm_wantExit = 1'b0;
  always @ (*) begin
    io_pulseOut_valid = 1'b0;
    case(fsm_stateReg)
      `fsm_enumDefinition_defaultEncoding_fsm_idle : begin
      end
      `fsm_enumDefinition_defaultEncoding_fsm_testDelta : begin
      end
      `fsm_enumDefinition_defaultEncoding_fsm_waitFinder : begin
      end
      `fsm_enumDefinition_defaultEncoding_fsm_sendResult : begin
        io_pulseOut_valid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_pulseIn_ready = 1'b0;
    case(fsm_stateReg)
      `fsm_enumDefinition_defaultEncoding_fsm_idle : begin
      end
      `fsm_enumDefinition_defaultEncoding_fsm_testDelta : begin
      end
      `fsm_enumDefinition_defaultEncoding_fsm_waitFinder : begin
      end
      `fsm_enumDefinition_defaultEncoding_fsm_sendResult : begin
        if(_zz_4_)begin
          io_pulseIn_ready = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_2_ = 1'b0;
    case(fsm_stateReg)
      `fsm_enumDefinition_defaultEncoding_fsm_idle : begin
      end
      `fsm_enumDefinition_defaultEncoding_fsm_testDelta : begin
        if(_zz_5_)begin
          _zz_2_ = 1'b1;
        end
      end
      `fsm_enumDefinition_defaultEncoding_fsm_waitFinder : begin
      end
      `fsm_enumDefinition_defaultEncoding_fsm_sendResult : begin
      end
      default : begin
      end
    endcase
    if(((! (fsm_stateReg == `fsm_enumDefinition_defaultEncoding_fsm_waitFinder)) && (fsm_stateNext == `fsm_enumDefinition_defaultEncoding_fsm_waitFinder)))begin
      _zz_2_ = 1'b1;
    end
  end

  always @ (*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      `fsm_enumDefinition_defaultEncoding_fsm_idle : begin
        if(io_pulseIn_valid)begin
          fsm_stateNext = `fsm_enumDefinition_defaultEncoding_fsm_testDelta;
        end
      end
      `fsm_enumDefinition_defaultEncoding_fsm_testDelta : begin
        if(_zz_5_)begin
          fsm_stateNext = `fsm_enumDefinition_defaultEncoding_fsm_waitFinder;
        end else begin
          fsm_stateNext = `fsm_enumDefinition_defaultEncoding_fsm_sendResult;
        end
      end
      `fsm_enumDefinition_defaultEncoding_fsm_waitFinder : begin
        if(_zz_6_)begin
          fsm_stateNext = `fsm_enumDefinition_defaultEncoding_fsm_sendResult;
        end
      end
      `fsm_enumDefinition_defaultEncoding_fsm_sendResult : begin
        if(_zz_4_)begin
          fsm_stateNext = `fsm_enumDefinition_defaultEncoding_fsm_idle;
        end
      end
      default : begin
        fsm_stateNext = `fsm_enumDefinition_defaultEncoding_fsm_idle;
      end
    endcase
  end

  always @ (posedge Slow_clk) begin
    fsm_stateReg <= fsm_stateNext;
  end

  always @ (posedge Slow_clk) begin
    case(fsm_stateReg)
      `fsm_enumDefinition_defaultEncoding_fsm_idle : begin
      end
      `fsm_enumDefinition_defaultEncoding_fsm_testDelta : begin
        if(! _zz_5_) begin
          nPoly <= (6'b111111);
        end
      end
      `fsm_enumDefinition_defaultEncoding_fsm_waitFinder : begin
        if(_zz_6_)begin
          if(polyFinder_1__io_found)begin
            nPoly <= {1'd0, polyFinder_1__io_polyFound};
          end else begin
            nPoly <= (6'b111111);
          end
        end
      end
      `fsm_enumDefinition_defaultEncoding_fsm_sendResult : begin
        lastTimestamp <= io_pulseIn_payload_pulse_timestamp;
        lastState <= io_pulseIn_payload_beamWord;
      end
      default : begin
      end
    endcase
  end

endmodule

module PulseOffsetFinder (
      input   io_pulseIn_valid,
      output reg  io_pulseIn_ready,
      input  [5:0] io_pulseIn_payload_npoly,
      input  [15:0] io_pulseIn_payload_pulse_width,
      input  [23:0] io_pulseIn_payload_pulse_timestamp,
      input  [16:0] io_pulseIn_payload_beamWord,
      input  [1:0] io_pulseIn_payload_id,
      output reg  io_pulseOut_valid,
      input   io_pulseOut_ready,
      output reg [16:0] io_pulseOut_payload_offset,
      output [5:0] io_pulseOut_payload_npoly,
      output [15:0] io_pulseOut_payload_pulse_width,
      output [23:0] io_pulseOut_payload_pulse_timestamp,
      output [16:0] io_pulseOut_payload_beamWord,
      output [1:0] io_pulseOut_payload_id,
      input   Slow_clk);
  reg  _zz_1_;
  reg  _zz_2_;
  wire [4:0] _zz_3_;
  wire  offsetFinder_1__io_done;
  wire  offsetFinder_1__io_found;
  wire [16:0] offsetFinder_1__io_offset;
  wire  _zz_4_;
  wire  _zz_5_;
  wire [21:0] _zz_6_;
  reg [23:0] lastTimestamp;
  wire [23:0] pulseDelta;
  reg [5:0] lastNPoly;
  wire  fsm_wantExit;
  reg `fsm_enumDefinition_1_defaultEncoding_type fsm_stateReg = `fsm_enumDefinition_1_defaultEncoding_boot;
  reg `fsm_enumDefinition_1_defaultEncoding_type fsm_stateNext;


  assign _zz_4_ = (io_pulseOut_valid && io_pulseOut_ready);
  assign _zz_5_ = ((io_pulseIn_payload_npoly != (6'b111111)) && (((22'b0000000000100000000000) < _zz_6_) || (io_pulseIn_payload_npoly != lastNPoly)));
  assign _zz_6_ = (pulseDelta >>> 2);
  OffsetFinder offsetFinder_1_ (
    .io_start(_zz_1_),
    .io_done(offsetFinder_1__io_done),
    .io_reset(_zz_2_),
    .io_nPoly(_zz_3_),
    .io_targetState(io_pulseIn_payload_beamWord),
    .io_found(offsetFinder_1__io_found),
    .io_offset(offsetFinder_1__io_offset),
    .Slow_clk(Slow_clk)
  );


  assign _zz_3_ = io_pulseIn_payload_npoly[4:0];
  assign pulseDelta = (io_pulseIn_payload_pulse_timestamp - lastTimestamp);
  assign io_pulseOut_payload_pulse_width = io_pulseIn_payload_pulse_width;
  assign io_pulseOut_payload_pulse_timestamp = io_pulseIn_payload_pulse_timestamp;
  assign io_pulseOut_payload_beamWord = io_pulseIn_payload_beamWord;
  assign io_pulseOut_payload_id = io_pulseIn_payload_id;
  assign io_pulseOut_payload_npoly = io_pulseIn_payload_npoly;
  always @ (*) begin
    io_pulseOut_payload_offset = (17'b00000000000000000);
    if(offsetFinder_1__io_found)begin
      io_pulseOut_payload_offset = offsetFinder_1__io_offset;
    end
  end

  always @ (*) begin
    io_pulseOut_valid = 1'b0;
    case(fsm_stateReg)
      `fsm_enumDefinition_1_defaultEncoding_fsm_idle : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_testDelta : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_sendResult : begin
        io_pulseOut_valid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_pulseIn_ready = 1'b0;
    case(fsm_stateReg)
      `fsm_enumDefinition_1_defaultEncoding_fsm_idle : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_testDelta : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_sendResult : begin
        if(_zz_4_)begin
          io_pulseIn_ready = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    case(fsm_stateReg)
      `fsm_enumDefinition_1_defaultEncoding_fsm_idle : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_testDelta : begin
        if(_zz_5_)begin
          _zz_1_ = 1'b1;
        end
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_sendResult : begin
      end
      default : begin
      end
    endcase
    if(((! (fsm_stateReg == `fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder)) && (fsm_stateNext == `fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder)))begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    _zz_2_ = 1'b0;
    case(fsm_stateReg)
      `fsm_enumDefinition_1_defaultEncoding_fsm_idle : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_testDelta : begin
        if(! _zz_5_) begin
          _zz_2_ = 1'b1;
        end
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_sendResult : begin
        if(_zz_4_)begin
          _zz_2_ = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign fsm_wantExit = 1'b0;
  always @ (*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      `fsm_enumDefinition_1_defaultEncoding_fsm_idle : begin
        if(io_pulseIn_valid)begin
          fsm_stateNext = `fsm_enumDefinition_1_defaultEncoding_fsm_testDelta;
        end
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_testDelta : begin
        if(_zz_5_)begin
          fsm_stateNext = `fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder;
        end else begin
          fsm_stateNext = `fsm_enumDefinition_1_defaultEncoding_fsm_sendResult;
        end
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder : begin
        if(offsetFinder_1__io_done)begin
          fsm_stateNext = `fsm_enumDefinition_1_defaultEncoding_fsm_sendResult;
        end
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_sendResult : begin
        if(_zz_4_)begin
          fsm_stateNext = `fsm_enumDefinition_1_defaultEncoding_fsm_idle;
        end
      end
      default : begin
        fsm_stateNext = `fsm_enumDefinition_1_defaultEncoding_fsm_idle;
      end
    endcase
  end

  always @ (posedge Slow_clk) begin
    fsm_stateReg <= fsm_stateNext;
  end

  always @ (posedge Slow_clk) begin
    case(fsm_stateReg)
      `fsm_enumDefinition_1_defaultEncoding_fsm_idle : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_testDelta : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_sendResult : begin
        if(offsetFinder_1__io_found)begin
          lastTimestamp <= io_pulseIn_payload_pulse_timestamp;
        end
        lastNPoly <= io_pulseIn_payload_npoly;
      end
      default : begin
      end
    endcase
  end

endmodule
