`timescale 1ns / 1ps
module leds(
    input clk, // Clock
    input rst, // Resetting the leds
    input we, // write enable signal for updating the leds 
    input [31:0] data_in, // Input data to control leds
    output reg [15:0] leds_out // Leds output
);

always @(posedge clk or posedge rst) begin
    if (rst)
        leds_out<=16'b0;  // All leds are turned off when resetted
    else if (we)
        leds_out<=data_in[15:0]; // Leds are only on depending on the write enable signal
end
endmodule
