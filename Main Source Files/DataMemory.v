`timescale 1ns / 1ps

module DataMemory(
    input clk,
    input MemWrite,
    input MemRead,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data
);

reg [31:0] memory [0:255];

wire [7:0] word_addr=address[9:2];

always @(posedge clk) begin
    if (MemWrite)
        memory[word_addr]<=write_data;
end

assign read_data=memory[word_addr];

endmodule
