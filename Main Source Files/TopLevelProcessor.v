`timescale 1ns / 1ps
module TopLevelProcessor(
    input clk,
    input rst,
    input [15:0] switches,
    output [15:0] leds,
    output [15:0] sseg_val
);

wire [31:0] pc;
wire [31:0] pc_plus4;
wire [31:0] pc_next;
wire [31:0] branch_target;
wire [31:0] jalr_target;
wire [31:0] instruction;

wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire MemtoReg;
wire Branch;
wire Jump;
wire JumpReg;
wire WriteRA;
wire [1:0] ALUOp;
wire [3:0] ALUControl_sig;

wire [31:0] ReadData1;
wire [31:0] ReadData2;
wire [31:0] wb_data;
wire [31:0] imm;
wire [31:0] ALU_B;
wire [31:0] ALUResult;
wire Zero;
wire [31:0] mem_read_data;

//branch condition check
wire PCSrc_branch=Branch & (
    (instruction[14:12]==3'b000) ?  Zero : //beq
    (instruction[14:12]==3'b001) ? ~Zero : //bne
    (instruction[14:12]==3'b100) ?  ALUResult[31] : //blt
    1'b0
);

//jal uses branch adder,jalr uses alu result
wire [31:0] jump_target=JumpReg ? (ALUResult & 32'hFFFFFFFE) : branch_target;

assign pc_next=Jump ? jump_target: PCSrc_branch ? branch_target : pc_plus4;

//jal/jalr write pc+4, load writes mem, else alu result
assign wb_data=WriteRA  ? pc_plus4: MemtoReg ? mem_read_data : ALUResult;

assign jalr_target=ALUResult & 32'hFFFFFFFE;

ProgramCounter u_pc(
    .clk(clk),
    .rst(rst),
    .pc_next(pc_next),
    .pc(pc)
);

pcAdder u_pcadder(
    .pc(pc),
    .pc_plus4(pc_plus4)
);

instructionMemory u_imem(
    .addr(pc),
    .instruction(instruction)
);

MainControl u_control(
    .opcode(instruction[6:0]),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .Branch(Branch),
    .Jump(Jump),
    .JumpReg(JumpReg),
    .WriteRA(WriteRA),
    .ALUOp(ALUOp)
);

RegisterFile u_regfile(
    .clk(clk),
    .rst(rst),
    .WriteEnable(RegWrite),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .WriteData(wb_data),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

immGen u_immgen(
    .instruction(instruction),
    .imm(imm)
);

ALUControl u_alucontrol(
    .ALUOp(ALUOp),
    .funct3(instruction[14:12]),
    .funct7(instruction[31:25]),
    .ALUControl(ALUControl_sig)
);

mux2 u_alubmux(
    .in0(ReadData2),
    .in1(imm),
    .sel(ALUSrc),
    .out(ALU_B)
);

ALU u_alu(
    .A(ReadData1),
    .B(ALU_B),
    .ALUControl(ALUControl_sig),
    .ALUResult(ALUResult),
    .Zero(Zero)
);

branchAdder u_branchadder(
    .pc(pc),
    .imm(imm),
    .branch_target(branch_target)
);

addressDecoderTop u_mem(
    .clk(clk),
    .rst(rst),
    .address(ALUResult),
    .readEnable(MemRead),
    .writeEnable(MemWrite),
    .writeData(ReadData2),
    .switches(switches),
    .readData(mem_read_data),
    .leds(leds),
    .sseg_val(sseg_val)
);

endmodule