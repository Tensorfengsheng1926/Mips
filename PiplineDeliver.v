`timescale 1ns / 1ps
`include "global.v"

module PiplineDeliver
#( 
     parameter width = 32 
)
(
    input clk,
    input rst,
    input [31:0] bus_in,
    output reg [31:0] bus_out
    );
    reg[width-1:0] bus_reg;
    always@(posedge clk)
    begin
    if(rst == `RstEnable)
    bus_out<=32'h0;
    else
    bus_out<=bus_in;
    end
endmodule
