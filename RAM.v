`timescale 1ns / 1ps
`include "global.v"
module RAM(
    input clk,
    input rst,
    input enable,//整体的使能信号 
    input write_en,//写使能信号
    input [3:0] write_sel,//要写入哪些字节的标志 
    input [`AddrBus] addr,//输入地址，严格按照 4 字节对齐 
    input [`DataBus] data_in,
    output [`DataBus] data_out
    );
    reg[7:0] data_mem0[0:511];
    reg[7:0] data_mem1[0:511];
    reg[7:0] data_mem2[0:511];
    reg[7:0] data_mem3[0:511];
    //TODO: 输出改成reg
    always @ (posedge clk)
    begin
        if(rst == `RstEnable)
        begin
            {data_mem3[addr + 0], data_mem3[addr + 1], data_mem3[addr + 2], data_mem3[addr + 3]}<=8'b0;
            {data_mem2[addr + 0], data_mem2[addr + 1], data_mem2[addr + 2], data_mem2[addr + 3]}<=8'b0;
            {data_mem1[addr + 0], data_mem1[addr + 1], data_mem1[addr + 2], data_mem1[addr + 3]}<=8'b0;
            {data_mem0[addr + 0], data_mem0[addr + 1], data_mem0[addr + 2], data_mem0[addr + 3]}<=8'b0;
        end
        else
        begin
            if(!enable) begin end
            else if(write_en)
            begin
                if(write_sel[3]==1'b1) {data_mem3[addr + 0], data_mem3[addr + 1], data_mem3[addr + 2], data_mem3[addr + 3]}<=data_in[31:24];
                if(write_sel[2]==1'b1) {data_mem2[addr + 0], data_mem2[addr + 1], data_mem2[addr + 2], data_mem2[addr + 3]}<=data_in[23:16];
                if(write_sel[1]==1'b1) {data_mem1[addr + 0], data_mem1[addr + 1], data_mem1[addr + 2], data_mem1[addr + 3]}<=data_in[15:8];
                if(write_sel[0]==1'b1) {data_mem0[addr + 0], data_mem0[addr + 1], data_mem0[addr + 2], data_mem0[addr + 3]}<=data_in[7:0];
            end
        end
    end
    
    assign data_out[ 7: 0] = (enable ? (write_en ? 8'b0 : {data_mem0[addr + 0], data_mem0[addr + 1], data_mem0[addr + 2], data_mem0[addr + 3]}) : 8'b0);
    assign data_out[15: 8] = (enable ? (write_en ? 8'b0 : {data_mem1[addr + 0], data_mem1[addr + 1], data_mem1[addr + 2], data_mem1[addr + 3]}) : 8'b0);
    assign data_out[23:16] = (enable ? (write_en ? 8'b0 : {data_mem2[addr + 0], data_mem2[addr + 1], data_mem2[addr + 2], data_mem2[addr + 3]}) : 8'b0);
    assign data_out[31:24] = (enable ? (write_en ? 8'b0 : {data_mem3[addr + 0], data_mem3[addr + 1], data_mem3[addr + 2], data_mem3[addr + 3]}) : 8'b0);
    
endmodule
