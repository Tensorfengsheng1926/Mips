`timescale 1ns / 1ps
`include "global.v"
module MEM(
    input rst,
    input [31:0] data_in,
    input reg_write_en_in,
    input [4:0] reg_addr_in,
    output [31:0] data_out,
    output reg_write_en_out,
    output [4:0] reg_addr_out
    );
    assign data_out=(rst==`RstEnable)?32'h0:data_in;
    assign reg_write_en_out=(rst==`RstEnable)?0:reg_write_en_in;
    assign reg_addr_out=(rst==`RstEnable)?5'h0:reg_addr_in;
endmodule
