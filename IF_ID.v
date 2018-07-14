`timescale 1ns / 1ps
`include "global.v"
module IF_ID(
    input clk,
    input rst,
    input[`AddrBus] addr_i, 
    input[`InstBus] inst_i, 
    output [`AddrBus] addr_o, 
    output [`InstBus] inst_o
    );
    PiplineDeliver#(`AddrBusWidth) ff_addr(clk, rst, addr_i, addr_o); 
    PiplineDeliver#(`InstBusWidth) ff_inst(clk, rst, inst_i, inst_o);
endmodule
