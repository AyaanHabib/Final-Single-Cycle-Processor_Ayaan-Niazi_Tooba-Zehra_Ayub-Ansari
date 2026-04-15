`timescale 1ns / 1ps
module instructionMemory(
    input [31:0] addr, // Instrcution to read
    output [31:0] instruction // Instr tuoon accessed at the address provided
);
(* rom_style = "distributed" *) reg [31:0] memory [0:255]; // Creates an array with 256 locations, each location holds 32 bits, allows for 32 bit instructions

integer i;
initial begin
    for (i = 0; i < 256; i = i + 1) // Looping throuhg each memory location
        memory[i] = 32'b0; // Each instruction is set to 0 initially to prevent garbage values being fetched 
    $readmemh("TaskC.mem", memory); // Loading instructions from a file into memory
end

assign instruction=memory[addr[9:2]]; // Gives the instruction index by dividing the address by 4

endmodule