`timescale 1ns / 1ps
module pcAdder(
    input [31:0] pc,  // Curent program counter value
    output [31:0] pc_plus4 // Next instruction address
);

assign pc_plus4=pc+32'd4; // Increments to the next instruction by adading 4 to the current program counter

endmodule
