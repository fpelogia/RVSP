module processador_debug(clk_rapido, clk, dado, ulares, memout, atualPC, stdout);
/*
Este arquivo testa o processador
Colocando todos os fios como saida para fins de debugging
*/
input clk_rapido;
output clk;
output [31:0] stdout;
output [31:0] dado;
output [31:0] ulares;
output [31:0] memout;
output [31:0] atualPC;
wire [31:0] rl1out,ula_in2;
wire  [31:0] inst; // carrega a instrucao completa
wire  [31:0] imed, rl2out,imed_p2muxed,novoPC,breg_in; 
wire  ALUSrc, n, z, SeltipoSouB, MemToReg, MemWrite, PCSrc;
wire  regWrite;
wire  [1:0] selSLT_JAL;
wire  [3:0] ALUOp;
wire  [2:0] Tipo_Branch;
wire  [4:0] rl1, rl2, rd;

assign rl1  = inst[19:15];
assign rl2  = inst[24:20];
assign rd  = inst[11:7];


divisor_freq dfreq(.CLK_50(clk_rapido), .CLK_1(clk));

gerencia_PC gpc(.clk(clk), .novoPC(novoPC), .atualPC(atualPC));

memoria_de_instrucoes mi(.clk(clk), .ender(atualPC[5:0]), .saida(inst));

unidade_de_controle uc(.f7(inst[31:25]), .f3(inst[14:12]), .opcode(inst[6:0]), .regWrite(regWrite), .ALUSrc(ALUSrc), .SeltipoSouB(SeltipoSouB), .MemToReg(MemToReg), .MemWrite(MemWrite),.PCSrc(PCSrc), .ALUOp(ALUOp), .Tipo_Branch(Tipo_Branch), .selSLT_JAL(selSLT_JAL));

mux_breg_slt_jal mbsj(.selSLT_JAL(selSLT_JAL), .dado(dado), .neg(n), .zero(z), .atualPC(atualPC), .breg_in(breg_in));

banco_de_registradores br(.clk(clk),.rl1(inst[19:15]), .rl2(inst[24:20]), .resc(inst[11:7]), .dado(breg_in), .h_esc(regWrite),.d1(rl1out), .d2(rl2out));

mux_gimm mgi(.sel_tipo_s_ou_b(SeltipoSouB), .entr(inst[31:7]), .parte2im(imed_p2muxed));

gera_imediato gi(.entr_parte1(inst[31:25]), .entr_parte2(imed_p2muxed), .imed19(inst[31:12]), .selSLT_JAL(selSLT_JAL),.saida(imed));

mux_ula mxula(.ALUSrc(ALUSrc), .dado2(rl2out), .imed(imed), .saida(ula_in2));

ULA unid_log_arit(.sel(ALUOp), .X(rl1out), .Y(ula_in2), .res(ulares), .neg(n), .zero(z));

//memoria_de_dados md(.clk(clk),.entr(rl2out),.end_lei(ulares),.end_esc(ulares),.h_esc(MemWrite),.saida(memout), .stdout(stdout));
mem_dados_dual md(.write_clock(clk), .read_clock(clk_rapido), .dado_entr(rl2out),.end_lei(ulares),.end_esc(ulares),.hab_esc(MemWrite),.saida(memout), .stdout(stdout));

mux_memreg mmr(.MemToReg(MemToReg),.ULAres(ulares), .memout(memout), .saida(dado));

mux_soma_desvio msd(.PCSrc(PCSrc), .Tipo_Branch(Tipo_Branch) , .imed(imed), .ULA_res(ulares), .neg(n), .zero(z), .atualPC(atualPC), .novoPC(novoPC));


endmodule
