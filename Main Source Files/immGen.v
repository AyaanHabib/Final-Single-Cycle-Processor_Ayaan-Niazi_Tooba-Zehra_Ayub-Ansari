`timescale 1ns / 1ps

module immGen(
    input [31:0] instruction,
    output reg [31:0] imm
);
    wire [6:0] opcode=instruction[6:0];

    always @(*) begin
        case (opcode)
            7'b0000011, //I-type: lw
            7'b0010011, //I-type: addi and more
            7'b1100111: //J-type: jalr
                imm={{20{instruction[31]}}, instruction[31:20]};

            7'b0100011: //S-type: sw
                imm={{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

            7'b1100011: //B-type: beq 
                imm={{20{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};

            7'b0110111: // U-type: Lui
                imm={instruction[31:12], 12'b0};

            7'b1101111: // J-type: Jal
                imm={{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21]};

            default:
                imm=32'b0;
        endcase
    end
endmodule
