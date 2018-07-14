`timescale 1ns / 1ps
`include "global.v"
`include "op_def.v"
`include "funct_def.v"
module ID(
    input rst,
    input [31:0] addr,
    input [31:0] inst,
    input [31:0] reg_data_1,
    input [31:0] reg_data_2,
    output reg reg_read_en_1,
    output reg reg_read_en_2,
    output reg[4:0] reg_addr_1,
    output reg[4:0] reg_addr_2,
    output reg[5:0] funct,
    output reg[31:0] operand_1,
    output reg[31:0] operand_2,
    output reg[4:0] shamt,
    output reg write_reg_en,
    output reg[4:0] write_reg_addr
    );
    ////ID 模块：处理 RegFile 的信号 ////
    /////////////////////////////////////
    wire[`InstOpBus] inst_op            = inst[31:26]; 
    wire[`RegAddrBus] inst_rs           = inst[25:21]; 
    wire[`RegAddrBus] inst_rt           = inst[20:16];
    
    always@(*) begin
    if(rst == `RstEnable) begin
        reg_read_en_1<=0;
        reg_read_en_2 <= 0; 
        reg_addr_1 <= 0; 
        reg_addr_2 <= 0; 
    end
    else case(inst_op)
        `OP_ORI:begin
            reg_read_en_1<=1;
            reg_read_en_2<=0;
            reg_addr_1<=inst_rs;
            reg_addr_2<=0;
        end
        `OP_SPECIAL: begin
            reg_read_en_1 <= 1; 
            reg_read_en_2 <= 1; 
            reg_addr_1 <= inst_rs; 
            reg_addr_2 <= inst_rt; 
        end
        default: begin 
        // 默认情况下不读寄存器 
            reg_read_en_1 <= 0; 
            reg_read_en_2 <= 0; 
            reg_addr_1 <= 0; 
            reg_addr_2 <= 0; 
        end         
    endcase 
    end
    
    ////ID 模块：处理 EX 的操作码  ////
    ///////////////////////////////////
    wire[5:0] inst_funct = inst[5:0];
    always@(*) case(inst_op)
        `OP_SPECIAL:funct<=inst_funct;
        `OP_ORI:funct<=`FUNCT_OR;
        default: funct <= `FUNCT_NOP;
    endcase

    ////ID 模块：处理 EX 的操作数  ////
    ///////////////////////////////////
    // handle operand_1
    always@(*) begin
    if(rst == `RstEnable) operand_1<=0;
    else case(inst_op)
        `OP_ORI: operand_1 <= reg_data_1; 
        `OP_SPECIAL: operand_1 <= reg_data_1; 
        default: operand_1 <= 0; 
    endcase 
    end
    // handle operand_2
    wire[15:0] inst_imm                 = inst[15: 0];//立即数
    wire[31:0] zero_extended_imm        = {16'b0, inst_imm}; //立即数扩0
    always@(*) begin 
    if(rst) operand_2 <= 0; 
    else case(inst_op) 
        `OP_ORI: operand_2 <= zero_extended_imm;
        `OP_SPECIAL: operand_2 <= reg_data_2; 
        default: operand_2 <= 0; 
    endcase 
    end
    ////ID 模块：处理 SHAMT  ////
    /////////////////////////////
    always@(*) begin
    if(inst_op==`OP_SPECIAL)
        shamt<=inst[10:6];
    else
        shamt<=5'h0;
    end
    
    ////ID 模块：处理 WB 的写寄存器信号与地址  ////
    ///////////////////////////////////////////////
    wire[4:0] inst_rd=inst[15:11];
    always@(*) begin
    if(rst == `RstEnable) begin
        write_reg_en <= 0;
        write_reg_addr<=5'b0;
    end
    else case(inst_op)
        `OP_SPECIAL:begin
        write_reg_en <= 1;
        write_reg_addr<=inst_rd;
        end
        `OP_ORI:begin
        write_reg_en <= 1;
        write_reg_addr<=inst_rt;
        end
        default:begin
        write_reg_en <= 0;
        write_reg_addr<=5'b0;
        end
    endcase
    end
endmodule
