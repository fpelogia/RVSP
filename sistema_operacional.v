module sistema_operacional(clk, clk_rapido, stdout_7b, bloq_cpu, HALT, Sel_BIOS, RegToDisp, reset, dez_a, dez_b, dez_c, dez_d, dez_e, dez_f, dez_g, unid_a, unid_b, unid_c, unid_d, unid_e, unid_f, unid_g);

input clk_rapido;
input reset;
output clk;
output [6:0] stdout_7b;
output dez_a, dez_b, dez_c, dez_d, dez_e, dez_f, dez_g;
output unid_a, unid_b, unid_c, unid_d, unid_e, unid_f, unid_g;
output bloq_cpu, HALT, Sel_BIOS, RegToDisp;
wire clk_rap, MemWrite, Sel_HD_Lei_Esc;
wire [31:0] atualPC;
wire [3:0] dezena;
wire [3:0] unidade;
wire [31:0] inst_bios, inst_mi, inst;
wire [31:0] rl2out, ulares, memout, HD_out;

divisor_freq dfreq(.CLK_50(clk_rapido), .CLK_1(clk));

// Controla SO
controla_so cso(.clk(clk), .reset(reset), .HALT(HALT), .bloq_cpu(bloq_cpu), .Sel_BIOS(Sel_BIOS));

// Habilitador
assign clk_rap = clk_rapido & ~bloq_cpu; //HALT bloqueia o uso do processador

// Processador RVSP
processador cpu(.clk_rapido(clk_rap), .clk(clk), .atualPC(atualPC), .HALT(HALT), .inst(inst), .reset(reset), .stdout_7b(stdout_7b), .rl2out(rl2out), .ulares(ulares), .memout(memout), .MemWrite(MemWrite), .Sel_HD_w(Sel_HD_Lei_Esc), .HD_out(HD_out), .RegToDisp(RegToDisp));

// BIOS (ROM)
bios bios_rom(.clk(clk), .ender(atualPC[5:0]), .saida(inst_bios));

// Memória de Instruções (RAM)
memoria_de_instrucoes mi(.clk(clk), .ender(atualPC[5:0]), .saida(inst_mi), .InstrWrite(0), .dado(rl2out));

// Mux. Instr PC
mux_instr_pc mipc(.inst_bios(inst_bios), .inst_mi(inst_mi), .inst(inst), .sel(Sel_BIOS));

// Memória de Dados (RAM)
mem_dados_dual md(.write_clock(clk), .read_clock(clk_rap), .dado_entr(rl2out),.end_lei(ulares),.end_esc(ulares),.hab_esc(MemWrite),.saida(memout));

// HD Simulado
HD hd_simul(.dado_entr(rl2out), .trilha(inst[31:28]), .setor(inst[19:14]), .Sel_HD_Lei_Esc(Sel_HD_Lei_Esc), .read_clock(clk_rap), .write_clock(clk), .saida(HD_out));

// Saída nos Displays de 7 Segmentos
buffer_saida_disp bsd(.dado(stdout_7b), .hab_esc(RegToDisp), .end_lei(0), .end_esc(0), .read_clock(clk_rap), .write_clock(clk), .disp_dezena(dezena), .disp_unidade(unidade), .halt(HALT));	
DECODIFICADOR_BCD dbcd_d(.d4(dezena), .a(dez_a), .b(dez_b), .c(dez_c), .d(dez_d), .e(dez_e), .f(dez_f), .g(dez_g));	
DECODIFICADOR_BCD dbcd_u(.d4(unidade), .a(unid_a), .b(unid_b), .c(unid_c), .d(unid_d), .e(unid_e), .f(unid_f), .g(unid_g));	



endmodule