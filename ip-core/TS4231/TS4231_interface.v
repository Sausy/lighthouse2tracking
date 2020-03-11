`define DEBUG_MODE //DEBUG uncomment=normal
module ts4231 #(parameter CLK_FREQ_HZ = 48_000_000, parameter NUMBER_OF_SENSORS = 1, parameter BUFFER_REG_LENGTH = 512, parameter BUFFER_ARRAY_SIZE_MAX = 10)//BUFFER_REGISTER_SIZE_MAX should be dividable by 8
  (
    input clock,  // clock
    input reset,  // reset
    inout D_io,
    inout E_io,
    output flag_init_done,
    output [20:0] data_stream[0:1], //two emittors

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

  assign E_io = e_io;
  assign D_io = d_io;

  localparam defOUT = 1;
  localparam defIN = 0;
  localparam BUFFER_REGISTER_SIZE_MAX_adjust = BUFFER_REG_LENGTH - 1;

  // PIN wire/reg
  wire        d_io                    ;
  wire        e_io                    ;
    reg	       d_io_direct            ;
    reg	       d_io_value             ;
    reg	       e_io_direct            ;
    reg	       e_io_value             ;

  // FLAG wires
  wire        lighthouse_detected;
  wire        cfg_done                ;
      wire [0:14] cfg_data_reply;
  wire        capture_done;

  // FLAG regs
  reg         start_cfg;

  // DATA regs
  wire [0:BUFFER_REGISTER_SIZE_MAX_adjust] byte_stream [0:BUFFER_ARRAY_SIZE_MAX];
  wire [7:0] register_counter_data;

  assign d_io = d_io_direct ? d_io_value:1'bz;
  assign e_io = e_io_direct ? e_io_value:1'bz;

  TS43231_init uinit (
      .clock                   (    clock                   ),
      .reset                   (    reset                   ),
      .d_io                    (    d_io                    ),
      .d_io_direct             (    d_io_direct             ),
      .e_io                    (    e_io                    ),
      .e_io_direct             (    e_io_direct             ),
      .cfg_done                (    cfg_done                ),
  	 .start_cfg                (    start_cfg               ),
  	 .lighthouse_detected      (    lighthouse_detected     ),
  	 .cfg_data_reply           (    cfg_data_reply)
   );

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
   end

   //EVENTUEL RESET und CFG done auf den selben input legen ... damit reduzieren sich die Ports
   ts4231_datastream udata(
     .clock                   (    clock                   ),
     .reset                   (    reset                   ),
     .allow_capture           (    cfg_done                ),
     .data_input              (    d_io_value              ),
     .envelope_input          (    e_io_value              ),
     .data                    (    byte_stream             ),
     .capture_done            (    capture_done            ),
     .register_counter_data   (    register_counter_data   )
    );


    //====== DEBUG UART ======
    //---TX regs and wires
    reg        i_Tx_DV = 1;
    reg [7:0]  i_Tx_Byte = 8'd43;
    wire       o_Tx_Enable, o_Tx_Done, o_Tx_Active;
    wire       o_Tx_Pin;

    wire       o_Rx_DV;
    wire [7:0] o_Rx_Byte;

    reg [7:0]  rx_DATA [21:0];// = 8'd69;


    assign debug_out1 = o_Tx_Pin;

    `ifdef DEBUG_MODE
      uart_tx u1(
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
      reg   [15:0]    dbg_8bitslicer = BUFFER_REG_LENGTH-8;// (BUFFER_REG_LENGTH - 8); //8 because UART has 8 as length
      //reg [0:] buffer_byte_stream = 0;

      always @(posedge clock)begin : dbg_data_flush
      	waitflag_tx <= o_Tx_Done & !o_Tx_Active;
      	i_Tx_DV <= 0;
			if(waitflag_tx == 1)begin
				sendcounter <= sendcounter + 1;
				case(sendcounter)
					8'd0: i_Tx_Byte <= 8'd13;
					8'd1: i_Tx_Byte <= 8'd10;
          8'd2: i_Tx_Byte <= 8'd68;
					8'd3: i_Tx_Byte <= 8'd65;
					8'd4: i_Tx_Byte <= cfg_data_reply[0:7]+8'd48;
					8'd5: i_Tx_Byte <= (cfg_data_reply[8:14] & 8'hff)+8'd48;
					8'd6: i_Tx_Byte <= 8'd13;
					8'd7: i_Tx_Byte <= 8'd10;
					default : begin
						 i_Tx_Byte <= 8'd42;
						 sendcounter <= 0;
					end
				endcase

				if(capture_done)begin
					 sendcounter <= 0;
					 i_Tx_Byte <= (byte_stream[register_counter_data]>>dbg_8bitslicer) & 8'hf;
           //shifting works like this e.g.: 48 bit long ... highes diget 47
           //only 8 top bits 48-8 right shift .... next 48-(2*8)
           dbg_8bitslicer <= dbg_8bitslicer - 16'd8;
				end
				if(dbg_8bitslicer == BUFFER_REG_LENGTH/8)begin //64 times   512/8
					dbg_8bitslicer <= 0;
				end

				if(!lighthouse_detected)begin
					 sendcounter <= 0;
					 dbg_8bitslicer <= 0;
					 i_Tx_Byte <= 8'd90;
				end

				waitflag_tx <= 0;
				i_Tx_DV <= 1;
			end

      end
    `endif

endmodule
