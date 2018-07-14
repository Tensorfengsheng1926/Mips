`timescale 1ns / 1ps
`include "global.v"
module ROM(
    input en,
    input[`AddrBus] addr,
    output[`InstBus] inst
    );
    // 写成 8 位一组是因为 
    // objcopy 的 verilog 输出格式是这样 
    // 512=2^9，512B 大小，2^7=128 条指令 
    // 但是对外则"假装"有完整的 2^32B=4GB 空间
    reg[7:0] rom[0:511];
    // 从文件读取“固件”
    initial $readmemh("F:/jz/Design/CPU/inst_rom.bin", rom);
    // MIPS 是大端，低地址存放高位 
    // 这里 add 最后两位实际是不需要的（4 字节对齐）
    // 但是保留它可以暴露潜在的 bug
    assign inst[ 7: 0] = (en ? rom[addr + 3] : 8'b0);
    assign inst[15: 8] = (en ? rom[addr + 2] : 8'b0); 
    assign inst[23:16] = (en ? rom[addr + 1] : 8'b0); 
    assign inst[31:24] = (en ? rom[addr + 0] : 8'b0);
endmodule
