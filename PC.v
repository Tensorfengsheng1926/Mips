`timescale 1ns / 1ps
`include "global.v"
module PC(
    input clk,
    input rst,
    output reg rom_en,
    output reg [31:0] addr
    );
    always@(posedge clk)
        rom_en <= !rst; 

    always@(posedge clk) begin 
    // ���ﲻ���ж� rst������ rom_en 
        if (!rom_en) 
        addr <= `AddrBusWidth'b0; 
        else 
        addr <= addr + 4; 
    end
endmodule
