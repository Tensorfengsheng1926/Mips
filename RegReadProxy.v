`timescale 1ns / 1ps

module RegReadProxy(
    //ID
    input read_en_1,
    input read_en_2,
    input [4:0] read_addr_1,
    input [4:0] read_addr_2,
    //EX
    input [31:0] data_from_ex,
    input reg_write_en_from_ex,
    input [4:0] reg_write_addr_from_ex,
    //MEM
    input [31:0] data_from_mem,
    input reg_write_en_from_mem,
    input [4:0] reg_write_addr_from_mem,
    //RegFileµÄread_data
    input [31:0] data_1_from_reg,
    input [31:0] data_2_from_reg,
    //IDµÄ read_data_1 ºÍ read_data_2
    output reg[31:0] read_data_1,
    output reg[31:0] read_data_2
    );
    always@(*)begin
        if(read_en_1) begin
            if(reg_write_en_from_ex&&(reg_write_addr_from_ex==read_addr_1))
                read_data_1<=reg_write_addr_from_ex;
            else if(reg_write_en_from_mem&&(reg_write_addr_from_mem==read_addr_1))
                read_data_1<=reg_write_addr_from_mem;
            else
                read_data_1<=data_1_from_reg;
        end
        else
            read_data_1<=32'h0;
    end
    always@(*)begin
        if(read_en_2) begin
            if(reg_write_en_from_ex&&(reg_write_addr_from_ex==read_addr_2))
                read_data_2<=reg_write_addr_from_ex;
            else if(reg_write_en_from_mem&&(reg_write_addr_from_mem==read_addr_2))
                read_data_2<=reg_write_addr_from_mem;
            else
                read_data_2<=data_2_from_reg;
        end
        else
            read_data_1<=32'h0;
    end
endmodule
