module sistema_operacional(clk, opcode, Sel_HD_Lei_Esc, quantum_over, pc_fim,breg_in_muxed,confirma, preemp_mode, WAIT, regWrite, HD_out, memout, stdout_7b, switches, HALT, clk_rapido, reset, dez_a, dez_b, dez_c, dez_d, dez_e, dez_f, dez_g, unid_a, unid_b, unid_c, unid_d, unid_e, unid_f, unid_g, Set_ctx, Set_pid_0,id_proc, id_proc_atual, ender_mi, ender_md);

input clk_rapido;
input reset, confirma, preemp_mode;
input [15:0] switches; // 16 Switches do Kit DE2-115 
output [1:0] id_proc;
output clk;
output [6:0] stdout_7b;
output dez_a, dez_b, dez_c, dez_d, dez_e, dez_f, dez_g;
output unid_a, unid_b, unid_c, unid_d, unid_e, unid_f, unid_g;
output WAIT, HALT, regWrite, Sel_HD_Lei_Esc, quantum_over, Set_ctx, Set_pid_0;
output [31:0] HD_out, breg_in_muxed, memout;
wire  Sel_BIOS, RegToDisp, bloq_cpu,SwToReg;
wire troca_ctx, cont_reset;
wire clk_h, clk_c, MemWrite, READY;
wire [31:0] atualPC;
output [1:0] id_proc_atual;// 0 - SO // outro - id do processo
output [6:0] pc_fim, opcode;
wire [3:0] dezena;
wire [3:0] unidade;
wire [31:0] inst_bios, inst_mi, inst;
wire [31:0] rl2out, ulares;
output [8:0] ender_mi, ender_md;

assign pc_fim = atualPC[6:0];
assign opcode = inst[6:0];

//Debouncer para botão de confirmação
//debounce deb(.clk(clk), .n_reset(reset), .button_in(confirma), .DB_out(READY));

assign READY = confirma;

divisor_freq dfreq(.CLK_50(clk_rapido), .CLK_1(clk));

assign clk_c = clk & ~Sel_BIOS;
assign cont_reset = (atualPC == 0)? 1:HALT;
contador_quantum cont_q(.clk(clk_c), .quantum_over(quantum_over), .reset(cont_reset));
assign troca_ctx = quantum_over & preemp_mode;

// Controla SO
controla_so cso(.clk(clk), .clk_rapido(clk_rapido), .reset(reset), .HALT(HALT), .Sel_BIOS(Sel_BIOS), .id_proc_atual(id_proc_atual), .id_proc(id_proc), .Set_ctx(Set_ctx), .Set_pid_0(Set_pid_0));

// Habilitador
assign clk_h = clk & (~WAIT | READY);

// Processador RVSP
processador cpu(.clk_rapido(clk_rapido), .clk(clk_h), .switches(switches), .atualPC(atualPC), .HALT(HALT), .WAIT(WAIT), .id_proc(id_proc), .inst(inst), .reset(reset), .preemp_mode(preemp_mode), .stdout_7b(stdout_7b), .rl2out(rl2out), .ulares(ulares), .memout(memout), .MemWrite(MemWrite), .Sel_HD_w(Sel_HD_Lei_Esc), .HD_out(HD_out), .RegToDisp(RegToDisp), .SwToReg(SwToReg), .breg_in_muxed(breg_in_muxed), .regWrite(regWrite), .Set_ctx(Set_ctx), .Set_pid_0(Set_pid_0), .troca_ctx(troca_ctx));

// BIOS (ROM)
bios bios_rom(.clk(clk_h), .ender(atualPC[5:0]), .saida(inst_bios));

// Memória de Instruções (RAM)
soma_endereco_proc sep_mi(.id_proc(id_proc), .ender_in(atualPC[8:0]), .ender(ender_mi), .M(7'd100), .tam_particao(7'd70));
memoria_de_instrucoes mi(.clk(clk_h), .ender(ender_mi), .saida(inst_mi), .InstrWrite(0), .dado(rl2out));

// Mux. Instr PC
mux_instr_pc mipc(.inst_bios(inst_bios), .inst_mi(inst_mi), .inst(inst), .sel(Sel_BIOS), .troca_ctx(troca_ctx), .id_proc(id_proc));

// Memória de Dados (RAM)
soma_endereco_proc  sep_md(.id_proc(id_proc), .ender_in(ulares[8:0]), .ender(ender_md), .M(7'd150), .tam_particao(7'd50));
mem_dados_dual md(.write_clock(clk_h), .read_clock(clk_rapido), .dado_entr(rl2out),.end_lei(ender_md),.end_esc(ender_md),.hab_esc(MemWrite),.saida(memout), .id_proc_atual(id_proc_atual));

// HD Simulado
HD hd_simul(.dado_entr(rl2out), .trilha(inst[31:28]), .setor(inst[19:14]), .Sel_HD_Lei_Esc(Sel_HD_Lei_Esc), .read_clock(clk_rapido), .write_clock(clk_h), .saida(HD_out));

// Saída nos Displays de 7 Segmentos
buffer_saida_disp bsd(.dado(stdout_7b), .hab_esc(1), .end_lei(0), .end_esc(0), .read_clock(clk_rapido), .write_clock(clk_h), .disp_dezena(dezena), .disp_unidade(unidade), .halt(HALT));	
DECODIFICADOR_BCD dbcd_d(.d4(dezena), .a(dez_a), .b(dez_b), .c(dez_c), .d(dez_d), .e(dez_e), .f(dez_f), .g(dez_g));	
DECODIFICADOR_BCD dbcd_u(.d4(unidade), .a(unid_a), .b(unid_b), .c(unid_c), .d(unid_d), .e(unid_e), .f(unid_f), .g(unid_g));	



endmodule