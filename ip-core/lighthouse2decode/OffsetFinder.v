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
  wire [16:0] lfsrLut_0;
  wire [16:0] lfsrLut_1;
  wire [16:0] lfsrLut_2;
  wire [16:0] lfsrLut_3;
  wire [16:0] lfsrLut_4;
  wire [16:0] lfsrLut_5;
  wire [16:0] lfsrLut_6;
  wire [16:0] lfsrLut_7;
  wire [16:0] lfsrLut_8;
  wire [16:0] lfsrLut_9;
  wire [16:0] lfsrLut_10;
  wire [16:0] lfsrLut_11;
  wire [16:0] lfsrLut_12;
  wire [16:0] lfsrLut_13;
  wire [16:0] lfsrLut_14;
  wire [16:0] lfsrLut_15;
  wire [16:0] lfsrLut_16;
  wire [16:0] lfsrLut_17;
  wire [16:0] lfsrLut_18;
  wire [16:0] lfsrLut_19;
  wire [16:0] lfsrLut_20;
  wire [16:0] lfsrLut_21;
  wire [16:0] lfsrLut_22;
  wire [16:0] lfsrLut_23;
  wire [16:0] lfsrLut_24;
  wire [16:0] lfsrLut_25;
  wire [16:0] lfsrLut_26;
  wire [16:0] lfsrLut_27;
  wire [16:0] lfsrLut_28;
  wire [16:0] lfsrLut_29;
  wire [16:0] lfsrLut_30;
  wire [16:0] lfsrLut_31;
  wire [16:0] lfsrLut_32;
  wire [16:0] lfsrLut_33;
  wire [16:0] lfsrLut_34;
  wire [16:0] lfsrLut_35;
  wire [16:0] lfsrLut_36;
  wire [16:0] lfsrLut_37;
  wire [16:0] lfsrLut_38;
  wire [16:0] lfsrLut_39;
  wire [16:0] lfsrLut_40;
  wire [16:0] lfsrLut_41;
  wire [16:0] lfsrLut_42;
  wire [16:0] lfsrLut_43;
  wire [16:0] lfsrLut_44;
  wire [16:0] lfsrLut_45;
  wire [16:0] lfsrLut_46;
  wire [16:0] lfsrLut_47;
  wire [16:0] lfsrLut_48;
  wire [16:0] lfsrLut_49;
  wire [16:0] lfsrLut_50;
  wire [16:0] lfsrLut_51;
  wire [16:0] lfsrLut_52;
  wire [16:0] lfsrLut_53;
  wire [16:0] lfsrLut_54;
  wire [16:0] lfsrLut_55;
  wire [16:0] lfsrLut_56;
  wire [16:0] lfsrLut_57;
  wire [16:0] lfsrLut_58;
  wire [16:0] lfsrLut_59;
  wire [16:0] lfsrLut_60;
  wire [16:0] lfsrLut_61;
  wire [16:0] lfsrLut_62;
  wire [16:0] lfsrLut_63;
  wire [16:0] lfsrLut_64;
  wire [16:0] lfsrLut_65;
  wire [16:0] lfsrLut_66;
  wire [16:0] lfsrLut_67;
  wire [16:0] lfsrLut_68;
  wire [16:0] lfsrLut_69;
  wire [16:0] lfsrLut_70;
  wire [16:0] lfsrLut_71;
  wire [16:0] lfsrLut_72;
  wire [16:0] lfsrLut_73;
  wire [16:0] lfsrLut_74;
  wire [16:0] lfsrLut_75;
  wire [16:0] lfsrLut_76;
  wire [16:0] lfsrLut_77;
  wire [16:0] lfsrLut_78;
  wire [16:0] lfsrLut_79;
  wire [16:0] lfsrLut_80;
  wire [16:0] lfsrLut_81;
  wire [16:0] lfsrLut_82;
  wire [16:0] lfsrLut_83;
  wire [16:0] lfsrLut_84;
  wire [16:0] lfsrLut_85;
  wire [16:0] lfsrLut_86;
  wire [16:0] lfsrLut_87;
  wire [16:0] lfsrLut_88;
  wire [16:0] lfsrLut_89;
  wire [16:0] lfsrLut_90;
  wire [16:0] lfsrLut_91;
  wire [16:0] lfsrLut_92;
  wire [16:0] lfsrLut_93;
  wire [16:0] lfsrLut_94;
  wire [16:0] lfsrLut_95;
  wire [16:0] lfsrLut_96;
  wire [16:0] lfsrLut_97;
  wire [16:0] lfsrLut_98;
  wire [16:0] lfsrLut_99;
  wire [16:0] lfsrLut_100;
  wire [16:0] lfsrLut_101;
  wire [16:0] lfsrLut_102;
  wire [16:0] lfsrLut_103;
  wire [16:0] lfsrLut_104;
  wire [16:0] lfsrLut_105;
  wire [16:0] lfsrLut_106;
  wire [16:0] lfsrLut_107;
  wire [16:0] lfsrLut_108;
  wire [16:0] lfsrLut_109;
  wire [16:0] lfsrLut_110;
  wire [16:0] lfsrLut_111;
  wire [16:0] lfsrLut_112;
  wire [16:0] lfsrLut_113;
  wire [16:0] lfsrLut_114;
  wire [16:0] lfsrLut_115;
  wire [16:0] lfsrLut_116;
  wire [16:0] lfsrLut_117;
  wire [16:0] lfsrLut_118;
  wire [16:0] lfsrLut_119;
  wire [16:0] lfsrLut_120;
  wire [16:0] lfsrLut_121;
  wire [16:0] lfsrLut_122;
  wire [16:0] lfsrLut_123;
  wire [16:0] lfsrLut_124;
  wire [16:0] lfsrLut_125;
  wire [16:0] lfsrLut_126;
  wire [16:0] lfsrLut_127;
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


  assign lfsrLut_0 = (17'b11101001001011000);
  assign lfsrLut_1 = (17'b11001011000111111);
  assign lfsrLut_2 = (17'b01110001100110111);
  assign lfsrLut_3 = (17'b11001010111101010);
  assign lfsrLut_4 = (17'b10111111000000100);
  assign lfsrLut_5 = (17'b01011100011011101);
  assign lfsrLut_6 = (17'b00110000001000011);
  assign lfsrLut_7 = (17'b01100101001101100);
  assign lfsrLut_8 = (17'b11111111101101011);
  assign lfsrLut_9 = (17'b11100011110110100);
  assign lfsrLut_10 = (17'b00000100111010110);
  assign lfsrLut_11 = (17'b11111101011111110);
  assign lfsrLut_12 = (17'b10011111101100111);
  assign lfsrLut_13 = (17'b00111110100011000);
  assign lfsrLut_14 = (17'b01111000100001011);
  assign lfsrLut_15 = (17'b01101010110111111);
  assign lfsrLut_16 = (17'b11011100111101110);
  assign lfsrLut_17 = (17'b10010001111000001);
  assign lfsrLut_18 = (17'b10001010101110100);
  assign lfsrLut_19 = (17'b10100101011010100);
  assign lfsrLut_20 = (17'b11001100011010001);
  assign lfsrLut_21 = (17'b10110111001101000);
  assign lfsrLut_22 = (17'b00011101101100001);
  assign lfsrLut_23 = (17'b10100110001010000);
  assign lfsrLut_24 = (17'b10111100011000111);
  assign lfsrLut_25 = (17'b11100010011100000);
  assign lfsrLut_26 = (17'b01001100010010010);
  assign lfsrLut_27 = (17'b01000110011011001);
  assign lfsrLut_28 = (17'b11000101001010101);
  assign lfsrLut_29 = (17'b00011100110001100);
  assign lfsrLut_30 = (17'b00100001101010101);
  assign lfsrLut_31 = (17'b00110001011011110);
  assign lfsrLut_32 = (17'b10101011101110111);
  assign lfsrLut_33 = (17'b11101111011000001);
  assign lfsrLut_34 = (17'b01110100001110111);
  assign lfsrLut_35 = (17'b01011001111001000);
  assign lfsrLut_36 = (17'b11101100100010001);
  assign lfsrLut_37 = (17'b11000111100101000);
  assign lfsrLut_38 = (17'b00110001111101101);
  assign lfsrLut_39 = (17'b01011110011110010);
  assign lfsrLut_40 = (17'b10101011101101001);
  assign lfsrLut_41 = (17'b10110110111101111);
  assign lfsrLut_42 = (17'b01011101000010110);
  assign lfsrLut_43 = (17'b00011100101010111);
  assign lfsrLut_44 = (17'b11001100100011111);
  assign lfsrLut_45 = (17'b10111100011001011);
  assign lfsrLut_46 = (17'b01010000000110111);
  assign lfsrLut_47 = (17'b11001100001000011);
  assign lfsrLut_48 = (17'b10010101111010000);
  assign lfsrLut_49 = (17'b00010000110000101);
  assign lfsrLut_50 = (17'b00001101100110000);
  assign lfsrLut_51 = (17'b11001000010000111);
  assign lfsrLut_52 = (17'b11100111101110011);
  assign lfsrLut_53 = (17'b00001001100010010);
  assign lfsrLut_54 = (17'b00000011101110100);
  assign lfsrLut_55 = (17'b01000001101100001);
  assign lfsrLut_56 = (17'b10011011001011101);
  assign lfsrLut_57 = (17'b10100101100010101);
  assign lfsrLut_58 = (17'b11000000101011110);
  assign lfsrLut_59 = (17'b10101110001001110);
  assign lfsrLut_60 = (17'b11001011111110101);
  assign lfsrLut_61 = (17'b10011111110011000);
  assign lfsrLut_62 = (17'b11011000100001001);
  assign lfsrLut_63 = (17'b11111100100000100);
  assign lfsrLut_64 = (17'b11001010010100000);
  assign lfsrLut_65 = (17'b01100100001110101);
  assign lfsrLut_66 = (17'b11010011100110010);
  assign lfsrLut_67 = (17'b00000100000100100);
  assign lfsrLut_68 = (17'b11011001001111001);
  assign lfsrLut_69 = (17'b10001111001011001);
  assign lfsrLut_70 = (17'b11101101100010010);
  assign lfsrLut_71 = (17'b01010000111000110);
  assign lfsrLut_72 = (17'b10011101000110100);
  assign lfsrLut_73 = (17'b01101011111010110);
  assign lfsrLut_74 = (17'b11011010010001110);
  assign lfsrLut_75 = (17'b00111110011100111);
  assign lfsrLut_76 = (17'b11010111001000001);
  assign lfsrLut_77 = (17'b00010000000010101);
  assign lfsrLut_78 = (17'b11101011110011011);
  assign lfsrLut_79 = (17'b11000111111100111);
  assign lfsrLut_80 = (17'b11000000011010100);
  assign lfsrLut_81 = (17'b10100000001111011);
  assign lfsrLut_82 = (17'b11000111101111000);
  assign lfsrLut_83 = (17'b11111111101100101);
  assign lfsrLut_84 = (17'b10111100010010001);
  assign lfsrLut_85 = (17'b10100010000001010);
  assign lfsrLut_86 = (17'b11111100110001100);
  assign lfsrLut_87 = (17'b00010000100000010);
  assign lfsrLut_88 = (17'b10010111001100100);
  assign lfsrLut_89 = (17'b10110111100010010);
  assign lfsrLut_90 = (17'b00101111011101100);
  assign lfsrLut_91 = (17'b10000010011011011);
  assign lfsrLut_92 = (17'b10111110001110010);
  assign lfsrLut_93 = (17'b01101010011011100);
  assign lfsrLut_94 = (17'b01101001100001101);
  assign lfsrLut_95 = (17'b11100001010101011);
  assign lfsrLut_96 = (17'b11001110001101101);
  assign lfsrLut_97 = (17'b11110110010110001);
  assign lfsrLut_98 = (17'b00001100100011001);
  assign lfsrLut_99 = (17'b00100000101110010);
  assign lfsrLut_100 = (17'b10011111100110010);
  assign lfsrLut_101 = (17'b11101010001001111);
  assign lfsrLut_102 = (17'b00100111111000100);
  assign lfsrLut_103 = (17'b11111011000100001);
  assign lfsrLut_104 = (17'b11010111000010100);
  assign lfsrLut_105 = (17'b11000000111100001);
  assign lfsrLut_106 = (17'b11001010001001111);
  assign lfsrLut_107 = (17'b01111001001001011);
  assign lfsrLut_108 = (17'b10100111001110110);
  assign lfsrLut_109 = (17'b00011101100111110);
  assign lfsrLut_110 = (17'b01111011100000111);
  assign lfsrLut_111 = (17'b11100010000011111);
  assign lfsrLut_112 = (17'b10011110010010111);
  assign lfsrLut_113 = (17'b00000010101111101);
  assign lfsrLut_114 = (17'b10110001001001111);
  assign lfsrLut_115 = (17'b00111110001001100);
  assign lfsrLut_116 = (17'b10011000011001011);
  assign lfsrLut_117 = (17'b10110000101101110);
  assign lfsrLut_118 = (17'b11011001100011110);
  assign lfsrLut_119 = (17'b11111010000001001);
  assign lfsrLut_120 = (17'b10011011101010000);
  assign lfsrLut_121 = (17'b10011000111111010);
  assign lfsrLut_122 = (17'b01000001100011110);
  assign lfsrLut_123 = (17'b11111001101011011);
  assign lfsrLut_124 = (17'b11100101110001101);
  assign lfsrLut_125 = (17'b00011100110110010);
  assign lfsrLut_126 = (17'b10011001110110111);
  assign lfsrLut_127 = (17'b10010101001011000);
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
