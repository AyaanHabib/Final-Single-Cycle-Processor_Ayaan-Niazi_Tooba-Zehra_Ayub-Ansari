`timescale 1ns / 1ps
module AddressDecoder(
    input [31:0] address,
    input MemWrite,
    input MemRead,
    output DataMemWrite,
    output DataMemRead,
    output LEDWrite,
    output SwitchReadEnable,
    output SSEGWrite
);
    wire [1:0] dev=address[9:8]; //used for selecing which device we will use

    assign DataMemWrite=(dev==2'b00) & MemWrite; //if the address in the variable device is 00 and memwrite is 1, Datamemwrite=1
    assign DataMemRead=(dev==2'b00) & MemRead; //if the address in the variable device is 00 and memread is 1, Datamemread=1
    assign LEDWrite=(dev==2'b01) & MemWrite; //if the address in the variable device is 01 and memwrite is 1, LEDwrite is 1
    assign SwitchReadEnable=(dev==2'b10) & MemRead; //if the address in the variable device is 10 and memread is 1, SwitchReadEnable is 1
    assign SSEGWrite=(dev==2'b11) & MemWrite; //if the address in the variable device is 11 and memwrite is 1, SSEGWrite is 1


    //Notes to add in the report,
    //Only one device is enabled at any time, preventing bus contention and ensuring correct routing of data.
 

    

endmodule