`timescale 1ns / 1ps

module MEM_WB(
    input clk,
    input rst,
    input [31:0] data_in,
    input reg_write_en_in,
    input [4:0] reg_addr_in,
    output [31:0] data_out,
    output reg_write_en_out,
    output [4:0] reg_addr_out
    );
    PiplineDeliver#(32) ff_data(clk,rst,data_in,data_out);
    PiplineDeliver#(1) ff_reg_write_en(clk,rst,reg_write_en_in,reg_write_en_out);
    PiplineDeliver#(5) ff_addr(clk,rst,reg_addr_in,reg_addr_out);

endmodule
