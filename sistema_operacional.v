module sistema_operacional(clk, clk_rapido, bloq_cpu, HALT, Sel_BIOS, reset, stdout_7b, dez_a, dez_b, dez_c, dez_d, dez_e, dez_f, dez_g, unid_a, unid_b, unid_c, unid_d, unid_e, unid_f, unid_g);

input clk_rapido;
input reset;
output clk;
output bloq_cpu, HALT, Sel_BIOS;
output [6:0] stdout_7b;
output dez_a, dez_b, dez_c, dez_d, dez_e, dez_f, dez_g;
output unid_a, unid_b, unid_c, unid_d, unid_e, unid_f, unid_g;
wire clk_rap, MemWrite;
wire [31:0] atualPC;
wire [31:0] inst_bios, inst_mi, inst;
wire [31:0] rl2out, ulares, memout, HD_out;

divisor_freq dfreq(.CLK_50(clk_rapido), .CLK_1(clk));

// Controla SO
controla_so cso(.bloq_cpu(bloq_cpu), .reset(reset), .HALT(HALT), .sel_BIOS(sel_BIOS));

// MUDAR pra um reg.. HALT não vai nunca mais liberar clk

// Habilitador
assign clk_rap = clk_rapido & ~bloq_cpu; //HALT bloqueia o uso do processador

// Processador RVSP
processador cpu(.clk_rapido(clk_rap), .clk(clk), .atualPC(atualPC), .HALT(HALT), .inst(inst), .reset(reset), .stdout_7b(stdout_7b), .dez_a(dez_a), .dez_b(dez_b), .dez_c(dez_c), .dez_d(dez_d), .dez_e(dez_e), .dez_f(dez_f), .dez_g(dez_g), .unid_a(unid_a), .unid_b(unid_b), .unid_c(unid_c), .unid_d(unid_d), .unid_e(unid_e), .unid_f(unid_f), .unid_g(unid_g), .rl2out(rl2out), .ulares(ulares), .memout(memout), .MemWrite(MemWrite), .HD_instr(Sel_HD_Lei_Esc), .HD_out(HD_out));

// BIOS (ROM)
bios bios_rom(.clk(clk), .ender(atualPC[5:0]), .saida(inst_bios));

// Memória de Instruções (RAM)
memoria_de_instrucoes mi(.clk(clk), .ender(atualPC[5:0]), .saida(inst_mi));

// Mux. Instr PC
mux_instr_pc mipc(.inst_bios(inst_bios), .inst_mi(inst_mi), .inst(inst), .sel(Sel_BIOS));

// Memória de Dados (RAM)
mem_dados_dual md(.write_clock(clk), .read_clock(clk_rapido), .dado_entr(rl2out),.end_lei(ulares),.end_esc(ulares),.hab_esc(MemWrite),.saida(memout));

// HD Simulado
HD hd_simul(.dado_entr(rl2out), .trilha(inst[31:28]), .setor(inst[19:14]), .Sel_HD_Lei_Esc(Sel_HD_Lei_Esc), .read_clock(clk_rapido), .write_clock(clk), .saida(HD_out));

endmodule