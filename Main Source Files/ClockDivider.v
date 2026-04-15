`timescale 1ns / 1ps
`timescale 1ns / 1ps

module ClockDivider #(
    parameter DIVIDE_BY = 10_000_000  //default: 10 Hz output from 100 MHz input
)(
    input  clk_in,   //100 MHz board clock
    input  rst,
    output reg clk_out
);

integer counter;

always @(posedge clk_in or posedge rst) begin
    if (rst) begin
        counter <= 0;
        clk_out <= 0;
    end else begin
        if (counter >= (DIVIDE_BY/2) - 1) begin
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
    end
end

endmodule