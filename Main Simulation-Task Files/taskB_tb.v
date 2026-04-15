`timescale 1ns / 1ps
// Task B: LUI, ORI, JAL demo
// Load taskB_sim.mem as Program.mem
// LUI x1,5    -> x1=20480
// ORI x2,x1,7 -> x2=20487
// JAL x3,tgt  -> x3=PC+4=0x3C=60
module taskB_tb;

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
    #200;

    // LUI: x1=5<<12=20480
    if (sseg_val===16'd20480 && leds===16'd20480)
        $display("PASS: LUI sseg=leds=20480");
    else begin
        $display("FAIL: LUI expected=20480 sseg=%0d leds=%0d",sseg_val,leds);
        errors=errors+1;
    end

    // delay=10 cycles x 10ns + ~3 instrs = ~130ns per step
    #300;

    // ORI: 20480|7=20487
    if (sseg_val===16'd20487 && leds===16'd20487)
        $display("PASS: ORI sseg=leds=20487");
    else begin
        $display("FAIL: ORI expected=20487 sseg=%0d leds=%0d",sseg_val,leds);
        errors=errors+1;
    end

    #300;

    // JAL: x3=PC+4, JAL at word 14 PC=0x38, so x3=0x3C=60
    if (sseg_val===16'd60 && leds===16'd60)
        $display("PASS: JAL sseg=leds=60 (PC+4=0x3C)");
    else begin
        $display("FAIL: JAL expected=60 sseg=%0d leds=%0d",sseg_val,leds);
        errors=errors+1;
    end

    #200;
    if (errors==0) $display("ALL PASS");
    else $display("%0d FAILURES",errors);
    $stop;
end

initial $monitor("t=%0t sseg=%0d leds=%0d",$time,sseg_val,leds);

endmodule
