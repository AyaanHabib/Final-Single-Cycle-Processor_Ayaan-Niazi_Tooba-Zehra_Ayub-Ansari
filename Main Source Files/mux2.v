`timescale 1ns / 1ps
module mux2(
    input [31:0] in0, // First Input. this is readdata2 output from rs2
    input [31:0] in1, // Second input. this is the immediate value from immgen
    input sel,// Selection bit
    output [31:0] out // Output
);

assign out=sel ? in1 : in0; // If selection bit is 0, choose input 0, else choose input 1

endmodule
