`timescale 1ns/1ps
module RegisterFile(
    input clk,
    input rst,
    input WriteEnable,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);

reg [31:0] registers[31:0]; 
integer i;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        for(i=0;i<32;i=i+1)
            registers[i]<=32'b0; //all registers set to 0
    end
    else if(WriteEnable&&rd!=5'b00000) begin //ensure rd is not hardwired x0 and write enable high
        registers[rd]<=WriteData; //destination register written to on clk pulse
    end
end

assign ReadData1=(rs1==5'b00000)?32'b0:registers[rs1]; //data is read asynchronously
assign ReadData2=(rs2==5'b00000)?32'b0:registers[rs2];

endmodule
