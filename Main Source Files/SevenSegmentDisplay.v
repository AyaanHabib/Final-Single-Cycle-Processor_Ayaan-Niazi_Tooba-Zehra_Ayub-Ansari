`timescale 1ns / 1ps
module SevenSegmentDisplay(
    input clk,
    input rst,
    input [15:0] num,
    output wire [6:0] seg,
    output reg [3:0] an
);

wire [3:0] d3=(num/1000)%10; //conversion to BCD from binary
wire [3:0] d2=(num/100)%10;
wire [3:0] d1=(num/10)%10;
wire [3:0] d0=num%10;

reg [16:0] cnt;
always @(posedge clk or posedge rst) begin
    if (rst) cnt<=0;
    else cnt<=cnt+1; //counter increments every clock cycle 
end

wire [1:0] sel=cnt[16:15]; //sel constantly cycles through values

reg [3:0] digit;
always @(*) begin
    case (sel) //multiplexing 
        2'd0: begin an=4'b1110; digit=d0; end //digit 1
        2'd1: begin an=4'b1101; digit=d1; end //digit 2
        2'd2: begin an=4'b1011; digit=d2; end //digit 3
        2'd3: begin an=4'b0111; digit=d3; end //digit 4
    endcase
end

SevenSegment u_seg(.d(digit), .s(seg)); //converts our BCD digit to 7-segment output for each segment a-g

endmodule