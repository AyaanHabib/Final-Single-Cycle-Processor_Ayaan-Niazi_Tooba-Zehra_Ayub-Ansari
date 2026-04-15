`timescale 1ns / 1ps
// Task A: countdown 10->0
// Load taskA_sim.mem as Program.mem before simulating
module taskA_tb;

reg clk;
reg rst;
reg [15:0] switches;
wire [15:0] leds;
wire [15:0] sseg_val;

TopLevelProcessor uut(
    .clk(clk),
    .rst(rst),
    .switches(switches),
    .leds(leds),
    .sseg_val(sseg_val)
);

initial clk=0;
always #5 clk=~clk;

integer errors=0;

initial begin
    rst=1;
    switches=16'd0;
    #20;
    rst=0;
    #200; // let init run

    // each count step: 10 delay cycles x 10ns + ~5 instrs = ~150ns
    // check every 300ns
    if (sseg_val===16'd10) $display("PASS: count=10");
    else begin $display("FAIL: expected=10 got=%0d",sseg_val); errors=errors+1; end

    #300;
    if (sseg_val===16'd9) $display("PASS: count=9");
    else begin $display("FAIL: expected=9 got=%0d",sseg_val); errors=errors+1; end

    #300;
    if (sseg_val===16'd8) $display("PASS: count=8");
    else begin $display("FAIL: expected=8 got=%0d",sseg_val); errors=errors+1; end

    #300;
    if (sseg_val===16'd7) $display("PASS: count=7");
    else begin $display("FAIL: expected=7 got=%0d",sseg_val); errors=errors+1; end

    #300;
    if (sseg_val===16'd6) $display("PASS: count=6");
    else begin $display("FAIL: expected=6 got=%0d",sseg_val); errors=errors+1; end

    #300;
    if (sseg_val===16'd5) $display("PASS: count=5");
    else begin $display("FAIL: expected=5 got=%0d",sseg_val); errors=errors+1; end

    #300;
    if (sseg_val===16'd4) $display("PASS: count=4");
    else begin $display("FAIL: expected=4 got=%0d",sseg_val); errors=errors+1; end

    #300;
    if (sseg_val===16'd3) $display("PASS: count=3");
    else begin $display("FAIL: expected=3 got=%0d",sseg_val); errors=errors+1; end

    #300;
    if (sseg_val===16'd2) $display("PASS: count=2");
    else begin $display("FAIL: expected=2 got=%0d",sseg_val); errors=errors+1; end

    #300;
    if (sseg_val===16'd1) $display("PASS: count=1");
    else begin $display("FAIL: expected=1 got=%0d",sseg_val); errors=errors+1; end

    #300;
    if (sseg_val===16'd0) $display("PASS: count=0");
    else begin $display("FAIL: expected=0 got=%0d",sseg_val); errors=errors+1; end

    #200;
    if (errors==0) $display("ALL PASS");
    else $display("%0d FAILURES",errors);
    $stop;
end

initial $monitor("t=%0t sseg=%0d leds=%0d",$time,sseg_val,leds);

endmodule
