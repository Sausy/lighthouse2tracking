`define fsm_enumDefinition_2_defaultEncoding_type [1:0]
`define fsm_enumDefinition_2_defaultEncoding_boot 2'b00
`define fsm_enumDefinition_2_defaultEncoding_fsm_idle 2'b01
`define fsm_enumDefinition_2_defaultEncoding_fsm_receiveArg 2'b10

`define UartParityType_defaultEncoding_type [1:0]
`define UartParityType_defaultEncoding_NONE 2'b00
`define UartParityType_defaultEncoding_EVEN 2'b01
`define UartParityType_defaultEncoding_ODD 2'b10

`define UartStopType_defaultEncoding_type [0:0]
`define UartStopType_defaultEncoding_ONE 1'b0
`define UartStopType_defaultEncoding_TWO 1'b1

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

module UartCtrlTx (
      input  [2:0] io_configFrame_dataLength,
      input  `UartStopType_defaultEncoding_type io_configFrame_stop,
      input  `UartParityType_defaultEncoding_type io_configFrame_parity,
      input   io_samplingTick,
      input   io_write_valid,
      output reg  io_write_ready,
      input  [7:0] io_write_payload,
      output  io_txd,
      input   Slow_clk);
  wire  _zz_1_;
  wire [0:0] _zz_2_;
  wire [2:0] _zz_3_;
  wire [0:0] _zz_4_;
  wire [2:0] _zz_5_;
  reg  clockDivider_counter_willIncrement;
  wire  clockDivider_counter_willClear;
  reg [2:0] clockDivider_counter_valueNext;
  reg [2:0] clockDivider_counter_value = (3'b000);
  wire  clockDivider_counter_willOverflowIfInc;
  wire  clockDivider_tick;
  reg [2:0] tickCounter_value;
  reg `UartCtrlTxState_defaultEncoding_type stateMachine_state = `UartCtrlTxState_defaultEncoding_IDLE;
  reg  stateMachine_parity;
  reg  stateMachine_txd;
  reg  stateMachine_txd_regNext = 1'b1;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif

  assign _zz_1_ = (tickCounter_value == io_configFrame_dataLength);
  assign _zz_2_ = clockDivider_counter_willIncrement;
  assign _zz_3_ = {2'd0, _zz_2_};
  assign _zz_4_ = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? (1'b0) : (1'b1));
  assign _zz_5_ = {2'd0, _zz_4_};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      `UartStopType_defaultEncoding_ONE : io_configFrame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      `UartParityType_defaultEncoding_NONE : io_configFrame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_configFrame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : stateMachine_state_string = "IDLE  ";
      `UartCtrlTxState_defaultEncoding_START : stateMachine_state_string = "START ";
      `UartCtrlTxState_defaultEncoding_DATA : stateMachine_state_string = "DATA  ";
      `UartCtrlTxState_defaultEncoding_PARITY : stateMachine_state_string = "PARITY";
      `UartCtrlTxState_defaultEncoding_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @ (*) begin
    clockDivider_counter_willIncrement = 1'b0;
    if(io_samplingTick)begin
      clockDivider_counter_willIncrement = 1'b1;
    end
  end

  assign clockDivider_counter_willClear = 1'b0;
  assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == (3'b111));
  assign clockDivider_tick = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
  always @ (*) begin
    clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_3_);
    if(clockDivider_counter_willClear)begin
      clockDivider_counter_valueNext = (3'b000);
    end
  end

  always @ (*) begin
    stateMachine_txd = 1'b1;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        stateMachine_txd = 1'b0;
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        stateMachine_txd = io_write_payload[tickCounter_value];
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        stateMachine_txd = stateMachine_parity;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_write_ready = 1'b0;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_tick)begin
          if(_zz_1_)begin
            io_write_ready = 1'b1;
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
      end
      default : begin
      end
    endcase
  end

  assign io_txd = stateMachine_txd_regNext;
  always @ (posedge Slow_clk) begin
    clockDivider_counter_value <= clockDivider_counter_valueNext;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
        if((io_write_valid && clockDivider_tick))begin
          stateMachine_state <= `UartCtrlTxState_defaultEncoding_START;
        end
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        if(clockDivider_tick)begin
          stateMachine_state <= `UartCtrlTxState_defaultEncoding_DATA;
        end
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_tick)begin
          if(_zz_1_)begin
            if((io_configFrame_parity == `UartParityType_defaultEncoding_NONE))begin
              stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
            end else begin
              stateMachine_state <= `UartCtrlTxState_defaultEncoding_PARITY;
            end
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        if(clockDivider_tick)begin
          stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
        end
      end
      default : begin
        if(clockDivider_tick)begin
          if((tickCounter_value == _zz_5_))begin
            stateMachine_state <= (io_write_valid ? `UartCtrlTxState_defaultEncoding_START : `UartCtrlTxState_defaultEncoding_IDLE);
          end
        end
      end
    endcase
    stateMachine_txd_regNext <= stateMachine_txd;
  end

  always @ (posedge Slow_clk) begin
    if(clockDivider_tick)begin
      tickCounter_value <= (tickCounter_value + (3'b001));
    end
    if(clockDivider_tick)begin
      stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd);
    end
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        if(clockDivider_tick)begin
          stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
          tickCounter_value <= (3'b000);
        end
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_tick)begin
          if(_zz_1_)begin
            tickCounter_value <= (3'b000);
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        if(clockDivider_tick)begin
          tickCounter_value <= (3'b000);
        end
      end
      default : begin
      end
    endcase
  end

endmodule

module UartCtrlRx (
      input  [2:0] io_configFrame_dataLength,
      input  `UartStopType_defaultEncoding_type io_configFrame_stop,
      input  `UartParityType_defaultEncoding_type io_configFrame_parity,
      input   io_samplingTick,
      output  io_read_valid,
      output [7:0] io_read_payload,
      input   io_rxd,
      input   Slow_clk);
  wire  _zz_1_;
  wire  bufferCC_45__io_dataOut;
  wire  _zz_2_;
  wire  _zz_3_;
  wire [0:0] _zz_4_;
  wire [2:0] _zz_5_;
  wire  _zz_6_;
  wire  _zz_7_;
  wire  _zz_8_;
  wire  _zz_9_;
  wire  _zz_10_;
  wire  _zz_11_;
  wire  _zz_12_;
  wire  sampler_synchroniser;
  wire  sampler_samples_0;
  reg  sampler_samples_1 = 1'b1;
  reg  sampler_samples_2 = 1'b1;
  reg  sampler_samples_3 = 1'b1;
  reg  sampler_samples_4 = 1'b1;
  reg  sampler_value = 1'b1;
  reg  sampler_tick = 1'b0;
  reg [2:0] bitTimer_counter;
  reg  bitTimer_tick;
  reg [2:0] bitCounter_value;
  reg `UartCtrlRxState_defaultEncoding_type stateMachine_state = `UartCtrlRxState_defaultEncoding_IDLE;
  reg  stateMachine_parity;
  reg [7:0] stateMachine_shifter;
  reg  stateMachine_validReg = 1'b0;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif

  assign _zz_2_ = (sampler_tick && (! sampler_value));
  assign _zz_3_ = (bitCounter_value == io_configFrame_dataLength);
  assign _zz_4_ = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? (1'b0) : (1'b1));
  assign _zz_5_ = {2'd0, _zz_4_};
  assign _zz_6_ = ((((1'b0 || ((_zz_11_ && sampler_samples_1) && sampler_samples_2)) || (((_zz_12_ && sampler_samples_0) && sampler_samples_1) && sampler_samples_3)) || (((1'b1 && sampler_samples_0) && sampler_samples_2) && sampler_samples_3)) || (((1'b1 && sampler_samples_1) && sampler_samples_2) && sampler_samples_3));
  assign _zz_7_ = (((1'b1 && sampler_samples_0) && sampler_samples_1) && sampler_samples_4);
  assign _zz_8_ = ((1'b1 && sampler_samples_0) && sampler_samples_2);
  assign _zz_9_ = (1'b1 && sampler_samples_1);
  assign _zz_10_ = 1'b1;
  assign _zz_11_ = (1'b1 && sampler_samples_0);
  assign _zz_12_ = 1'b1;
  BufferCC bufferCC_45_ (
    .io_initial(_zz_1_),
    .io_dataIn(io_rxd),
    .io_dataOut(bufferCC_45__io_dataOut),
    .Slow_clk(Slow_clk)
 )/* synthesis syn_noprune=1 */;
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      `UartStopType_defaultEncoding_ONE : io_configFrame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      `UartParityType_defaultEncoding_NONE : io_configFrame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_configFrame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : stateMachine_state_string = "IDLE  ";
      `UartCtrlRxState_defaultEncoding_START : stateMachine_state_string = "START ";
      `UartCtrlRxState_defaultEncoding_DATA : stateMachine_state_string = "DATA  ";
      `UartCtrlRxState_defaultEncoding_PARITY : stateMachine_state_string = "PARITY";
      `UartCtrlRxState_defaultEncoding_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  assign _zz_1_ = 1'b0;
  assign sampler_synchroniser = bufferCC_45__io_dataOut;
  assign sampler_samples_0 = sampler_synchroniser;
  always @ (*) begin
    bitTimer_tick = 1'b0;
    if(sampler_tick)begin
      if((bitTimer_counter == (3'b000)))begin
        bitTimer_tick = 1'b1;
      end
    end
  end

  assign io_read_valid = stateMachine_validReg;
  assign io_read_payload = stateMachine_shifter;
  always @ (posedge Slow_clk) begin
    if(io_samplingTick)begin
      sampler_samples_1 <= sampler_samples_0;
    end
    if(io_samplingTick)begin
      sampler_samples_2 <= sampler_samples_1;
    end
    if(io_samplingTick)begin
      sampler_samples_3 <= sampler_samples_2;
    end
    if(io_samplingTick)begin
      sampler_samples_4 <= sampler_samples_3;
    end
    sampler_value <= ((((((_zz_6_ || _zz_7_) || (_zz_8_ && sampler_samples_4)) || ((_zz_9_ && sampler_samples_2) && sampler_samples_4)) || (((_zz_10_ && sampler_samples_0) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_1) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_2) && sampler_samples_3) && sampler_samples_4));
    sampler_tick <= io_samplingTick;
    stateMachine_validReg <= 1'b0;
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : begin
        if(_zz_2_)begin
          stateMachine_state <= `UartCtrlRxState_defaultEncoding_START;
        end
      end
      `UartCtrlRxState_defaultEncoding_START : begin
        if(bitTimer_tick)begin
          stateMachine_state <= `UartCtrlRxState_defaultEncoding_DATA;
          if((sampler_value == 1'b1))begin
            stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
          end
        end
      end
      `UartCtrlRxState_defaultEncoding_DATA : begin
        if(bitTimer_tick)begin
          if(_zz_3_)begin
            if((io_configFrame_parity == `UartParityType_defaultEncoding_NONE))begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_STOP;
              stateMachine_validReg <= 1'b1;
            end else begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_PARITY;
            end
          end
        end
      end
      `UartCtrlRxState_defaultEncoding_PARITY : begin
        if(bitTimer_tick)begin
          if((stateMachine_parity == sampler_value))begin
            stateMachine_state <= `UartCtrlRxState_defaultEncoding_STOP;
            stateMachine_validReg <= 1'b1;
          end else begin
            stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
          end
        end
      end
      default : begin
        if(bitTimer_tick)begin
          if((! sampler_value))begin
            stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
          end else begin
            if((bitCounter_value == _zz_5_))begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end
          end
        end
      end
    endcase
  end

  always @ (posedge Slow_clk) begin
    if(sampler_tick)begin
      bitTimer_counter <= (bitTimer_counter - (3'b001));
    end
    if(bitTimer_tick)begin
      bitCounter_value <= (bitCounter_value + (3'b001));
    end
    if(bitTimer_tick)begin
      stateMachine_parity <= (stateMachine_parity ^ sampler_value);
    end
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : begin
        if(_zz_2_)begin
          bitTimer_counter <= (3'b010);
        end
      end
      `UartCtrlRxState_defaultEncoding_START : begin
        if(bitTimer_tick)begin
          bitCounter_value <= (3'b000);
          stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
        end
      end
      `UartCtrlRxState_defaultEncoding_DATA : begin
        if(bitTimer_tick)begin
          stateMachine_shifter[bitCounter_value] <= sampler_value;
          if(_zz_3_)begin
            bitCounter_value <= (3'b000);
          end
        end
      end
      `UartCtrlRxState_defaultEncoding_PARITY : begin
        if(bitTimer_tick)begin
          bitCounter_value <= (3'b000);
        end
      end
      default : begin
      end
    endcase
  end

endmodule


module UartCtrl (
      input  [2:0] io_config_frame_dataLength,
      input  [0:0] io_config_frame_stop,
      input  [1:0] io_config_frame_parity,
      input  [19:0] io_config_clockDivider,
      input   io_write_valid,
      output  io_write_ready,
      input  [7:0] io_write_payload,
      output  io_read_valid,
      output [7:0] io_read_payload,
      output  io_uart_txd,
      input   io_uart_rxd,
      input   Slow_clk);
  wire  tx_io_write_ready;
  wire  tx_io_txd;
  wire  rx_io_read_valid;
  wire [7:0] rx_io_read_payload;
  reg [19:0] clockDivider_counter = (20'b00000000000000000000);
  wire  clockDivider_tick;

  UartCtrlTx tx (
    .io_configFrame_dataLength(io_config_frame_dataLength),
    .io_configFrame_stop(io_config_frame_stop),
    .io_configFrame_parity(io_config_frame_parity),
    .io_samplingTick(clockDivider_tick),
    .io_write_valid(io_write_valid),
    .io_write_ready(tx_io_write_ready),
    .io_write_payload(io_write_payload),
    .io_txd(tx_io_txd),
    .Slow_clk(Slow_clk)
 )/* synthesis syn_noprune=1 */;

  UartCtrlRx rx (
    .io_configFrame_dataLength(io_config_frame_dataLength),
    .io_configFrame_stop(io_config_frame_stop),
    .io_configFrame_parity(io_config_frame_parity),
    .io_samplingTick(clockDivider_tick),
    .io_read_valid(rx_io_read_valid),
    .io_read_payload(rx_io_read_payload),
    .io_rxd(io_uart_rxd),
    .Slow_clk(Slow_clk)

 )/* synthesis syn_noprune=1 */;



  assign clockDivider_tick = (clockDivider_counter == (20'b00000000000000000000));
  assign io_write_ready = tx_io_write_ready;
  assign io_read_valid = rx_io_read_valid;
  assign io_read_payload = rx_io_read_payload;
  assign io_uart_txd = tx_io_txd;
  always @ (posedge Slow_clk) begin
    clockDivider_counter <= (clockDivider_counter - (20'b00000000000000000001));
    if(clockDivider_tick)begin
      clockDivider_counter <= io_config_clockDivider;
    end
  end

endmodule



// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,    // 16MHz clock
    input io_uart_rxd,
    output io_uart_txd,

    inout io_e_0,
    inout io_d_0,
    inout io_e_1,
    inout io_d_1,
    inout io_e_2,
    inout io_d_2,
    inout io_e_3,
    inout io_d_3,
    inout io_e_4,
    inout io_d_4,
    inout io_e_5,
    inout io_d_5,
    inout io_e_6,
    inout io_d_6,
    inout io_e_7,
    inout io_d_7,
    output io_e_8,
    input io_d_8,

    output NinaUartRx,
    input NinaUartTx,

    output LED,   // User/boot LED next to power LED
    output USBPU  // USB pull-up resistor
);

    wire Core_clk;
    wire clk48MHz;
    wire pll_looked;

    wire rx;

    pll upll1(
      .clock_in   (CLK),
      .clock_out  (clk48MHz),
      .locked     (pll_looked)
    )/* synthesis syn_noprune=1 */;

    assign Core_clk = clk48MHz;

    wire Slow_clk;
      reg reg_Slow_clk = 1'b0;
      assign Slow_clk = reg_Slow_clk;//(start_lighthouse)?reg_clk24MHz:1'b0;// reg_clk24MHz;
    wire CFG_clk;
      reg reg_CFG_clk = 1'b0;
      assign CFG_clk = reg_CFG_clk;//(start_lighthouse)?reg_clk24MHz:1'b0;// reg_clk24MHz;

    always @(posedge Core_clk) begin : half_clk2
        reg_Slow_clk <= !reg_Slow_clk;
        if(reg_Slow_clk)
            reg_CFG_clk <= !reg_CFG_clk;
        //if(io_output_fifo_1__io_pop_valid == 1'b0)
              //module_select <= !module_select;
        module_select <= 1'b0;
    end


    /*
    always @ ( posedge Slow_clk) begin
      if(io_output_fifo_1__io_pop_valid == 1'b0)
            module_select <= !module_select;
    end
    */


    //wire

    wire reconfig_cmd;

    assign NinaUartRx = io_uart_txd;
    assign io_e_8 = io_uart_txd;
    //assign io_d_8 = io_uart_txd;
    //assign io_e_8 = NinaUartRx;
    //assign io_uart_rxd = NinaUartTx;


    //assign io_d_8 = NinaUartTx;
    //assign rx = io_e_8;
    //assign io_e_8 = reconfig_cmd;

    assign rx = NinaUartTx;
    //assign rx = io_d_8;


    //assign io_d_8 = io_output_fifo_1__io_pop_valid1;
    //assign io_e_8 = io_output_fifo_1__io_pop_valid2;

    /*
    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    ////////
    // make a simple blink circuit
    ////////

    // keep track of time and location in blink_pattern
    reg [25:0] blink_counter;

    // pattern that will be flashed over the LED over time
    wire [31:0] blink_pattern = 32'b101010001110111011100010101;

    // increment the blink_counter every clock
    always @(posedge Core_clk) begin
        blink_counter <= blink_counter + 1;
    end

    wire cfg_done;
    // light up the LED according to the pattern
    assign LED = (cfg_done)?blink_pattern[blink_counter[25:21]]:1'b0;

    */

    //wire e_0, e_1, e_2, e_3;
    //wire d_0, d_1, d_2, d_3;

    //assign io_e_0 = ()?:1'bz;
    //wire foo;
    //tran utran1 (foo, io_e_0);
    //tran (io_d_0, bMKR_D[6]);
    //tran (io_e_0, bMKR_D[7]);
    //tran (io_d_1, bMKR_D[8]);
    //tran (io_e_1, bMKR_D[9]);
    //wire  net1, net2, net3;
    //wire  net4, net5, net6;

    //tranif0 my_gate1 (net1, net2, net3)/* synthesis syn_noprune=1 */;
    wire warmboot_w;
    //assign warmboot_w = (slowArea_resetControl == (8'b11001111));

    SB_WARMBOOT slowArea_warmBoot (
      .BOOT(warmboot_w),
      .S1(1'b0),
      .S0(1'b0)
    )/* synthesis syn_noprune=1 */;

    wire [2:0] io_config_frame_dataLength;
    wire `UartStopType_defaultEncoding_type io_config_frame_stop;
    wire `UartParityType_defaultEncoding_type io_config_frame_parity;
    wire [19:0] io_config_clockDivider;



    wire slowArea_uartCtrl_io_read_valid;
    wire [7:0]  slowArea_uartCtrl_io_read_payload;
    wire slowArea_uartCtrl_io_uart_txd;
    wire ex_io_uart_rxd;
    wire [7:0] io_write_payload;



    //wire module_identifyer;
    //assign io_uart_txd = io_uart_txd;

    //reg [2:0] module_select = (3'b001);
    reg module_select = 1'b0;


    wire slowArea_uartCtrl_io_write_ready;


      wire allow_uart1;
      wire allow_uart2;
      assign allow_uart1 = !module_select;
      assign allow_uart2 = module_select;
      //wire slowArea_uartCtrl_io_write_ready2;
    //assign slowArea_uartCtrl_io_write_ready1 = (module_select ? 1'b0 : slowArea_uartCtrl_io_write_ready );
    //assign slowArea_uartCtrl_io_write_ready2 = module_select & slowArea_uartCtrl_io_write_ready ;//: 1'b0 );



    //reg slowArea_uartCtrl_io_write_ready_reg = 0;


  //assign io_uart_txd = ( module_select ? io_uart_txd_2 : io_uart_txd_1);

    UartCtrl slowArea_uartCtrl (
      .io_config_frame_dataLength(io_config_frame_dataLength),
      .io_config_frame_stop(io_config_frame_stop),
      .io_config_frame_parity(io_config_frame_parity),
      .io_config_clockDivider(io_config_clockDivider),
      .io_write_valid(io_output_fifo_1__io_pop_valid),
      .io_write_ready(slowArea_uartCtrl_io_write_ready),
      .io_write_payload(io_write_payload),
      .io_read_valid(slowArea_uartCtrl_io_read_valid),
      .io_read_payload(slowArea_uartCtrl_io_read_payload),
      .io_uart_txd(slowArea_uartCtrl_io_uart_txd),
      .io_uart_rxd(ex_io_uart_rxd),
      .Slow_clk(Slow_clk) //Slow_clk
    )/* synthesis syn_noprune=1 */;





    TS4231_init #(
        .CLK_FREQ_HZ(48_000_000)
      ) ts4231Configurator_1_ (
          .clk                (Core_clk),
          .clk_slow           (CFG_clk),
          .reset              (reconfig_cmd),

          .d_io               (io_d_input_oneforall),
          .oD_out             (d_out_oneforall), //ts4231Configurator_1__d_out
          .oD_state_out       (d_oe_oneforall), //ts4231Configurator_1__d_oe

          .e_io               (io_e_input_oneforall),
          .oE_out             (e_out_oneforall),//ts4231Configurator_1__e_out
          .oE_state_out       (e_oe_oneforall), //ts4231Configurator_1__e_oe

          //.debug_cstatus      (dbg_start_cfg),
          .cfg_done           (io_ts_configured_oneforall),
          .CONFIG_inital_delay   (1'b1)

     )/* synthesis syn_noprune=1 */;


     wire io_d_out_oneforall1;
     wire io_d_oe_oneforall1;
     wire io_e_out_oneforall1;
     wire io_e_oe_oneforall1;
     wire io_d_out_oneforall2;
     wire io_d_oe_oneforall2;
     wire io_e_out_oneforall2;
     wire io_e_oe_oneforall2;

     wire io_d_input_oneforall;
     wire io_e_input_oneforall;
     wire io_ts_configured_oneforall;

     wire d_out_oneforall;
     wire d_oe_oneforall;
     wire e_out_oneforall;
     wire e_oe_oneforall;

     assign io_d_out_oneforall1 = d_out_oneforall;
     assign io_d_oe_oneforall1 = d_oe_oneforall;
     assign io_e_out_oneforall1 = e_out_oneforall;
     assign io_e_oe_oneforall1 = e_oe_oneforall;

     assign io_d_out_oneforall2 = d_out_oneforall;
     assign io_d_oe_oneforall2 = d_oe_oneforall;
     assign io_e_out_oneforall2 = e_out_oneforall;
     assign io_e_oe_oneforall2 = e_oe_oneforall;

     wire uart_pushed_data_complete1;
     wire uart_pushed_data_complete2;



     // wenn uart_pushed data complet ist
     // dann sollte um geschalten werden auf ex_io_write_ready=0



    LighthouseTopLevel uinterf(
      .Core_clk     (Core_clk),//(iCLK_delayed),
      .Slow_clk     (Slow_clk),
      .CFG_clk      (CFG_clk),

      .io_e_0       (io_e_0),
      .io_e_1       (io_e_1),
      .io_e_2       (io_e_2),
      .io_e_3       (io_e_3),
      .io_d_0       (io_d_0),
      .io_d_1       (io_d_1),
      .io_d_2       (io_d_2),
      .io_d_3       (io_d_3),
      .io_e_4       (io_e_4),
      .io_e_5       (io_e_5),
      .io_e_6       (io_e_6),
      .io_e_7       (io_e_7),
      .io_d_4       (io_d_4),
      .io_d_5       (io_d_5),
      .io_d_6       (io_d_6),
      .io_d_7       (io_d_7),

      .warmboot_w   (warmboot_w),
      .reconfig_cmd (reconfig_cmd),

      .io_d_input_oneforall (io_d_input_oneforall),
      .io_d_out_oneforall (io_d_out_oneforall1),
      .io_d_oe_oneforall  (io_d_oe_oneforall1),
      .io_e_input_oneforall (io_e_input_oneforall),
      .io_e_out_oneforall (io_e_out_oneforall1),
      .io_e_oe_oneforall  (io_e_oe_oneforall1),
      .io_ts_configured_oneforall (io_ts_configured_oneforall),

      .ex_io_config_frame_dataLength(io_config_frame_dataLength),
      .ex_io_config_frame_stop(io_config_frame_stop),
      .ex_io_config_frame_parity(io_config_frame_parity),
      .ex_io_config_clockDivider(io_config_clockDivider),

      .ex_io_write_valid(io_output_fifo_1__io_pop_valid),
      .ex_io_write_ready(slowArea_uartCtrl_io_write_ready),
      .ex_io_write_payload(io_write_payload),
      .ex_io_read_valid(slowArea_uartCtrl_io_read_valid),
      .ex_io_read_payload(slowArea_uartCtrl_io_read_payload),
      .ex_io_uart_txd(slowArea_uartCtrl_io_uart_txd),
      .ex_io_uart_rxd(ex_io_uart_rxd),

      .allow_uart(allow_uart1),
      //.uart_pushed_data_complete(uart_pushed_data_complete1),


//      .ex_slowArea_identifiedBeamStream_payload_in (ex_slowArea_identifiedBeamStream_payload_2),
//      .ex_stream_rdy(ex_stream_rdy),



      //.dbg_e0_pin   (PIN_19),
      //.dbg_d0_pin   (PIN_20),
      //.cfg_done     (cfg_done),
		  .io_uart_txd  (io_uart_txd),
		  .io_uart_rxd  (rx),

      .module_identifyer (2'b01)
    )/* synthesis syn_noprune=1 */;


    //wire [95:0] ex_slowArea_identifiedBeamStream_payload_2;
    //wire ex_stream_rdy;



/*
wire clk24MHz;
  reg reg_clk24MHz = 1'b0;
  assign clk24MHz = reg_clk24MHz;//(start_lighthouse)?reg_clk12MHz:1'b0;// reg_clk12MHz;

always @(posedge Core_clk) begin : half_clk1
    reg_clk24MHz <= !reg_clk24MHz;
end

wire clk12MHz;
  reg reg_clk12MHz = 1'b0;
  assign clk12MHz = reg_clk12MHz;//(start_lighthouse)?reg_clk12MHz:1'b0;// reg_clk12MHz;

always @(posedge clk24MHz) begin : half_clk2
    reg_clk12MHz <= !reg_clk12MHz;
end

wire clk6MHz;
  reg reg_clk6MHz = 1'b0;
  assign clk6MHz = reg_clk6MHz;//(start_lighthouse)?reg_clk6MHz:1'b0;// reg_clk12MHz;

always @(posedge clk12MHz) begin : half_clk3
    reg_clk6MHz <= !reg_clk6MHz;
end*/


  /*
  wire [3:0] dbg_flags;
  dbg_inout #(
    .CLK_FREQ_HZ(48_000_000)
  ) ts4231Configurator_1_ (
    .clk        (Core_clk),
    .reset      (1'b0),

    .io_e_0     (io_e_0),
    .io_d_0     (io_d_0),
    .dbg_flags  (dbg_flags)

  )/* synthesis syn_noprune=1 *///;

  //assign PIN_20 = dbg_flags[2];
  //assign PIN_19 = dbg_flags[2];

/*
TS4231_init #(
    .CLK_FREQ_HZ(48_000_000)
  ) ts4231Configurator_1_ (
      .clk                (Core_clk),
      .clk_slow           (clk6MHz),
      .reset              (1'b0),

      .d_io               (dbg_d0_in),
      .oD_out             (dbg_d0_out),
      .oD_state_out       (dbg_d0_oe),

      .e_io               (dbg_e0_in),
      .oE_out             (dbg_e0_out),
      .oE_state_out       (dbg_e0_oe),

      //.debug_cstatus      (PIN_19),
      .cfg_done           (cfg_done),
      .CONFIG_inital_delay   (1'b1)

 *///)/* synthesis syn_noprune=1 */;




endmodule
