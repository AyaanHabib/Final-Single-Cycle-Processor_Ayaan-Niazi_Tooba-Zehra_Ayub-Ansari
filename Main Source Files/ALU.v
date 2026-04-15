`timescale 1ns / 1ps
module ALU(
    input wire [31:0] A,
    input wire [31:0] B,
    input wire [3:0] ALUControl,
    output reg [31:0] ALUResult,
    output wire Zero
);

    assign Zero=(ALUResult==32'b0);
    always @(*) begin
        case (ALUControl)
            4'b0000: ALUResult=A&B; //And
            4'b0001: ALUResult=A|B; //Or
            4'b0011: ALUResult=A^B; //Xor
            4'b0010: ALUResult=A+B; //Add
            4'b0110: ALUResult=A-B; //Sub
            4'b0100: ALUResult=A<<B[4:0]; //Sll
            4'b0101: ALUResult=A>>B[4:0]; //Srl
            4'b1111: ALUResult=B; //Lui
            default: ALUResult=32'b0; //Zero case
        endcase
    end
endmodule
