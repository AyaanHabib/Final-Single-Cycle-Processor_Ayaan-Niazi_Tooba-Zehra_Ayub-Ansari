`timescale 1ns / 1ps
module FPGATop(
    input clk_100mhz,
    input rst,
    input [15:0] switches,
    output [15:0] leds,
    output [6:0] seg,
    output [3:0] an
);

wire slow_clk;
wire [15:0] sseg_val;
//Task A and B: DIVIDE_BY=50_000_000 (2Hz, 0.5s per step)
//Task C: DIVIDE_BY=100 (1MHz, result appears instantly)
ClockDivider #(.DIVIDE_BY(50_000_000)) u_clkdiv(
    .clk_in(clk_100mhz),
    .rst(rst),
    .clk_out(slow_clk)
);

TopLevelProcessor u_proc(
    .clk(slow_clk),
    .rst(rst),
    .switches(switches),
    .leds(leds),
    .sseg_val(sseg_val)
);

SevenSegmentDisplay u_display(
    .clk(clk_100mhz),
    .rst(rst),
    .num(sseg_val),
    .seg(seg),
    .an(an)
);

endmodule
