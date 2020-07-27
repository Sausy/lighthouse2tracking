`define UartParityType_defaultEncoding_type [1:0]
`define UartParityType_defaultEncoding_NONE 2'b00
`define UartParityType_defaultEncoding_EVEN 2'b01
`define UartParityType_defaultEncoding_ODD 2'b10

`define UartStopType_defaultEncoding_type [0:0]
`define UartStopType_defaultEncoding_ONE 1'b0
`define UartStopType_defaultEncoding_TWO 1'b1

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

`define StateMachineEnum_defaultEncoding_type [2:0]
`define StateMachineEnum_defaultEncoding_boot 3'b000
`define StateMachineEnum_defaultEncoding_e1 3'b001
`define StateMachineEnum_defaultEncoding_e2 3'b010
`define StateMachineEnum_defaultEncoding_e3 3'b011
`define StateMachineEnum_defaultEncoding_e4 3'b100
`define StateMachineEnum_defaultEncoding_e5 3'b101

`define StateMachineEnum_1_defaultEncoding_type [2:0]
`define StateMachineEnum_1_defaultEncoding_boot 3'b000
`define StateMachineEnum_1_defaultEncoding_e1 3'b001
`define StateMachineEnum_1_defaultEncoding_e2 3'b010
`define StateMachineEnum_1_defaultEncoding_e3 3'b011
`define StateMachineEnum_1_defaultEncoding_e4 3'b100
`define StateMachineEnum_1_defaultEncoding_e5 3'b101

`define StateMachineEnum_2_defaultEncoding_type [2:0]
`define StateMachineEnum_2_defaultEncoding_boot 3'b000
`define StateMachineEnum_2_defaultEncoding_e1 3'b001
`define StateMachineEnum_2_defaultEncoding_e2 3'b010
`define StateMachineEnum_2_defaultEncoding_e3 3'b011
`define StateMachineEnum_2_defaultEncoding_e4 3'b100
`define StateMachineEnum_2_defaultEncoding_e5 3'b101

`define StateMachineEnum_3_defaultEncoding_type [2:0]
`define StateMachineEnum_3_defaultEncoding_boot 3'b000
`define StateMachineEnum_3_defaultEncoding_e1 3'b001
`define StateMachineEnum_3_defaultEncoding_e2 3'b010
`define StateMachineEnum_3_defaultEncoding_e3 3'b011
`define StateMachineEnum_3_defaultEncoding_e4 3'b100
`define StateMachineEnum_3_defaultEncoding_e5 3'b101

`define UartCtrlTxState_defaultEncoding_type [2:0]
`define UartCtrlTxState_defaultEncoding_IDLE 3'b000
`define UartCtrlTxState_defaultEncoding_START 3'b001
`define UartCtrlTxState_defaultEncoding_DATA 3'b010
`define UartCtrlTxState_defaultEncoding_PARITY 3'b011
`define UartCtrlTxState_defaultEncoding_STOP 3'b100

`define UartCtrlRxState_defaultEncoding_type [2:0]
`define UartCtrlRxState_defaultEncoding_IDLE 3'b000
`define UartCtrlRxState_defaultEncoding_START 3'b001
`define UartCtrlRxState_defaultEncoding_DATA 3'b010
`define UartCtrlRxState_defaultEncoding_PARITY 3'b011
`define UartCtrlRxState_defaultEncoding_STOP 3'b100

`define fsm_enumDefinition_2_defaultEncoding_type [1:0]
`define fsm_enumDefinition_2_defaultEncoding_boot 2'b00
`define fsm_enumDefinition_2_defaultEncoding_fsm_idle 2'b01
`define fsm_enumDefinition_2_defaultEncoding_fsm_receiveArg 2'b10

module OffsetFinder (
      input   io_start,
      output  io_done,
      input   io_reset,
      input  [4:0] io_nPoly,
      input  [16:0] io_targetState,
      output  io_found,
      output [16:0] io_offset,
      input   Slow_clk);
  reg [16:0] _zz_37_;
  reg [16:0] _zz_38_;
  reg [16:0] _zz_39_;
  reg [16:0] _zz_40_;
  wire  _zz_41_;
  wire  _zz_42_;
  wire  _zz_43_;
  wire  _zz_44_;
  wire  _zz_45_;
  wire  _zz_46_;
  wire  _zz_47_;
  wire  _zz_48_;
  wire [6:0] _zz_49_;
  wire [6:0] _zz_50_;
  wire [6:0] _zz_51_;
  wire  _zz_52_;
  wire  _zz_53_;
  wire  _zz_54_;
  wire  _zz_55_;
  wire  _zz_56_;
  wire  _zz_57_;
  wire  _zz_58_;
  wire  _zz_59_;
  wire  _zz_60_;
  wire  _zz_61_;
  wire  _zz_62_;
  wire  _zz_63_;

  reg [3:0] done;
  reg  found = 1'b0;
  reg [16:0] offset = (17'b00000000000000000);
  reg [6:0] _zz_2_;
  wire [16:0] _zz_3_;
  reg [16:0] _zz_4_;
  reg [16:0] _zz_5_;
  reg [14:0] _zz_6_;
  reg [6:0] _zz_8_;
  wire [16:0] _zz_9_;
  reg [16:0] _zz_10_;
  reg [16:0] _zz_11_;
  reg [14:0] _zz_12_;
  reg [6:0] _zz_14_;
  wire [16:0] _zz_15_;
  reg [16:0] _zz_16_;
  reg [16:0] _zz_17_;
  reg [14:0] _zz_18_;
  reg [6:0] _zz_20_;
  wire [16:0] _zz_21_;
  reg [16:0] _zz_22_;
  reg [16:0] _zz_23_;
  reg [14:0] _zz_24_;
  reg `StateMachineEnum_defaultEncoding_type _zz_25_ = `StateMachineEnum_defaultEncoding_boot;
  reg `StateMachineEnum_defaultEncoding_type _zz_26_;
  wire [16:0] _zz_27_;
  reg `StateMachineEnum_1_defaultEncoding_type _zz_28_ = `StateMachineEnum_1_defaultEncoding_boot;
  reg `StateMachineEnum_1_defaultEncoding_type _zz_29_;
  wire [16:0] _zz_30_;
  reg `StateMachineEnum_2_defaultEncoding_type _zz_31_ = `StateMachineEnum_2_defaultEncoding_boot;
  reg `StateMachineEnum_2_defaultEncoding_type _zz_32_;
  wire [16:0] _zz_33_;
  reg `StateMachineEnum_3_defaultEncoding_type _zz_34_ = `StateMachineEnum_3_defaultEncoding_boot;
  reg `StateMachineEnum_3_defaultEncoding_type _zz_35_;
  wire [16:0] _zz_36_;
  `ifndef SYNTHESIS
  reg [31:0] _zz_25__string;
  reg [31:0] _zz_26__string;
  reg [31:0] _zz_28__string;
  reg [31:0] _zz_29__string;
  reg [31:0] _zz_31__string;
  reg [31:0] _zz_32__string;
  reg [31:0] _zz_34__string;
  reg [31:0] _zz_35__string;
  `endif

  reg [16:0] _zz_1_ [0:127];
  reg [16:0] _zz_7_ [0:127];
  reg [16:0] _zz_13_ [0:127];
  reg [16:0] _zz_19_ [0:127];
  assign _zz_41_ = (_zz_5_ == io_targetState);
  assign _zz_42_ = ((_zz_6_ == (15'b111111111111111)) || found);
  assign _zz_43_ = (_zz_11_ == io_targetState);
  assign _zz_44_ = ((_zz_12_ == (15'b111111111111111)) || found);
  assign _zz_45_ = (_zz_17_ == io_targetState);
  assign _zz_46_ = ((_zz_18_ == (15'b111111111111111)) || found);
  assign _zz_47_ = (_zz_23_ == io_targetState);
  assign _zz_48_ = ((_zz_24_ == (15'b111111111111111)) || found);
  assign _zz_49_ = ({2'd0,io_nPoly} <<< 2);
  assign _zz_50_ = ({2'd0,io_nPoly} <<< 2);
  assign _zz_51_ = ({2'd0,io_nPoly} <<< 2);
  assign _zz_52_ = 1'b1;
  assign _zz_53_ = 1'b1;
  assign _zz_54_ = 1'b1;
  assign _zz_55_ = 1'b1;
  assign _zz_56_ = ((_zz_27_[0] ^ _zz_27_[1]) ^ _zz_27_[2]);
  assign _zz_57_ = _zz_27_[3];
  assign _zz_58_ = ((_zz_30_[0] ^ _zz_30_[1]) ^ _zz_30_[2]);
  assign _zz_59_ = _zz_30_[3];
  assign _zz_60_ = ((_zz_33_[0] ^ _zz_33_[1]) ^ _zz_33_[2]);
  assign _zz_61_ = _zz_33_[3];
  assign _zz_62_ = ((_zz_36_[0] ^ _zz_36_[1]) ^ _zz_36_[2]);
  assign _zz_63_ = _zz_36_[3];
  initial begin
    $readmemb("LighthouseTopLevel.v_toplevel_slowArea_pulseOffsetFinder_offsetFinder_1___zz_1_.bin",_zz_1_);
  end
  always @ (posedge Slow_clk) begin
    if(_zz_52_) begin
      _zz_37_ <= _zz_1_[_zz_2_];
    end
  end

  initial begin
    $readmemb("LighthouseTopLevel.v_toplevel_slowArea_pulseOffsetFinder_offsetFinder_1___zz_7_.bin",_zz_7_);
  end
  always @ (posedge Slow_clk) begin
    if(_zz_53_) begin
      _zz_38_ <= _zz_7_[_zz_8_];
    end
  end

  initial begin
    $readmemb("LighthouseTopLevel.v_toplevel_slowArea_pulseOffsetFinder_offsetFinder_1___zz_13_.bin",_zz_13_);
  end
  always @ (posedge Slow_clk) begin
    if(_zz_54_) begin
      _zz_39_ <= _zz_13_[_zz_14_];
    end
  end

  initial begin
    $readmemb("LighthouseTopLevel.v_toplevel_slowArea_pulseOffsetFinder_offsetFinder_1___zz_19_.bin",_zz_19_);
  end
  always @ (posedge Slow_clk) begin
    if(_zz_55_) begin
      _zz_40_ <= _zz_19_[_zz_20_];
    end
  end

  always @ (*) begin
    done = (4'b0000);
    case(_zz_25_)
      `StateMachineEnum_defaultEncoding_e1 : begin
      end
      `StateMachineEnum_defaultEncoding_e2 : begin
      end
      `StateMachineEnum_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_defaultEncoding_e4 : begin
      end
      `StateMachineEnum_defaultEncoding_e5 : begin
        done[0] = 1'b1;
      end
      default : begin
      end
    endcase
    case(_zz_28_)
      `StateMachineEnum_1_defaultEncoding_e1 : begin
      end
      `StateMachineEnum_1_defaultEncoding_e2 : begin
      end
      `StateMachineEnum_1_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_1_defaultEncoding_e4 : begin
      end
      `StateMachineEnum_1_defaultEncoding_e5 : begin
        done[1] = 1'b1;
      end
      default : begin
      end
    endcase
    case(_zz_31_)
      `StateMachineEnum_2_defaultEncoding_e1 : begin
      end
      `StateMachineEnum_2_defaultEncoding_e2 : begin
      end
      `StateMachineEnum_2_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_2_defaultEncoding_e4 : begin
      end
      `StateMachineEnum_2_defaultEncoding_e5 : begin
        done[2] = 1'b1;
      end
      default : begin
      end
    endcase
    case(_zz_34_)
      `StateMachineEnum_3_defaultEncoding_e1 : begin
      end
      `StateMachineEnum_3_defaultEncoding_e2 : begin
      end
      `StateMachineEnum_3_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_3_defaultEncoding_e4 : begin
      end
      `StateMachineEnum_3_defaultEncoding_e5 : begin
        done[3] = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign io_done = (done != (4'b0000));
  assign io_found = found;
  assign io_offset = offset;
  assign _zz_3_ = _zz_37_;
  always @ (*) begin
    _zz_2_ = (7'b0000000);
    case(_zz_25_)
      `StateMachineEnum_defaultEncoding_e1 : begin
        _zz_2_ = ({2'd0,io_nPoly} <<< 2);
      end
      `StateMachineEnum_defaultEncoding_e2 : begin
      end
      `StateMachineEnum_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_defaultEncoding_e4 : begin
      end
      `StateMachineEnum_defaultEncoding_e5 : begin
        _zz_2_ = ({2'd0,io_nPoly} <<< 2);
      end
      default : begin
      end
    endcase
  end

  assign _zz_9_ = _zz_38_;
  always @ (*) begin
    _zz_8_ = (7'b0000000);
    case(_zz_28_)
      `StateMachineEnum_1_defaultEncoding_e1 : begin
        _zz_8_ = ({2'd0,io_nPoly} <<< 2);
      end
      `StateMachineEnum_1_defaultEncoding_e2 : begin
        _zz_8_ = (_zz_49_ | (7'b0000001));
      end
      `StateMachineEnum_1_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_1_defaultEncoding_e4 : begin
      end
      `StateMachineEnum_1_defaultEncoding_e5 : begin
        _zz_8_ = ({2'd0,io_nPoly} <<< 2);
      end
      default : begin
      end
    endcase
  end

  assign _zz_15_ = _zz_39_;
  always @ (*) begin
    _zz_14_ = (7'b0000000);
    case(_zz_31_)
      `StateMachineEnum_2_defaultEncoding_e1 : begin
        _zz_14_ = ({2'd0,io_nPoly} <<< 2);
      end
      `StateMachineEnum_2_defaultEncoding_e2 : begin
        _zz_14_ = (_zz_50_ | (7'b0000010));
      end
      `StateMachineEnum_2_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_2_defaultEncoding_e4 : begin
      end
      `StateMachineEnum_2_defaultEncoding_e5 : begin
        _zz_14_ = ({2'd0,io_nPoly} <<< 2);
      end
      default : begin
      end
    endcase
  end

  assign _zz_21_ = _zz_40_;
  always @ (*) begin
    _zz_20_ = (7'b0000000);
    case(_zz_34_)
      `StateMachineEnum_3_defaultEncoding_e1 : begin
        _zz_20_ = ({2'd0,io_nPoly} <<< 2);
      end
      `StateMachineEnum_3_defaultEncoding_e2 : begin
        _zz_20_ = (_zz_51_ | (7'b0000011));
      end
      `StateMachineEnum_3_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_3_defaultEncoding_e4 : begin
      end
      `StateMachineEnum_3_defaultEncoding_e5 : begin
        _zz_20_ = ({2'd0,io_nPoly} <<< 2);
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_26_ = _zz_25_;
    case(_zz_25_)
      `StateMachineEnum_defaultEncoding_e1 : begin
        if(io_start)begin
          _zz_26_ = `StateMachineEnum_defaultEncoding_e2;
        end
      end
      `StateMachineEnum_defaultEncoding_e2 : begin
        _zz_26_ = `StateMachineEnum_defaultEncoding_e4;
      end
      `StateMachineEnum_defaultEncoding_e3 : begin
        _zz_26_ = `StateMachineEnum_defaultEncoding_e4;
      end
      `StateMachineEnum_defaultEncoding_e4 : begin
        if(_zz_41_)begin
          _zz_26_ = `StateMachineEnum_defaultEncoding_e5;
        end else begin
          if(_zz_42_)begin
            _zz_26_ = `StateMachineEnum_defaultEncoding_e5;
          end
        end
      end
      `StateMachineEnum_defaultEncoding_e5 : begin
        if(io_start)begin
          _zz_26_ = `StateMachineEnum_defaultEncoding_e2;
        end
        if(io_reset)begin
          _zz_26_ = `StateMachineEnum_defaultEncoding_e1;
        end
      end
      default : begin
        _zz_26_ = `StateMachineEnum_defaultEncoding_e1;
      end
    endcase
  end

  assign _zz_27_ = (_zz_5_ & _zz_4_);
  always @ (*) begin
    _zz_29_ = _zz_28_;
    case(_zz_28_)
      `StateMachineEnum_1_defaultEncoding_e1 : begin
        if(io_start)begin
          _zz_29_ = `StateMachineEnum_1_defaultEncoding_e2;
        end
      end
      `StateMachineEnum_1_defaultEncoding_e2 : begin
        _zz_29_ = `StateMachineEnum_1_defaultEncoding_e3;
      end
      `StateMachineEnum_1_defaultEncoding_e3 : begin
        _zz_29_ = `StateMachineEnum_1_defaultEncoding_e4;
      end
      `StateMachineEnum_1_defaultEncoding_e4 : begin
        if(_zz_43_)begin
          _zz_29_ = `StateMachineEnum_1_defaultEncoding_e5;
        end else begin
          if(_zz_44_)begin
            _zz_29_ = `StateMachineEnum_1_defaultEncoding_e5;
          end
        end
      end
      `StateMachineEnum_1_defaultEncoding_e5 : begin
        if(io_start)begin
          _zz_29_ = `StateMachineEnum_1_defaultEncoding_e2;
        end
        if(io_reset)begin
          _zz_29_ = `StateMachineEnum_1_defaultEncoding_e1;
        end
      end
      default : begin
        _zz_29_ = `StateMachineEnum_1_defaultEncoding_e1;
      end
    endcase
  end

  assign _zz_30_ = (_zz_11_ & _zz_10_);
  always @ (*) begin
    _zz_32_ = _zz_31_;
    case(_zz_31_)
      `StateMachineEnum_2_defaultEncoding_e1 : begin
        if(io_start)begin
          _zz_32_ = `StateMachineEnum_2_defaultEncoding_e2;
        end
      end
      `StateMachineEnum_2_defaultEncoding_e2 : begin
        _zz_32_ = `StateMachineEnum_2_defaultEncoding_e3;
      end
      `StateMachineEnum_2_defaultEncoding_e3 : begin
        _zz_32_ = `StateMachineEnum_2_defaultEncoding_e4;
      end
      `StateMachineEnum_2_defaultEncoding_e4 : begin
        if(_zz_45_)begin
          _zz_32_ = `StateMachineEnum_2_defaultEncoding_e5;
        end else begin
          if(_zz_46_)begin
            _zz_32_ = `StateMachineEnum_2_defaultEncoding_e5;
          end
        end
      end
      `StateMachineEnum_2_defaultEncoding_e5 : begin
        if(io_start)begin
          _zz_32_ = `StateMachineEnum_2_defaultEncoding_e2;
        end
        if(io_reset)begin
          _zz_32_ = `StateMachineEnum_2_defaultEncoding_e1;
        end
      end
      default : begin
        _zz_32_ = `StateMachineEnum_2_defaultEncoding_e1;
      end
    endcase
  end

  assign _zz_33_ = (_zz_17_ & _zz_16_);
  always @ (*) begin
    _zz_35_ = _zz_34_;
    case(_zz_34_)
      `StateMachineEnum_3_defaultEncoding_e1 : begin
        if(io_start)begin
          _zz_35_ = `StateMachineEnum_3_defaultEncoding_e2;
        end
      end
      `StateMachineEnum_3_defaultEncoding_e2 : begin
        _zz_35_ = `StateMachineEnum_3_defaultEncoding_e3;
      end
      `StateMachineEnum_3_defaultEncoding_e3 : begin
        _zz_35_ = `StateMachineEnum_3_defaultEncoding_e4;
      end
      `StateMachineEnum_3_defaultEncoding_e4 : begin
        if(_zz_47_)begin
          _zz_35_ = `StateMachineEnum_3_defaultEncoding_e5;
        end else begin
          if(_zz_48_)begin
            _zz_35_ = `StateMachineEnum_3_defaultEncoding_e5;
          end
        end
      end
      `StateMachineEnum_3_defaultEncoding_e5 : begin
        if(io_start)begin
          _zz_35_ = `StateMachineEnum_3_defaultEncoding_e2;
        end
        if(io_reset)begin
          _zz_35_ = `StateMachineEnum_3_defaultEncoding_e1;
        end
      end
      default : begin
        _zz_35_ = `StateMachineEnum_3_defaultEncoding_e1;
      end
    endcase
  end

  assign _zz_36_ = (_zz_23_ & _zz_22_);
  always @ (posedge Slow_clk) begin
    _zz_25_ <= _zz_26_;
    case(_zz_25_)
      `StateMachineEnum_defaultEncoding_e1 : begin
        found <= 1'b0;
      end
      `StateMachineEnum_defaultEncoding_e2 : begin
      end
      `StateMachineEnum_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_defaultEncoding_e4 : begin
        if(_zz_41_)begin
          found <= 1'b1;
          offset <= {(2'b00),_zz_6_};
        end
      end
      `StateMachineEnum_defaultEncoding_e5 : begin
        if(io_start)begin
          found <= 1'b0;
        end
      end
      default : begin
      end
    endcase
    _zz_28_ <= _zz_29_;
    case(_zz_28_)
      `StateMachineEnum_1_defaultEncoding_e1 : begin
        found <= 1'b0;
      end
      `StateMachineEnum_1_defaultEncoding_e2 : begin
      end
      `StateMachineEnum_1_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_1_defaultEncoding_e4 : begin
        if(_zz_43_)begin
          found <= 1'b1;
          offset <= {(2'b01),_zz_12_};
        end
      end
      `StateMachineEnum_1_defaultEncoding_e5 : begin
        if(io_start)begin
          found <= 1'b0;
        end
      end
      default : begin
      end
    endcase
    _zz_31_ <= _zz_32_;
    case(_zz_31_)
      `StateMachineEnum_2_defaultEncoding_e1 : begin
        found <= 1'b0;
      end
      `StateMachineEnum_2_defaultEncoding_e2 : begin
      end
      `StateMachineEnum_2_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_2_defaultEncoding_e4 : begin
        if(_zz_45_)begin
          found <= 1'b1;
          offset <= {(2'b10),_zz_18_};
        end
      end
      `StateMachineEnum_2_defaultEncoding_e5 : begin
        if(io_start)begin
          found <= 1'b0;
        end
      end
      default : begin
      end
    endcase
    _zz_34_ <= _zz_35_;
    case(_zz_34_)
      `StateMachineEnum_3_defaultEncoding_e1 : begin
        found <= 1'b0;
      end
      `StateMachineEnum_3_defaultEncoding_e2 : begin
      end
      `StateMachineEnum_3_defaultEncoding_e3 : begin
      end
      `StateMachineEnum_3_defaultEncoding_e4 : begin
        if(_zz_47_)begin
          found <= 1'b1;
          offset <= {(2'b11),_zz_24_};
        end
      end
      `StateMachineEnum_3_defaultEncoding_e5 : begin
        if(io_start)begin
          found <= 1'b0;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (posedge Slow_clk) begin
    case(_zz_25_)
      `StateMachineEnum_defaultEncoding_e1 : begin
        _zz_6_ <= (15'b000000000000000);
      end
      `StateMachineEnum_defaultEncoding_e2 : begin
        _zz_4_ <= _zz_3_;
        _zz_5_ <= (17'b00000000000000001);
      end
      `StateMachineEnum_defaultEncoding_e3 : begin
        _zz_5_ <= _zz_3_;
      end
      `StateMachineEnum_defaultEncoding_e4 : begin
        if(! _zz_41_) begin
          if(! _zz_42_) begin
            _zz_6_ <= (_zz_6_ + (15'b000000000000001));
            _zz_5_ <= {_zz_5_[15 : 0],((((((((((((((_zz_56_ ^ _zz_57_) ^ _zz_27_[4]) ^ _zz_27_[5]) ^ _zz_27_[6]) ^ _zz_27_[7]) ^ _zz_27_[8]) ^ _zz_27_[9]) ^ _zz_27_[10]) ^ _zz_27_[11]) ^ _zz_27_[12]) ^ _zz_27_[13]) ^ _zz_27_[14]) ^ _zz_27_[15]) ^ _zz_27_[16])};
          end
        end
      end
      `StateMachineEnum_defaultEncoding_e5 : begin
      end
      default : begin
      end
    endcase
    case(_zz_28_)
      `StateMachineEnum_1_defaultEncoding_e1 : begin
        _zz_12_ <= (15'b000000000000000);
      end
      `StateMachineEnum_1_defaultEncoding_e2 : begin
        _zz_10_ <= _zz_9_;
      end
      `StateMachineEnum_1_defaultEncoding_e3 : begin
        _zz_11_ <= _zz_9_;
      end
      `StateMachineEnum_1_defaultEncoding_e4 : begin
        if(! _zz_43_) begin
          if(! _zz_44_) begin
            _zz_12_ <= (_zz_12_ + (15'b000000000000001));
            _zz_11_ <= {_zz_11_[15 : 0],((((((((((((((_zz_58_ ^ _zz_59_) ^ _zz_30_[4]) ^ _zz_30_[5]) ^ _zz_30_[6]) ^ _zz_30_[7]) ^ _zz_30_[8]) ^ _zz_30_[9]) ^ _zz_30_[10]) ^ _zz_30_[11]) ^ _zz_30_[12]) ^ _zz_30_[13]) ^ _zz_30_[14]) ^ _zz_30_[15]) ^ _zz_30_[16])};
          end
        end
      end
      `StateMachineEnum_1_defaultEncoding_e5 : begin
      end
      default : begin
      end
    endcase
    case(_zz_31_)
      `StateMachineEnum_2_defaultEncoding_e1 : begin
        _zz_18_ <= (15'b000000000000000);
      end
      `StateMachineEnum_2_defaultEncoding_e2 : begin
        _zz_16_ <= _zz_15_;
      end
      `StateMachineEnum_2_defaultEncoding_e3 : begin
        _zz_17_ <= _zz_15_;
      end
      `StateMachineEnum_2_defaultEncoding_e4 : begin
        if(! _zz_45_) begin
          if(! _zz_46_) begin
            _zz_18_ <= (_zz_18_ + (15'b000000000000001));
            _zz_17_ <= {_zz_17_[15 : 0],((((((((((((((_zz_60_ ^ _zz_61_) ^ _zz_33_[4]) ^ _zz_33_[5]) ^ _zz_33_[6]) ^ _zz_33_[7]) ^ _zz_33_[8]) ^ _zz_33_[9]) ^ _zz_33_[10]) ^ _zz_33_[11]) ^ _zz_33_[12]) ^ _zz_33_[13]) ^ _zz_33_[14]) ^ _zz_33_[15]) ^ _zz_33_[16])};
          end
        end
      end
      `StateMachineEnum_2_defaultEncoding_e5 : begin
      end
      default : begin
      end
    endcase
    case(_zz_34_)
      `StateMachineEnum_3_defaultEncoding_e1 : begin
        _zz_24_ <= (15'b000000000000000);
      end
      `StateMachineEnum_3_defaultEncoding_e2 : begin
        _zz_22_ <= _zz_21_;
      end
      `StateMachineEnum_3_defaultEncoding_e3 : begin
        _zz_23_ <= _zz_21_;
      end
      `StateMachineEnum_3_defaultEncoding_e4 : begin
        if(! _zz_47_) begin
          if(! _zz_48_) begin
            _zz_24_ <= (_zz_24_ + (15'b000000000000001));
            _zz_23_ <= {_zz_23_[15 : 0],((((((((((((((_zz_62_ ^ _zz_63_) ^ _zz_36_[4]) ^ _zz_36_[5]) ^ _zz_36_[6]) ^ _zz_36_[7]) ^ _zz_36_[8]) ^ _zz_36_[9]) ^ _zz_36_[10]) ^ _zz_36_[11]) ^ _zz_36_[12]) ^ _zz_36_[13]) ^ _zz_36_[14]) ^ _zz_36_[15]) ^ _zz_36_[16])};
          end
        end
      end
      `StateMachineEnum_3_defaultEncoding_e5 : begin
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
      input  [4:0] io_pulseIn_payload_id,
      output reg  io_pulseOut_valid,
      input   io_pulseOut_ready,
      output reg [16:0] io_pulseOut_payload_offset,
      output [5:0] io_pulseOut_payload_npoly,
      output [15:0] io_pulseOut_payload_pulse_width,
      output [23:0] io_pulseOut_payload_pulse_timestamp,
      output [16:0] io_pulseOut_payload_beamWord,
      output [4:0] io_pulseOut_payload_id,
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
  reg [4:0] lastID;
  wire [23:0] pulseDelta;
  reg [5:0] lastNPoly;
  wire  fsm_wantExit;
  reg `fsm_enumDefinition_1_defaultEncoding_type fsm_stateReg = `fsm_enumDefinition_1_defaultEncoding_boot;
  reg `fsm_enumDefinition_1_defaultEncoding_type fsm_stateNext;
  `ifndef SYNTHESIS
  reg [111:0] fsm_stateReg_string;
  reg [111:0] fsm_stateNext_string;
  `endif


  wire dump_data;
  //reg valid_found_flag = 1'b0;
  reg io_pulseOut_valid_dump = 0;
  /*
  always @ ( posedge Slow_clk ) begin
    if(offsetFinder_1__io_found)begin
      valid_found_flag <= 1'b1;
    end
    if(io_pulseOut_valid_dump)begin
      valid_found_flag <= 1'b0;
    end
  end
  */

  assign dump_data = ( io_pulseOut_valid | io_pulseOut_valid_dump );


  assign _zz_4_ = (dump_data && io_pulseOut_ready);
  //((22'b0000000000100000000000) < _zz_6_) ||
  //((22'b0000000000000000000001) < _zz_6_) || lastID != io_pulseIn_payload_pulse_timestamp;
  //wire timeMax;
  //assign timeMax = (((22'b0000000000100000000000) < _zz_6_) || (io_pulseIn_payload_id != lastID));
  //assign _zz_5_ = ((io_pulseIn_payload_npoly != (6'b111111)) && ((io_pulseIn_payload_npoly != lastNPoly)));
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
 )/* synthesis syn_noprune=1 */;


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
        if(io_pulseOut_payload_offset != 17'd0)begin
          io_pulseOut_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_pulseOut_valid_dump = 1'b0;
    case(fsm_stateReg)
      `fsm_enumDefinition_1_defaultEncoding_fsm_idle : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_testDelta : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_waitFinder : begin
      end
      `fsm_enumDefinition_1_defaultEncoding_fsm_sendResult : begin
          io_pulseOut_valid_dump = 1'b1;
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
        lastID <= io_pulseIn_payload_id;
      end
      default : begin
      end
    endcase
  end

endmodule
