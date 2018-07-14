`timescale 1ns / 1ps
module ID_EX(
    input clk,
    input rst,
    input [5:0] funct_in,
    input [31:0] operand_1_in,
    input [31:0] operand_2_in,
    input [4:0] shamt_in,
    input write_reg_en_in,
    input [4:0] write_reg_addr_in,
    output [5:0] funct_out,
    output [31:0] operand_1_out,
    output [31:0] operand_2_out,
    output [4:0] shamt_out,
    output write_reg_en_out,
    output [4:0] write_reg_addr_out
    );
    PiplineDeliver#(6) ff_funct(clk,rst,funct_in,funct_out);
    PiplineDeliver#(32) ff_operand_1(clk,rst,operand_1_in,operand_1_out);
    PiplineDeliver#(32) ff_operand_2(clk,rst,operand_2_in,operand_2_out);
    PiplineDeliver#(5) ff_shamt(clk,rst,shamt_in,shamt_out);
    PiplineDeliver#(1) ff_write_reg_en(clk,rst,write_reg_addr_in,write_reg_addr_out);
    PiplineDeliver#(5) ff_write_reg_addr(clk,rst,write_reg_addr_in,write_reg_addr_out);
endmodule
