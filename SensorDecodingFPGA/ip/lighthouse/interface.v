module int_BufferCC_9_ (
      input   io_dataIn,
      output  io_dataOut,
      input   Slow_clk);
  reg  buffers_0;
  reg  buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge Slow_clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end

endmodule

module int_BufferCC_3_ (
      input   io_dataIn,
      output  io_dataOut,
      input   Core_clk);
  reg  buffers_0;
  reg  buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge Core_clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end
endmodule

module interface (
      input  Core_clk,
      input  Slow_clk,
      input  CFG_clk,

      inout  io_e_0,
      inout  io_d_0,

      input [23:0] slowArea_time,

      input [1:0] lh_id,

      output  io_d_input_oneforall,
      input   io_d_out_oneforall,
      input   io_d_oe_oneforall,
      output  io_e_input_oneforall,
      input   io_e_out_oneforall,
      input   io_e_oe_oneforall,
      input   io_ts_configured_oneforall,

      output slowArea_idBeamWords_0_valid,
      output [1:0] slowArea_idBeamWords_0_payload_id,
      output [15:0] slowArea_idBeamWords_0_payload_pulse_width,
      output [23:0] slowArea_idBeamWords_0_payload_pulse_timestamp,
      output [16:0] slowArea_idBeamWords_0_payload_beamWord,
      input streamArbiter_2__io_inputs_0_ready
  );

      assign io_d_input_oneforall = bufferCC_18__io_dataOut;
      assign d_out_oneforall = io_d_out_oneforall;
      assign d_oe_oneforall = io_d_oe_oneforall;

      assign io_e_input_oneforall = bufferCC_19__io_dataOut;
      assign e_out_oneforall = io_e_out_oneforall;
      assign e_oe_oneforall = io_e_oe_oneforall;

      wire e_oe_oneforall;
      assign ts4231Configurator_1__e_oe = e_oe_oneforall;
      wire e_out_oneforall;
      assign ts4231Configurator_1__e_out = e_out_oneforall;

      wire d_oe_oneforall;
      assign ts4231Configurator_1__d_oe = d_oe_oneforall;
      wire d_out_oneforall;
      assign ts4231Configurator_1__d_out = d_out_oneforall;

      assign ts4231Configurator_1__configured = io_ts_configured_oneforall;

      assign cfg_done = ts4231Configurator_1__configured;
      wire dbg_start_cfg;

      always @ ( posedge Core_clk ) begin
        dbg_e0_pin <= dbg_start_cfg;
        dbg_d0_pin <= ts4231Configurator_1__configured;
        /*if(io_e_0)
          dbg_e0_pin <= 1'b1;
        if(io_d_0)
          dbg_d0_pin <= 1'b1;*/
      end


      /*
      assign slowArea_idBeamWords_0_valid = streamFifo_3__io_pop_valid;
      assign slowArea_idBeamWords_0_payload_id = streamFifo_3__io_pop_payload_id;
      assign slowArea_idBeamWords_0_payload_pulse_width = streamFifo_3__io_pop_payload_pulse_width;
      assign slowArea_idBeamWords_0_payload_pulse_timestamp = streamFifo_3__io_pop_payload_pulse_timestamp;
      assign slowArea_idBeamWords_0_payload_beamWord = streamFifo_3__io_pop_payload_beamWord;
      assign slowArea_idBeamWords_0_ready = streamArbiter_2__io_inputs_0_ready;
      */


  wire  _zz_22_;
  wire  _zz_23_;
  wire  _zz_24_;
  wire  _zz_25_;
  wire  _zz_26_;
  wire  _zz_27_;
  wire [1:0] _zz_28_;
  wire  _zz_29_;
  wire  _zz_30_;
  wire [2:0] _zz_31_;

  wire [19:0] _zz_34_;
  wire [7:0] _zz_35_;
  wire  _zz_36_;
  wire  _zz_37_;
  wire  _zz_38_;
  wire  _zz_39_;
  wire  _zz_40_;
  reg [7:0] _zz_41_;

  wire  sB_IO_1__D_IN_0;
  wire  sB_IO_1__D_IN_1;
  wire  bufferCC_12__io_dataOut;
  wire  bufferCC_13__io_dataOut;
  wire  bufferCC_14__io_dataOut;
  wire  sB_IO_2__D_IN_0;
  wire  sB_IO_2__D_IN_1;
  wire  bufferCC_15__io_dataOut;
  wire  bufferCC_16__io_dataOut;
  wire  bufferCC_17__io_dataOut;
  wire  ddrBmcDecoder_1__io_output_valid;
  wire  ddrBmcDecoder_1__io_output_payload;
  wire  ddrBmcDecoder_1__io_synchronized;
  wire  shiftBuffer_1__io_dataIn_ready;
  wire  shiftBuffer_1__io_dataOut_valid;
  wire [16:0] shiftBuffer_1__io_dataOut_payload;
  wire  ts4231Configurator_1__configured;
  wire  ts4231Configurator_1__d_out;
  wire  ts4231Configurator_1__d_oe;
  wire  ts4231Configurator_1__e_out;
  wire  ts4231Configurator_1__e_oe;
  wire  bufferCC_18__io_dataOut;
  wire  bufferCC_19__io_dataOut;
  wire  pulseTimer_1__io_pulse_valid;
  wire [15:0] pulseTimer_1__io_pulse_payload_width;
  wire [23:0] pulseTimer_1__io_pulse_payload_timestamp;
  wire  bufferCC_20__io_dataOut;
  wire  streamCCByToggle_1__io_input_ready;
  wire  streamCCByToggle_1__io_output_valid;
  wire [16:0] streamCCByToggle_1__io_output_payload;
  wire  streamFifo_3__io_push_ready;
  wire  streamFifo_3__io_pop_valid;
  wire [1:0] streamFifo_3__io_pop_payload_id;
  wire [15:0] streamFifo_3__io_pop_payload_pulse_width;
  wire [23:0] streamFifo_3__io_pop_payload_pulse_timestamp;
  wire [16:0] streamFifo_3__io_pop_payload_beamWord;
  wire [1:0] streamFifo_3__io_occupancy;
  wire [1:0] streamFifo_3__io_availability;
  wire  streamArbiter_2__io_inputs_0_ready;
  wire  streamArbiter_2__io_output_valid;
  wire [1:0] streamArbiter_2__io_output_payload_id;
  wire [15:0] streamArbiter_2__io_output_payload_pulse_width;
  wire [23:0] streamArbiter_2__io_output_payload_pulse_timestamp;
  wire [16:0] streamArbiter_2__io_output_payload_beamWord;
  wire [0:0] streamArbiter_2__io_chosenOH;
  wire  io_output_fifo_io_push_ready;
  wire  io_output_fifo_io_pop_valid;
  wire [1:0] io_output_fifo_io_pop_payload_id;
  wire [15:0] io_output_fifo_io_pop_payload_pulse_width;
  wire [23:0] io_output_fifo_io_pop_payload_pulse_timestamp;
  wire [16:0] io_output_fifo_io_pop_payload_beamWord;
  wire [7:0] io_output_fifo_io_occupancy;
  wire [7:0] io_output_fifo_io_availability;
  wire  slowArea_pulseIdentifier_io_pulseIn_ready;
  wire  slowArea_pulseIdentifier_io_pulseOut_valid;
  wire [5:0] slowArea_pulseIdentifier_io_pulseOut_payload_npoly;
  wire [15:0] slowArea_pulseIdentifier_io_pulseOut_payload_pulse_width;
  wire [23:0] slowArea_pulseIdentifier_io_pulseOut_payload_pulse_timestamp;
  wire [16:0] slowArea_pulseIdentifier_io_pulseOut_payload_beamWord;
  wire [1:0] slowArea_pulseIdentifier_io_pulseOut_payload_id;
  wire  slowArea_pulseOffsetFinder_io_pulseIn_ready;
  wire  slowArea_pulseOffsetFinder_io_pulseOut_valid;
  wire [16:0] slowArea_pulseOffsetFinder_io_pulseOut_payload_offset;
  wire [5:0] slowArea_pulseOffsetFinder_io_pulseOut_payload_npoly;
  wire [15:0] slowArea_pulseOffsetFinder_io_pulseOut_payload_pulse_width;
  wire [23:0] slowArea_pulseOffsetFinder_io_pulseOut_payload_pulse_timestamp;
  wire [16:0] slowArea_pulseOffsetFinder_io_pulseOut_payload_beamWord;
  wire [1:0] slowArea_pulseOffsetFinder_io_pulseOut_payload_id;
  wire  streamArbiter_3__io_inputs_0_ready;
  wire  streamArbiter_3__io_inputs_1_ready;
  wire  streamArbiter_3__io_output_valid;
  wire [119:0] streamArbiter_3__io_output_payload;
  wire [0:0] streamArbiter_3__io_chosen;
  wire [1:0] streamArbiter_3__io_chosenOH;
  wire  slowArea_uartCtrl_io_write_ready;
  wire  slowArea_uartCtrl_io_read_valid;
  wire [7:0] slowArea_uartCtrl_io_read_payload;
  wire  slowArea_uartCtrl_io_uart_txd;
  wire  io_output_fifo_1__io_push_ready;
  wire  io_output_fifo_1__io_pop_valid;
  wire [119:0] io_output_fifo_1__io_pop_payload;
  wire [7:0] io_output_fifo_1__io_occupancy;
  wire [7:0] io_output_fifo_1__io_availability;
  wire  slowArea_commandHandler_io_ledCommand_valid;
  wire [7:0] slowArea_commandHandler_io_ledCommand_payload;
  wire  slowArea_commandHandler_io_resetCommand_valid;
  wire [7:0] slowArea_commandHandler_io_resetCommand_payload;
  wire  _zz_42_;
  wire [1:0] _zz_43_;
  wire [1:0] _zz_44_;
  wire [1:0] _zz_45_;
  wire [0:0] _zz_46_;
  wire [23:0] _zz_47_;
  wire [0:0] _zz_48_;
  wire [3:0] _zz_49_;
  wire [0:0] _zz_50_;
  wire [23:0] _zz_51_;
  wire [0:0] _zz_52_;
  wire [21:0] _zz_53_;
  //wire  Core_clk;
  //wire  Slow_clk;
  //reg  slowClkCtrl_slowClk = 1'b0;
  wire  e_0;
  wire  e_out_0;
  wire  e_oe_0;
  wire  d_0;
  wire  d_out_0;
  wire  d_oe_0;
  wire  core_beamWords_0_valid;
  wire  core_beamWords_0_ready;
  wire [16:0] core_beamWords_0_payload;
  reg  _zz_1_;
  reg  _zz_2_;
  reg  _zz_3_;
  reg  _zz_4_;
  reg  sB_IO_1__D_IN_0_regNext;
  reg  sB_IO_1__D_IN_0_regNext_regNext;
  wire  _zz_5_;
  reg  _zz_6_;
  reg  _zz_7_ = 1'b0;
  reg  _zz_8_;
  reg  sB_IO_1__D_IN_0_regNext_1_;
  reg  sB_IO_1__D_IN_0_regNext_1__regNext;
  reg  _zz_9_;
  wire  shiftBuffer_1__io_dataOut_m2sPipe_valid;
  wire  shiftBuffer_1__io_dataOut_m2sPipe_ready;
  wire [16:0] shiftBuffer_1__io_dataOut_m2sPipe_payload;
  reg  shiftBuffer_1__io_dataOut_m2sPipe_rValid = 1'b0;
  reg [16:0] shiftBuffer_1__io_dataOut_m2sPipe_rData;
  //reg [23:0] slowArea_time = (24'b000000000000000000000000);
  //wire  slowArea_idBeamWords_0_valid;
  //wire  slowArea_idBeamWords_0_ready;
  //wire [4:0] slowArea_idBeamWords_0_payload_id;
  //wire [15:0] slowArea_idBeamWords_0_payload_pulse_width;
  //wire [23:0] slowArea_idBeamWords_0_payload_pulse_timestamp;
  //wire [16:0] slowArea_idBeamWords_0_payload_beamWord;
  reg  _zz_10_ = 1'b0;
  reg [16:0] _zz_11_;
  wire  _zz_12_;
  wire  slowArea_identifiedBeamStream_valid;
  wire  slowArea_identifiedBeamStream_ready;
  wire [119:0] slowArea_identifiedBeamStream_payload;
  wire  slowArea_syncStream_valid;
  wire  slowArea_syncStream_ready;
  wire [119:0] slowArea_syncStream_payload;
  reg  slowArea_syncTimeout_state = 1'b0;
  reg  slowArea_syncTimeout_stateRise;
  wire  slowArea_syncTimeout_counter_willIncrement;
  reg  slowArea_syncTimeout_counter_willClear;
  reg [23:0] slowArea_syncTimeout_counter_valueNext;
  reg [23:0] slowArea_syncTimeout_counter_value = (24'b000000000000000000000000);

  wire  slowArea_syncStream_m2sPipe_valid;
  wire  slowArea_syncStream_m2sPipe_ready;
  wire [119:0] slowArea_syncStream_m2sPipe_payload;
  reg  slowArea_syncStream_m2sPipe_rValid = 1'b0;
  reg [119:0] slowArea_syncStream_m2sPipe_rData;
  wire  slowArea_identifiedBeamStream_m2sPipe_valid;
  wire  slowArea_identifiedBeamStream_m2sPipe_ready;
  wire [119:0] slowArea_identifiedBeamStream_m2sPipe_payload;
  reg  slowArea_identifiedBeamStream_m2sPipe_rValid = 1'b0;
  reg [119:0] slowArea_identifiedBeamStream_m2sPipe_rData;
  reg  _zz_13_;
  reg [3:0] _zz_14_;
  reg [3:0] _zz_15_ = (4'b0000);
  wire  _zz_16_;
  wire  _zz_17_;
  wire [119:0] _zz_18_;
  reg [7:0] slowArea_ledControl;
  reg  slowArea_slowBlink = 1'b0;
  reg  slowArea_slowBlinkTimer_state = 1'b0;
  reg  slowArea_slowBlinkTimer_stateRise;
  wire  slowArea_slowBlinkTimer_counter_willIncrement;
  reg  slowArea_slowBlinkTimer_counter_willClear;
  reg [23:0] slowArea_slowBlinkTimer_counter_valueNext;
  reg [23:0] slowArea_slowBlinkTimer_counter_value = (24'b000000000000000000000000);
  wire  slowArea_slowBlinkTimer_counter_willOverflowIfInc;
  wire  slowArea_slowBlinkTimer_counter_willOverflow;
  reg  slowArea_fastBlink = 1'b0;
  reg  slowArea_fastBlinkTimer_state = 1'b0;
  reg  slowArea_fastBlinkTimer_stateRise;
  wire  slowArea_fastBlinkTimer_counter_willIncrement;
  reg  slowArea_fastBlinkTimer_counter_willClear;
  reg [21:0] slowArea_fastBlinkTimer_counter_valueNext;
  reg [21:0] slowArea_fastBlinkTimer_counter_value = (22'b0000000000000000000000);
  wire  slowArea_fastBlinkTimer_counter_willOverflowIfInc;
  wire  slowArea_fastBlinkTimer_counter_willOverflow;
  reg  _zz_19_;
  reg  _zz_20_;
  reg  _zz_21_;
  reg [7:0] slowArea_resetControl;
  assign _zz_42_ = ((1'b1 && (! _zz_5_)) || _zz_6_);
  assign _zz_43_ = slowArea_ledControl[1 : 0];
  assign _zz_44_ = slowArea_ledControl[3 : 2];
  assign _zz_45_ = slowArea_ledControl[5 : 4];
  assign _zz_46_ = slowArea_syncTimeout_counter_willIncrement;
  assign _zz_47_ = {23'd0, _zz_46_};
  assign _zz_48_ = _zz_13_;
  assign _zz_49_ = {3'd0, _zz_48_};
  assign _zz_50_ = slowArea_slowBlinkTimer_counter_willIncrement;
  assign _zz_51_ = {23'd0, _zz_50_};
  assign _zz_52_ = slowArea_fastBlinkTimer_counter_willIncrement;
  assign _zz_53_ = {21'd0, _zz_52_};

  SB_IO #(
    .PIN_TYPE((6'b110000))
  ) sB_IO_1_ (
    .PACKAGE_PIN(io_e_0),
    .CLOCK_ENABLE(_zz_22_),
    .INPUT_CLK(Core_clk),
    .OUTPUT_CLK(Core_clk),
    .OUTPUT_ENABLE(bufferCC_12__io_dataOut),
    .D_OUT_0(bufferCC_13__io_dataOut),
    .D_OUT_1(bufferCC_14__io_dataOut),
    .D_IN_0(sB_IO_1__D_IN_0),
    .D_IN_1(sB_IO_1__D_IN_1)
  )/* synthesis syn_noprune=1 */;
  int_BufferCC_3_ bufferCC_12_ (
    .io_dataIn(e_oe_0),
    .io_dataOut(bufferCC_12__io_dataOut),
    .Core_clk(Core_clk)
  )/* synthesis syn_noprune=1 */;
  int_BufferCC_3_ bufferCC_13_ (
    .io_dataIn(e_out_0),
    .io_dataOut(bufferCC_13__io_dataOut),
    .Core_clk(Core_clk)
  )/* synthesis syn_noprune=1 */;
  int_BufferCC_3_ bufferCC_14_ (
    .io_dataIn(e_out_0),
    .io_dataOut(bufferCC_14__io_dataOut),
    .Core_clk(Core_clk)
  )/* synthesis syn_noprune=1 */;
  SB_IO #(
    .PIN_TYPE((6'b110000))
  ) sB_IO_2_ (
    .PACKAGE_PIN(io_d_0),
    .CLOCK_ENABLE(1'b1),
    .INPUT_CLK(Core_clk),
    .OUTPUT_CLK(Core_clk),
    .OUTPUT_ENABLE(bufferCC_15__io_dataOut),
    .D_OUT_0(bufferCC_16__io_dataOut),
    .D_OUT_1(bufferCC_17__io_dataOut),
    .D_IN_0(sB_IO_2__D_IN_0),
    .D_IN_1(sB_IO_2__D_IN_1)
  );
  int_BufferCC_3_ bufferCC_15_ (
    .io_dataIn(d_oe_0),
    .io_dataOut(bufferCC_15__io_dataOut),
    .Core_clk(Core_clk)
  )/* synthesis syn_noprune=1 */;
  int_BufferCC_3_ bufferCC_16_ (
    .io_dataIn(d_out_0),
    .io_dataOut(bufferCC_16__io_dataOut),
    .Core_clk(Core_clk)
  )/* synthesis syn_noprune=1 */;
  int_BufferCC_3_ bufferCC_17_ (
    .io_dataIn(d_out_0),
    .io_dataOut(bufferCC_17__io_dataOut),
    .Core_clk(Core_clk)
  )/* synthesis syn_noprune=1 */;
  DdrBmcDecoder ddrBmcDecoder_1_ (
    .io_signal_v_0(_zz_3_),
    .io_signal_v_1(_zz_4_),
    .io_enable(_zz_24_),
    .io_output_valid(ddrBmcDecoder_1__io_output_valid),
    .io_output_payload(ddrBmcDecoder_1__io_output_payload),
    .io_synchronized(ddrBmcDecoder_1__io_synchronized),
    .Core_clk(Core_clk)
  );
  ShiftBuffer shiftBuffer_1_ (
    .io_dataIn_valid(_zz_9_),
    .io_dataIn_ready(shiftBuffer_1__io_dataIn_ready),
    .io_dataIn_payload(_zz_8_),
    .io_dataOut_valid(shiftBuffer_1__io_dataOut_valid),
    .io_dataOut_ready(_zz_25_),
    .io_dataOut_payload(shiftBuffer_1__io_dataOut_payload),
    .io_resetBuffer(_zz_26_),
    .Core_clk(Core_clk)
  )/* synthesis syn_noprune=1 */;

  /*
  ts4231Configurator ts4231Configurator_1_ (
    .clk(Slow_clk),
    .reconfigure(_zz_10_),
    .configured(ts4231Configurator_1__configured),
    .d_in(bufferCC_18__io_dataOut),
    .d_out(ts4231Configurator_1__d_out),
    .d_oe(ts4231Configurator_1__d_oe),
    .e_in(bufferCC_19__io_dataOut),
    .e_out(ts4231Configurator_1__e_out),
    .e_oe(ts4231Configurator_1__e_oe)
  );
  */
  int_BufferCC_9_ bufferCC_18_ (
    .io_dataIn(d_0),
    .io_dataOut(bufferCC_18__io_dataOut),
    .Slow_clk(Slow_clk)
  )/* synthesis syn_noprune=1 */;
  int_BufferCC_9_ bufferCC_19_ (
    .io_dataIn(e_0),
    .io_dataOut(bufferCC_19__io_dataOut),
    .Slow_clk(Slow_clk)
  )/* synthesis syn_noprune=1 */;
  PulseTimer pulseTimer_1_ (
    .io_time(slowArea_time),
    .io_e(bufferCC_20__io_dataOut),
    .io_pulse_valid(pulseTimer_1__io_pulse_valid),
    .io_pulse_payload_width(pulseTimer_1__io_pulse_payload_width),
    .io_pulse_payload_timestamp(pulseTimer_1__io_pulse_payload_timestamp),
    .Slow_clk(Slow_clk)
  )/* synthesis syn_noprune=1 */;
  int_BufferCC_9_ bufferCC_20_ (
    .io_dataIn(e_0),
    .io_dataOut(bufferCC_20__io_dataOut),
    .Slow_clk(Slow_clk)
  )/* synthesis syn_noprune=1 */;
  StreamCCByToggle streamCCByToggle_1_ (
    .io_input_valid(core_beamWords_0_valid),
    .io_input_ready(streamCCByToggle_1__io_input_ready),
    .io_input_payload(core_beamWords_0_payload),
    .io_output_valid(streamCCByToggle_1__io_output_valid),
    .io_output_ready(_zz_27_),
    .io_output_payload(streamCCByToggle_1__io_output_payload),
    .Core_clk(Core_clk),
    .Slow_clk(Slow_clk)
  )/* synthesis syn_noprune=1 */;
  StreamFifo streamFifo_3_ (
    .io_push_valid(_zz_12_),
    .io_push_ready(streamFifo_3__io_push_ready),
    .io_push_payload_id(lh_id),
    .io_push_payload_pulse_width(pulseTimer_1__io_pulse_payload_width),
    .io_push_payload_pulse_timestamp(pulseTimer_1__io_pulse_payload_timestamp),
    .io_push_payload_beamWord(_zz_11_),
    .io_pop_valid(streamFifo_3__io_pop_valid),
    .io_pop_ready(slowArea_idBeamWords_0_ready),
    .io_pop_payload_id(streamFifo_3__io_pop_payload_id),
    .io_pop_payload_pulse_width(streamFifo_3__io_pop_payload_pulse_width),
    .io_pop_payload_pulse_timestamp(streamFifo_3__io_pop_payload_pulse_timestamp),
    .io_pop_payload_beamWord(streamFifo_3__io_pop_payload_beamWord),
    .io_flush(1'b0),
    .io_occupancy(streamFifo_3__io_occupancy),
    .io_availability(streamFifo_3__io_availability),
    .Slow_clk(Slow_clk)
  )/* synthesis syn_noprune=1 */;



  assign _zz_22_ = 1'b1;
  assign e_0 = sB_IO_1__D_IN_0;
  assign _zz_23_ = 1'b1;
  assign d_0 = sB_IO_2__D_IN_0;
  assign _zz_24_ = 1'b1;
  assign _zz_26_ = ((! sB_IO_1__D_IN_0_regNext) && sB_IO_1__D_IN_0_regNext_regNext);
  assign _zz_5_ = _zz_7_;
  always @ (*) begin
    _zz_9_ = _zz_5_;
    if(sB_IO_1__D_IN_0_regNext_1__regNext)begin
      _zz_9_ = 1'b0;
    end
  end

  always @ (*) begin
    _zz_6_ = shiftBuffer_1__io_dataIn_ready;
    if(sB_IO_1__D_IN_0_regNext_1__regNext)begin
      _zz_6_ = 1'b1;
    end
  end

  always @ (posedge Core_clk) begin
    slowClkCtrl_slowClk <= (! slowClkCtrl_slowClk);
    if(_zz_42_)begin
      _zz_7_ <= ddrBmcDecoder_1__io_output_valid;
    end
    if(_zz_25_)begin
      shiftBuffer_1__io_dataOut_m2sPipe_rValid <= shiftBuffer_1__io_dataOut_valid;
    end
  end


  assign _zz_25_ = ((1'b1 && (! shiftBuffer_1__io_dataOut_m2sPipe_valid)) || shiftBuffer_1__io_dataOut_m2sPipe_ready);
  assign shiftBuffer_1__io_dataOut_m2sPipe_valid = shiftBuffer_1__io_dataOut_m2sPipe_rValid;
  assign shiftBuffer_1__io_dataOut_m2sPipe_payload = shiftBuffer_1__io_dataOut_m2sPipe_rData;

  assign core_beamWords_0_valid = shiftBuffer_1__io_dataOut_m2sPipe_valid;
  assign shiftBuffer_1__io_dataOut_m2sPipe_ready = core_beamWords_0_ready;
  assign core_beamWords_0_payload = shiftBuffer_1__io_dataOut_m2sPipe_payload;
  assign d_out_0 = ts4231Configurator_1__d_out;
  assign d_oe_0 = ts4231Configurator_1__d_oe;
  assign e_out_0 = ts4231Configurator_1__e_out;
  assign e_oe_0 = ts4231Configurator_1__e_oe;
  assign core_beamWords_0_ready = streamCCByToggle_1__io_input_ready;
  assign _zz_27_ = 1'b1;
  assign _zz_12_ = pulseTimer_1__io_pulse_valid;
  //assign _zz_28_ = (5'b00000);
  assign slowArea_idBeamWords_0_valid = streamFifo_3__io_pop_valid;
  assign slowArea_idBeamWords_0_payload_id = streamFifo_3__io_pop_payload_id;
  assign slowArea_idBeamWords_0_payload_pulse_width = streamFifo_3__io_pop_payload_pulse_width;
  assign slowArea_idBeamWords_0_payload_pulse_timestamp = streamFifo_3__io_pop_payload_pulse_timestamp;
  assign slowArea_idBeamWords_0_payload_beamWord = streamFifo_3__io_pop_payload_beamWord;
  assign slowArea_idBeamWords_0_ready = streamArbiter_2__io_inputs_0_ready;

  always @ (posedge Core_clk) begin
    _zz_1_ <= sB_IO_2__D_IN_0;
    _zz_2_ <= sB_IO_2__D_IN_1;
    _zz_3_ <= _zz_1_;
    _zz_4_ <= _zz_2_;
    sB_IO_1__D_IN_0_regNext <= sB_IO_1__D_IN_0;
    sB_IO_1__D_IN_0_regNext_regNext <= sB_IO_1__D_IN_0_regNext;
    if(_zz_42_)begin
      _zz_8_ <= ddrBmcDecoder_1__io_output_payload;
    end
    sB_IO_1__D_IN_0_regNext_1_ <= sB_IO_1__D_IN_0;
    sB_IO_1__D_IN_0_regNext_1__regNext <= sB_IO_1__D_IN_0_regNext_1_;
    if(_zz_25_)begin
      shiftBuffer_1__io_dataOut_m2sPipe_rData <= shiftBuffer_1__io_dataOut_payload;
    end
  end

  always @ (posedge Slow_clk) begin
    if((streamCCByToggle_1__io_output_valid && _zz_27_))begin
      _zz_11_ <= streamCCByToggle_1__io_output_payload;
    end
    if(_zz_12_)begin
      _zz_11_ <= (17'b11000000000000011);
    end
  end


endmodule
