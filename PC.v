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
    // 这里不是判断 rst，而是 rom_en 
        if (!rom_en) 
        addr <= `AddrBusWidth'b0; 
        else 
        addr <= addr + 4; 
    end
endmodule
