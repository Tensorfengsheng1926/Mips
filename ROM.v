`timescale 1ns / 1ps
`include "global.v"
module ROM(
    input en,
    input[`AddrBus] addr,
    output[`InstBus] inst
    );
    // д�� 8 λһ������Ϊ 
    // objcopy �� verilog �����ʽ������ 
    // 512=2^9��512B ��С��2^7=128 ��ָ�� 
    // ���Ƕ�����"��װ"�������� 2^32B=4GB �ռ�
    reg[7:0] rom[0:511];
    // ���ļ���ȡ���̼���
    initial $readmemh("F:/jz/Design/CPU/inst_rom.bin", rom);
    // MIPS �Ǵ�ˣ��͵�ַ��Ÿ�λ 
    // ���� add �����λʵ���ǲ���Ҫ�ģ�4 �ֽڶ��룩
    // ���Ǳ��������Ա�¶Ǳ�ڵ� bug
    assign inst[ 7: 0] = (en ? rom[addr + 3] : 8'b0);
    assign inst[15: 8] = (en ? rom[addr + 2] : 8'b0); 
    assign inst[23:16] = (en ? rom[addr + 1] : 8'b0); 
    assign inst[31:24] = (en ? rom[addr + 0] : 8'b0);
endmodule
