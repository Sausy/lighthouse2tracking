`define DEBUG_MODE //DEBUG uncomment=normal
module ts4231 #(parameter CLK_FREQ_HZ = 48_000_000, parameter NUMBER_OF_SENSORS = 1, parameter BUFFER_REG_LENGTH = 512, parameter BUFFER_ARRAY_SIZE_MAX = 10)//BUFFER_REGISTER_SIZE_MAX should be dividable by 8
  (
    input clock,  // clock
    input reset,  // reset
    inout D_io,
    inout E_io,
    output flag_init_done,
    output [20:0] data_stream[0:1], //two emittors
    output hard_reset_ts4321,

    /*
    // this is for the avalon interface
		input [15:0] 				avalon_slave_address,
		input 						avalon_slave_write,
		input signed 	[31:0] 	avalon_slave_writedata,
		input 						avalon_slave_read,
		output signed  [31:0] 	avalon_slave_readdata,
		output 						avalon_slave_waitrequest,*/

    input debug_in1,
		output debug_out1
  );

  localparam defOUT = 1;
  localparam defIN = 0;
  localparam BUFFER_REGISTER_SIZE_MAX_adjust = BUFFER_REG_LENGTH - 1;

  // PIN wire/reg
  wire        d_io                    ;
  wire        e_io                    ;
  wire  whard_reset_ts4321;
  assign hard_reset_ts4321 = whard_reset_ts4321;

    tran (e_io, E_io);
    tran (d_io, D_io);

  // FLAG wires
  wire        lighthouse_detected;
  wire        cfg_done                ;
      wire [0:14] cfg_data_reply;
  wire        capture_done;
  wire        start_watch;

  assign start_watch = start_watch_remote;


  // FLAG regs
  reg         start_cfg = 0;
  reg         start_watch_remote = 0;

  // DATA regs
  wire [0:BUFFER_REGISTER_SIZE_MAX_adjust] byte_stream [0:BUFFER_ARRAY_SIZE_MAX];
  reg [0:BUFFER_REGISTER_SIZE_MAX_adjust] byte_stream_dump ;
  wire [7:0] register_counter_data;

  wire debug_cstatus;
  wire debug_flag_allow_read;
  wire flag_LUT_overflow_triggerd;
  wire debug_difclk;
  wire debug_flag_allow_write;
  wire debug_flag_write_done;
  wire [15:0] debug_LUT_cnt;

  TS43231_init uinit (
      .clock                   (    clock                   ),
      .reset                   (    reset                   ),
      .d_io                    (    d_io                    ),
      .e_io                    (    e_io                    ),
      .cfg_done                (    cfg_done                ),
  	 .start_cfg                (    start_cfg               ),
     .start_watch              (    start_watch             ),
  	 .lighthouse_detected      (    lighthouse_detected     ),
  	 .cfg_data_reply           (    cfg_data_reply),
     .hard_reset_ts4321        (    whard_reset_ts4321 ),
     //.debug_cstatus            (),
     .debug_nstatus            (flag_LUT_overflow_triggerd),
     //.debug_difclk             (),
     .debug_flag_read_done     (debug_flag_allow_write),
     .debug_flag_write_done    (debug_flag_write_done),
     .debug_LUT_cnt            (debug_LUT_cnt)
   );

   /*
   always @(posedge clock, posedge reset) begin: IO_as_only_input
     if(reset)begin
        d_io_direct <= defIN;
          d_io_value <= 0;
        e_io_direct <= defIN;
          e_io_value <= 0;
     end else begin
        if(cfg_done)begin
          d_io_direct <= defIN;
          e_io_direct <= defIN;
          if(!d_io_direct)begin
            d_io_value <= 0;
            if(d_io)begin
              d_io_value <= 1;
            end
          end
          if(!e_io_direct)begin
            e_io_value <= 0;
            if(e_io)begin
              e_io_value <= 1;
            end
          end
        end
		end
   end*/

   //EVENTUEL RESET und CFG done auf den selben input legen ... damit reduzieren sich die Ports
   ts4231_datastream udata(
     .clock                   (    clock                   ),
     .reset                   (    reset                   ),
     .allow_capture           (    cfg_done                ),
     .data_input              (    d_io              ), //d_io_value
     .envelope_input          (    e_io              ), //e_io_value
     .data                    (    byte_stream             ),
     .capture_done            (    capture_done            ),
     .register_counter_data   (    register_counter_data   )
    );


    //====== DEBUG UART ======
    //---TX regs and wires
    reg        i_Tx_DV = 1;
    reg [7:0]  i_Tx_Byte = 8'd97; //a
    wire       o_Tx_Enable, o_Tx_Done, o_Tx_Active;
    wire       o_Tx_Pin;

    wire       o_Rx_DV;
    wire [7:0] o_Rx_Byte;

    reg [7:0]  rx_DATA [21:0];// = 8'd69;


    assign debug_out1 = o_Tx_Pin;

    `ifdef DEBUG_MODE
      uart_tx utx1(
      	.i_Clock(clock),
        .i_Tx_DV(i_Tx_DV),
        .i_Tx_Byte(i_Tx_Byte),
        .o_Tx_Active(o_Tx_Active),
        .o_Tx_Serial(o_Tx_Pin),
        .o_Tx_Enable(o_Tx_Enable),
        .o_Tx_Done(o_Tx_Done)
      );

      reg   [7:0]   	sendcounter = 0;
      reg   [7:0]   	foo_cnt = 0;
      reg 				    waitflag_tx = 0;
      reg   [15:0]    dbg_8bitslicer = BUFFER_REG_LENGTH-4;//-8;// (BUFFER_REG_LENGTH - 8); //8 because UART has 8 as length
      //reg [0:] buffer_byte_stream = 0;
      wire [7:0] ASCII_LUT [15:0];
      ascii_conv uHEX(clock,reset,ASCII_LUT);
      reg flag_data_slice_done;
      reg [0:14] temp_buffer;
      reg [0:14] config_data_buffer = 16'h392B;

      reg [7:0] register_counter_data_dump;

      //reg [7:0] dbg_msg_cfg_done;


      always @(posedge clock)begin : dbg_data_flush
      	waitflag_tx <= o_Tx_Done & !o_Tx_Active;
      	i_Tx_DV <= 0;
        //dbg_msg_cfg_done <= 8'd48;
        flag_data_slice_done <= 1;
        temp_buffer <= 0;
        register_counter_data_dump <= 0;
        byte_stream_dump <= byte_stream[0];
			if(waitflag_tx == 1)begin
				sendcounter <= sendcounter + 1;
				case(sendcounter)
					8'd0: i_Tx_Byte <= 8'd13;
					8'd1: i_Tx_Byte <= 8'd10;
          8'd2: i_Tx_Byte <= debug_flag_write_done + 8'd48;
          8'd3: i_Tx_Byte <= 8'd124;
          8'd4: i_Tx_Byte <= cfg_done + 8'd48;
          8'd5: i_Tx_Byte <= 8'd124;
					8'd6: i_Tx_Byte <= ASCII_LUT[cfg_data_reply[0:3]];//temp_buffer[0:7]+8'd48;
          8'd7: i_Tx_Byte <= ASCII_LUT[cfg_data_reply[4:7]];
          8'd8: i_Tx_Byte <= ASCII_LUT[cfg_data_reply[8:11]];
          8'd9: i_Tx_Byte <= ASCII_LUT[cfg_data_reply[12:14]<<1];//TODO: ADD LEFT shift 1 bit missing
					8'd10: begin
                  i_Tx_Byte <= 8'd124;
                  flag_data_slice_done <= 1;
                end
          8'd11: i_Tx_Byte <= ASCII_LUT[debug_LUT_cnt[3:0]];//temp_buffer[0:7]+8'd48;
          8'd12: i_Tx_Byte <= ASCII_LUT[debug_LUT_cnt[7:4]];
          8'd13: i_Tx_Byte <= ASCII_LUT[debug_LUT_cnt[11:8]];
          8'd14: i_Tx_Byte <= ASCII_LUT[debug_LUT_cnt[15:12]];
          8'd15 : i_Tx_Byte <= 8'd13;
          8'd16 : i_Tx_Byte <= 8'd13;
					8'd17: i_Tx_Byte <= 8'd10;
					default : begin
						 i_Tx_Byte <= 8'd99; //c
						 sendcounter <= 0;
					end
				endcase

      //  if(debug_flag_write_done)begin
      //    dbg_msg_cfg_done <= 8'd49;
      //  end

        /*
        if(cfg_done)begin
          if(sendcounter <= 8'd8)
            sendcounter <= 8'd8;
        end else begin
          if(flag_data_slice_done) begin
            temp_buffer <= cfg_data_reply;
            flag_data_slice_done <= 0;
          end
        end*/
        /*
        if(register_counter_data >= 8'd3)begin
          byte_stream_dump[]
        end*/


				if(cfg_done)begin
					 sendcounter <= 0;
					 i_Tx_Byte <= ASCII_LUT[(byte_stream_dump>>dbg_8bitslicer) & 4'hf];
           //shifting works like this e.g.: 48 bit long ... highes diget 47
           //only 8 top bits 48-8 right shift .... next 48-(2*8)
           dbg_8bitslicer <= dbg_8bitslicer - 16'd4;

				end
        if(dbg_8bitslicer == 0)begin
           dbg_8bitslicer <= BUFFER_REG_LENGTH-4;
           byte_stream_dump <= byte_stream[register_counter_data];
           i_Tx_Byte <= 8'd124;
        end
				/*if(dbg_8bitslicer == BUFFER_REG_LENGTH/8)begin //64 times   512/8
					dbg_8bitslicer <= 0;
				end*/

				if(!lighthouse_detected)begin
					 sendcounter <= 0;
					 dbg_8bitslicer <= 0;
					 i_Tx_Byte <= 8'd122; //b
				end

				waitflag_tx <= 0;
				i_Tx_DV <= 1;
			end

      end
    `endif

endmodule
