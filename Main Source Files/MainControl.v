`timescale 1ns / 1ps
module MainControl(
    input [6:0] opcode, // Instruction opcode that tells the type of instruction
    output reg RegWrite, 
    output reg ALUSrc,   
    output reg MemRead, 
    output reg MemWrite, 
    output reg MemtoReg,
    output reg Branch,   
    output reg Jump,      
    output reg JumpReg,   
    output reg WriteRA,   
    output reg [1:0] ALUOp
);
    always @(*) begin  //All control signals resetted to default before decoding instruction
        RegWrite=0; ALUSrc=0; MemRead=0;
        MemWrite=0; MemtoReg=0; Branch=0;
        Jump=0; JumpReg=0; WriteRA=0;
        ALUOp=2'b00;

        case (opcode)
            7'b0110011: begin // Control signals for a R type instrcution, Uses two registers, perform ALU operation, write result back
                RegWrite=1; ALUSrc=0; ALUOp=2'b10;
            end
            7'b0010011: begin // Control signals for an I type instrcution
                RegWrite=1; ALUSrc=1; ALUOp=2'b10;
            end
            7'b0000011: begin // Control signals for a load instrcution, Reads data from memory and store it in register
                RegWrite=1; ALUSrc=1; MemRead=1; MemtoReg=1; ALUOp=2'b00;
            end
            7'b0100011: begin // Control signals for a store instrcution, writes register data into memory
                ALUSrc=1; MemWrite=1; ALUOp=2'b00;
            end
            7'b1100011: begin // Control signals for an branch instrcution, compares values and decides whether to jump to target 
                Branch=1; ALUOp=2'b01;
            end
            7'b0110111: begin // Control signal for lui
                RegWrite=1; ALUSrc=1; ALUOp=2'b11;
            end
            7'b1101111: begin // Control Signal for JAL, jumps to target address and saves the return address
                RegWrite=1; // Writes return address to register
                Jump=1; // Jumps to targetr address
                WriteRA=1; // Stores PC+4 as return address
            end
            7'b1100111: begin // Control Singal for JALR, jumps using register and immediate and saves the return address
                RegWrite=1; // Writes return address to register
                ALUSrc=1;   // Allows alu to use immediate for jump calculation
                Jump=1; // Jumps to targetr address
                JumpReg=1; // Jumps using address from register and immediate
                WriteRA=1; // Stores PC+4 as return address
                ALUOp=2'b00; 
            end
            default: begin end
        endcase
    end
endmodule