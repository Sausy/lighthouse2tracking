module ascii_conv(
    input clock,  // clock
    input reset,  // reset

    output [7:0] hex_value [15:0]
  );

  //reg [7:0] hex_value [0:7];

  always @(posedge clock, posedge reset) begin: set_transit_state_pin
    if(reset)begin
        hex_value[4'b0000] <= 8'd48;//57
        hex_value[4'b0001] <= 8'd49;
        hex_value[4'b0010] <= 8'd50;
        hex_value[4'b0011] <= 8'd51;
        hex_value[4'b0100] <= 8'd52;
        hex_value[4'b0101] <= 8'd53;
        hex_value[4'b0110] <= 8'd54;
        hex_value[4'b0111] <= 8'd55;
        hex_value[4'b1000] <= 8'd56;
        hex_value[4'b1001] <= 8'd57;
        hex_value[4'b1010] <= 8'd65;
        hex_value[4'b1011] <= 8'd66;
        hex_value[4'b1100] <= 8'd67;
        hex_value[4'b1101] <= 8'd68;
        hex_value[4'b1110] <= 8'd69;
        hex_value[4'b1111] <= 8'd70;
    end else begin
    end
  end

  endmodule
