`timescale 1ns / 1ps

module sseg(
    input clk,
    input rst,
    input we, //write enable
    input [31:0] data_in,
    output reg [15:0] sseg_out
);

always @(posedge clk or posedge rst) begin
    if (rst)
        sseg_out<=16'b0; //output cleared to 0
    else if (we) //data saved only if write enable is high
        sseg_out<=data_in[15:0];
end

endmodule