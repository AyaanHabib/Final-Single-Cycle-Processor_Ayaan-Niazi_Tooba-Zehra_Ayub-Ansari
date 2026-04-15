`timescale 1ns / 1ps
module SevenSegment(
    input [3:0] d,
    output reg [6:0] s
);

always @(*) begin
    case (d)
        4'd0: s=7'b1000000;
        4'd1: s=7'b1111001;
        4'd2: s=7'b0100100;
        4'd3: s=7'b0110000;
        4'd4: s=7'b0011001;
        4'd5: s=7'b0010010;
        4'd6: s=7'b0000010;
        4'd7: s=7'b1111000;
        4'd8: s=7'b0000000;
        4'd9: s=7'b0010000;
        default: s=7'b1111111;
    endcase
end

endmodule
