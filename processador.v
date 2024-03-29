module processador(clk_rapido, switches, clk, atualPC, HALT, WAIT, id_proc, inst, reset, preemp_mode, stdout_7b, rl2out, ulares, memout, MemWrite, Sel_HD_w, HD_out, RegToDisp, SwToReg, breg_in_muxed, regWrite, Set_ctx, Set_pid_0, troca_ctx);

input clk_rapido, clk;
input reset, preemp_mode, troca_ctx;
input [1:0] id_proc;
input [31:0] inst; // carrega a instrucao completa
input [31:0] memout, HD_out;
input [15:0] switches; // 16 Switches do Kit DE2-115
output HALT, WAIT;
output [31:0] atualPC;
output [6:0] stdout_7b;
output MemWrite, Sel_HD_w, RegToDisp, SwToReg, Set_ctx, Set_pid_0;
output [31:0] rl2out, ulares, breg_in_muxed, regWrite;

wire [31:0] stdout;
wire [31:0] dado;
wire [31:0] dado_sw32;
wire [31:0] rl1out,ula_in2;
wire [31:0] imed,novoPC, breg_in; 
wire ALUSrc, n, z, SeltipoSouB, PCSrc, Sel_HD_r, Check_preemp; 
wire [1:0] selSLT_JAL, MemToReg;
wire [3:0] ALUOp;
wire [2:0] Tipo_Branch;
wire [4:0] imed_p2muxed;
wire [4:0] rl1, rl2, rd;

//assign rl1  = inst[19:15];
//assign rl2  = inst[24:20];
//assign rd  = inst[11:7];

gerencia_PC gpc(.clk(clk), .novoPC(novoPC), .atualPC(atualPC), .reset(reset), .HALT(HALT), .id_proc(id_proc), .troca_ctx(troca_ctx));

unidade_de_controle uc(.f7(inst[31:25]), .f3(inst[14:12]), .opcode(inst[6:0]), .regWrite(regWrite), .ALUSrc(ALUSrc), .SeltipoSouB(SeltipoSouB), .MemToReg(MemToReg), .MemWrite(MemWrite),.PCSrc(PCSrc), .ALUOp(ALUOp), .Tipo_Branch(Tipo_Branch), .selSLT_JAL(selSLT_JAL), .SwToReg(SwToReg), .RegToDisp(RegToDisp), .HALT(HALT), .Sel_HD_w(Sel_HD_w), .Sel_HD_r(Sel_HD_r), .Set_ctx(Set_ctx), .Set_pid_0(Set_pid_0),.WAIT(WAIT));

mux_breg_slt_jal mbsj(.selSLT_JAL(selSLT_JAL), .dado(dado), .neg(n), .zero(z), .atualPC(atualPC), .breg_in(breg_in));

// Syscall IN e HD_TO_REG
assign breg_in_muxed = (SwToReg == 1)? dado_sw32 : ((Sel_HD_r == 1)? HD_out : ((Check_preemp == 1)? preemp_mode:breg_in));

banco_de_registradores br(.clk(clk),.rl1(inst[19:15]), .rl2(inst[24:20]), .resc(inst[11:7]), .dado(breg_in_muxed), .h_esc(regWrite),.d1(rl1out), .d2(rl2out));

mux_gimm mgi(.sel_tipo_s_ou_b(SeltipoSouB), .entr(inst[31:7]), .parte2im(imed_p2muxed));

gera_imediato gi(.entr_parte1(inst[31:25]), .entr_parte2(imed_p2muxed), .imed19(inst[31:12]), .selSLT_JAL(selSLT_JAL),.saida(imed));

mux_ula mxula(.ALUSrc(ALUSrc), .dado2(rl2out), .imed(imed), .saida(ula_in2));

ULA unid_log_arit(.sel(ALUOp), .X(rl1out), .Y(ula_in2), .res(ulares), .neg(n), .zero(z));

mux_memreg mmr(.MemToReg(MemToReg),.ULAres(ulares), .memout(memout), .saida(dado));

mux_soma_desvio msd(.PCSrc(PCSrc), .Tipo_Branch(Tipo_Branch) , .imed(imed), .rl2out(rl2out), .neg(n), .zero(z), .atualPC(atualPC), .novoPC(novoPC));
	
gerenciador_entr_saida ges(.clk(clk_rapido), .dado(rl2out), .stdout(stdout), .RegToDisp(RegToDisp), .SwToReg(SwToReg), .switches(switches), .dado_sw32(dado_sw32));

limita_saida_7b ls7b(.dado(stdout), .d7b(stdout_7b));

endmodule
