module processador(clk_rapido, clk, atualPC, HALT, inst, reset, stdout_7b, dez_a, dez_b, dez_c, dez_d, dez_e, dez_f, dez_g, unid_a, unid_b, unid_c, unid_d, unid_e, unid_f, unid_g, rl2out, ulares, memout, MemWrite, HD_instr, HD_out);

input clk_rapido, clk;
input reset;
input [31:0] inst; // carrega a instrucao completa
input [31:0] memout, HD_out;

output HALT;
output [31:0] atualPC;
output [6:0] stdout_7b;
output dez_a, dez_b, dez_c, dez_d, dez_e, dez_f, dez_g;
output unid_a, unid_b, unid_c, unid_d, unid_e, unid_f, unid_g;
output MemWrite, HD_instr;
output [31:0] rl2out, ulares;

wire [31:0] stdout;
wire [3:0] dezena;
wire [3:0] unidade;
wire [31:0] dado;
wire [31:0] rl1out,ula_in2;
wire [31:0] imed,imed_p2muxed,novoPC,breg_in; 
wire ALUSrc, n, z, SeltipoSouB, PCSrc, SwToReg, RegToDisp, regWrite; 
wire [1:0] selSLT_JAL, MemToReg;
wire [3:0] ALUOp;
wire [2:0] Tipo_Branch;
wire [4:0] rl1, rl2, rd;

assign rl1  = inst[19:15];
assign rl2  = inst[24:20];
assign rd  = inst[11:7];


//divisor_freq dfreq(.CLK_50(clk_rapido), .CLK_1(clk));

gerencia_PC gpc(.clk(clk), .novoPC(novoPC), .atualPC(atualPC), .reset(reset));

//memoria_de_instrucoes mi(.clk(clk), .ender(atualPC[5:0]), .saida(inst));

unidade_de_controle uc(.f7(inst[31:25]), .f3(inst[14:12]), .opcode(inst[6:0]), .regWrite(regWrite), .ALUSrc(ALUSrc), .SeltipoSouB(SeltipoSouB), .MemToReg(MemToReg), .MemWrite(MemWrite),.PCSrc(PCSrc), .ALUOp(ALUOp), .Tipo_Branch(Tipo_Branch), .selSLT_JAL(selSLT_JAL), .SwToReg(SwToReg), .RegToDisp(RegToDisp), .HALT(HALT), .HD_instr(HD_instr));

mux_breg_slt_jal mbsj(.selSLT_JAL(selSLT_JAL), .dado(dado), .neg(n), .zero(z), .atualPC(atualPC), .breg_in(breg_in));

banco_de_registradores br(.clk(clk),.rl1(inst[19:15]), .rl2(inst[24:20]), .resc(inst[11:7]), .dado(breg_in), .h_esc(regWrite),.d1(rl1out), .d2(rl2out));

mux_gimm mgi(.sel_tipo_s_ou_b(SeltipoSouB), .entr(inst[31:7]), .parte2im(imed_p2muxed));

gera_imediato gi(.entr_parte1(inst[31:25]), .entr_parte2(imed_p2muxed), .imed19(inst[31:12]), .selSLT_JAL(selSLT_JAL),.saida(imed));

mux_ula mxula(.ALUSrc(ALUSrc), .dado2(rl2out), .imed(imed), .saida(ula_in2));

ULA unid_log_arit(.sel(ALUOp), .X(rl1out), .Y(ula_in2), .res(ulares), .neg(n), .zero(z));

//mem_dados_dual md(.write_clock(clk), .read_clock(clk_rapido), .dado_entr(rl2out),.end_lei(ulares),.end_esc(ulares),.hab_esc(MemWrite),.saida(memout));

mux_memreg mmr(.MemToReg(MemToReg),.ULAres(ulares), .memout(memout), .saida(dado));

mux_soma_desvio msd(.PCSrc(PCSrc), .Tipo_Branch(Tipo_Branch) , .imed(imed), .ULA_res(ulares), .neg(n), .zero(z), .atualPC(atualPC), .novoPC(novoPC));
	
// dado é o que sai do banco de registradores	
gerenciador_entr_saida ges(.clk_rapido(clk_rapido), .dado(rl2out), .stdout(stdout), .RegToDisp(RegToDisp));

limita_saida_7b ls7b(.dado(stdout), .d7b(stdout_7b));

buffer_saida_disp bsd(.dado(stdout_7b), .end_lei(0), .end_esc(0), .read_clock(clk_rapido), .write_clock(clk), .disp_dezena(dezena), .disp_unidade(unidade), .halt(HALT));
	
DECODIFICADOR_BCD dbcd_d(.d4(dezena), .a(dez_a), .c(dez_c), .d(dez_d), .e(dez_e), .f(dez_f), .g(dez_g));	
DECODIFICADOR_BCD dbcd_u(.d4(unidade), .a(unid_a), .c(unid_c), .d(unid_d), .e(unid_e), .f(unid_f), .g(unid_g));	


endmodule
