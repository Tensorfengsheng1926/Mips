`timescale 1ns / 1ps
`include "global.v" 
`include "funct_def.v" 

module EX( 
    input rst, 
    input[5:0] funct, 
    input[`DataBus] operand_1, 
    input[`DataBus] operand_2, 
    input[4:0] shamt, 
    input write_reg_en_in, 
    input[`RegAddrBus] write_reg_addr_in, 
    output[`DataBus] result_out, 
    output write_reg_en_out, 
    output[`RegAddrBus] write_reg_addr_out 
); 
// 这两个信号直接传递出去 
    assign write_reg_addr_out = (rst ? 0 : write_reg_addr_in); 
    assign write_reg_en_out = (rst ? 0: write_reg_en_in); 
    reg[`DataBus] result; 
    assign result_out = (rst ? 0 : result); 
    
    always@(*) begin 
        case (funct) 
        `FUNCT_OR: result <= (operand_1 | operand_2); 
        `FUNCT_ADDU:result <= operand_1 + operand_2;
        `FUNCT_SUBU:result <= operand_1 - operand_2;//+((~operand_2)+1)
        `FUNCT_SLLV:result <= operand_2 << operand_1[4:0];
        `FUNCT_SRLV:result <= operand_2 >> operand_1[4:0];
        //算术右移，空位用rs[31]补
        `FUNCT_SRAV:result <= ({32{operand_2[31]}} << (6'd32-{1'b0, operand_1[4:0]})) | operand_2 >> operand_1[4:0];
        default: begin 
        result <= 0; 
        end 
        endcase 
    end 
endmodule 