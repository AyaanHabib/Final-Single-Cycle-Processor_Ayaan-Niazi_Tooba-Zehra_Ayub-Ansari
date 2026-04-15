`timescale 1ns / 1ps
module switches(
    input clk,
    input rst,
    input [15:0] switches_in,
    output [31:0] switches_out
);

assign switches_out={16'b0, switches_in}; //switch values are zero extended

endmodule
