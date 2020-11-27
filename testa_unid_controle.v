module testa_unid_controle(clk,ALUOp,ALUSrc, n, z, SeltipoSouB, MemToReg, MemWrite, PCSrc,regWrite, Tipo_Branch, rl1,rl2,rd,dado, inst, ula_in2,imed,rl1out, rl2out,imed_p2muxed, ulares, memout, atualPC,novoPC, selSLT, breg_in);
/*
Este arquivo testa o processador
Colocando todos os fios como saida para fins de debugging
*/
input clk;
output[31:0] dado;
output[31:0] rl1out,ula_in2;
output [31:0] inst; // carrega a instrucao completa
output [31:0] imed, rl2out,imed_p2muxed, ulares, memout, atualPC,novoPC,breg_in; 
output ALUSrc, n, z, SeltipoSouB, MemToReg, MemWrite, PCSrc;
output regWrite, selSLT;
output [3:0] ALUOp;
output [2:0] Tipo_Branch;
output [4:0] rl1, rl2, rd;

assign rl1  = inst[19:15];
assign rl2  = inst[24:20];
assign rd  = inst[11:7];

gerencia_PC gpc(.clk(clk), .novoPC(novoPC), .atualPC(atualPC));
mem_inst mi(.clk(clk), .ender(atualPC[5:0]), .saida(inst));
unid_controle uc(.f7(inst[31:25]), .f3(inst[14:12]), .opcode(inst[6:0]), .regWrite(regWrite), .ALUSrc(ALUSrc), .SeltipoSouB(SeltipoSouB), .MemToReg(MemToReg), .MemWrite(MemWrite),.PCSrc(PCSrc), .ALUOp(ALUOp), .Tipo_Branch(Tipo_Branch), .selSLT(selSLT));
mux_breg_slt(.selSLT(selSLT), .dado(dado), .neg(n), .breg_in(breg_in));
banco_regs br(.clk(clk),.rl1(inst[19:15]), .rl2(inst[24:20]), .resc(inst[11:7]), .dado(breg_in), .h_esc(regWrite),.d1(rl1out), .d2(rl2out));

mux_gimm mgi(.sel_tipo_s_ou_b(SeltipoSouB), .entr(inst[31:7]), .parte2im(imed_p2muxed));

gera_imediato gi(.entr_parte1(inst[31:25]), .entr_parte2(imed_p2muxed), .saida(imed));

mux_ula(.ALUSrc(ALUSrc), .dado2(rl2out), .imed(imed), .saida(ula_in2));

ULA unid_log_arit(.sel(ALUOp), .X(rl1out), .Y(ula_in2), .res(ulares), .neg(n), .zero(z));

data_mem_ram md(.clk(clk),.entr(rl2out),.end_lei(ulares),.end_esc(ulares),.h_esc(MemWrite),.saida(memout));

mux_memreg mmr(.MemToReg(MemToReg),.ULAres(ulares), .memout(memout), .saida(dado));

mux_branch_adder mba(.PCSrc(PCSrc), .Tipo_Branch(Tipo_Branch) , .imed(imed), .ULA_res(ulares), .neg(n), .zero(z), .atualPC(atualPC), .novoPC(novoPC));


endmodule
