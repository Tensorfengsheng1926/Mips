`timescale 1ns / 1ps
`include "global.v"
module RegFile(
    input clk,
    input rst,
    input read_en_1,
    input [4:0] read_addr_1,
    output reg [31:0] read_data_1,
    input read_en_2,
    input [4:0] read_addr_2,
    output reg [31:0] read_data_2,
    input write_en,
    input [4:0] write_addr,
    input [31:0] write_data
    );
    reg[31:0] regs[0:31];
    	always @ (posedge clk) begin
        if (rst == `RstDisable) begin
            if(write_en && (write_addr != 5'h0)) begin
                regs[write_addr] <= write_data;
            end
        end
    end
    
    always @ (*) begin
        if(rst == `RstEnable) begin
              read_data_1 <= 32'h0;
      end else if(read_addr_1 == 5'h0) begin
              read_data_1 <= 32'h0;
      end else if((read_addr_1 == write_addr) && write_en && read_en_1) begin
            read_data_1 <= write_data;
      end else if(read_en_1) begin
          read_data_1 <= regs[read_addr_1];
      end else begin
          read_data_1 <= 32'h0;
      end
    end

    always @ (*) begin
        if(rst == `RstEnable) begin
              read_data_2 <= 32'h0;
      end else if(read_addr_2 ==  5'h0) begin
              read_data_2 <= 32'h0;
      end else if((read_addr_2 == write_addr) && write_en && read_en_2) begin
            read_data_2 <= write_data;
      end else if(read_en_2) begin
          read_data_2 <= regs[read_addr_2];
      end else begin
          read_data_2 <= 32'h0;
      end
    end
endmodule
