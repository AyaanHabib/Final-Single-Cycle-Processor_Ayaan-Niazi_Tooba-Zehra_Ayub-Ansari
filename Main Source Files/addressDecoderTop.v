`timescale 1ns / 1ps
module addressDecoderTop(
    input clk,
    input rst,
    input [31:0] address,
    input readEnable,
    input writeEnable,
    input [31:0] writeData,
    input [15:0] switches,
    output [31:0] readData,
    output [15:0] leds,
    output [15:0] sseg_val //value to display on 7-seg
);

wire DataMemWrite;
wire DataMemRead;
wire LEDWrite;
wire SwitchReadEnable;
wire SSEGWrite;

AddressDecoder u_decoder(
    .address(address),
    .MemWrite(writeEnable),
    .MemRead(readEnable),
    .DataMemWrite(DataMemWrite),
    .DataMemRead(DataMemRead),
    .LEDWrite(LEDWrite),
    .SwitchReadEnable(SwitchReadEnable),
    .SSEGWrite(SSEGWrite)
);

wire [31:0] mem_read_data;
DataMemory u_datamem(
    .clk(clk),
    .MemWrite(DataMemWrite),
    .MemRead(DataMemRead),
    .address(address),
    .write_data(writeData),
    .read_data(mem_read_data)
);

wire [31:0] switch_read_data;
switches u_switches(
    .clk(clk),
    .rst(rst),
    .switches_in(switches),
    .switches_out(switch_read_data)
);

leds u_leds(
    .clk(clk),
    .rst(rst),
    .we(LEDWrite),
    .data_in(writeData),
    .leds_out(leds)
);

sseg u_sseg(
    .clk(clk),
    .rst(rst),
    .we(SSEGWrite),
    .data_in(writeData),
    .sseg_out(sseg_val)
);

assign readData=SwitchReadEnable ? switch_read_data : mem_read_data;

endmodule