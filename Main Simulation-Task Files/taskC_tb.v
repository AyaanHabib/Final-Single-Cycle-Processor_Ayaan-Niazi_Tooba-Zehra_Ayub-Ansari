`timescale 1ns / 1ps
// Task C: fibonacci with JAL/JALR procedure call
// fib(12)=144, fib(6)=8, result=fib(12)+fib(6)=152
// Uses taskC.mem as Program.mem
module taskC_tb;

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

    // fib needs ~43 instructions + loop iterations
    // fib(12): 12 iterations x ~9 instrs = ~108 instrs
    // fib(6):  6 iterations  x ~9 instrs = ~54  instrs
    // total ~200 instrs = ~2000ns, give margin
    #5000;

    if (sseg_val===16'd152 && leds===16'd152)
        $display("PASS: fib(12)+fib(6)=144+8=152 sseg=%0d leds=%0d",sseg_val,leds);
    else begin
        $display("FAIL: expected=152 sseg=%0d leds=%0d",sseg_val,leds);
        errors=errors+1;
    end

    #200;
    if (errors==0) $display("ALL PASS");
    else $display("%0d FAILURES",errors);
    $stop;
end

initial $monitor("t=%0t sseg=%0d leds=%0d",$time,sseg_val,leds);

endmodule
