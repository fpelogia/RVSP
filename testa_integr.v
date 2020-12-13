module testa_integr(clk, dado, inst, rl1out, ula_in2,imed, rl2out,imed_p2muxed, ulares, memout, atualPC,novoPC);
/*
Esse arquivo foi utilizadao no PC2 quando ainda 
nao se tinha a unidade de controle

ele existe apenas como um backup... mas para voltar
a funcionar deve ser atualizado

a Waveform com o mesmo nome deve ser utilizada em conjunto com
o arquivo "testa_unid_controle.v"

Iniciaizacao da mem. instrucoes:
00000000001000001000000010010011 addi x0,x0,2
00000000001000001000000010010011 addi x0,x0,2
00000000001000001000000010010011 addi x0,x0,2
00000000000000001000000010010011 addi x0,x0,0
... e repete a ultima...
*/

input clk;
output[31:0] dado, rl1out,ula_in2;
output [31:0] inst; // carrega a instrucao completa
output [31:0] imed, rl2out,imed_p2muxed, ulares, memout, atualPC,novoPC; 
wire regWrite = 1, ALUSrc = 1, n, z, SeltipoSouB = 0, MemToReg = 0, MemWrite= 1, PCSrc = 0;
wire [3:0] ALUOp = 4'b0000;


gerencia_PC gpc(.clk(clk), .novoPC(novoPC), .atualPC(atualPC));
mem_inst mi(.clk(clk), .ender(atualPC[5:0]), .saida(inst));

banco_regs br(.clk(clk),.rl1(inst[19:15]), .rl2(inst[24:20]), .resc(inst[11:7]), .dado(dado), .h_esc(regWrite),.d1(rl1out), .d2(rl2out));

mux_gimm mgi(.sel_tipo_s_ou_b(SeltipoSouB), .entr(inst[31:7]), .parte2im(imed_p2muxed));

gera_imediato gi(.entr_parte1(inst[31:25]), .entr_parte2(imed_p2muxed), .saida(imed));

mux_ula mxula(.ALUSrc(ALUSrc), .dado2(rl2out), .imed(imed), .saida(ula_in2));

ULA unid_log_arit(.sel(ALUOp), .X(rl1out), .Y(ula_in2), .res(ulares), .neg(n), .zero(z));

data_mem_ram md(.clk(clk),.entr(rl2out),.end_lei(ulares),.end_esc(ulares),.h_esc(MemWrite),.saida(memout));

mux_memreg mmr(.MemToReg(MemToReg),.ULAres(ulares), .memout(memout), .saida(dado));

mux_branch_adder mba(.PCSrc(PCSrc), .imed(imed), .atualPC(atualPC), .novoPC(novoPC));


endmodule
