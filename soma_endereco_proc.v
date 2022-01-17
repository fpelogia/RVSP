module soma_endereco_proc(id_proc, ender_in, ender, M, tam_particao);

input [1:0] id_proc;
input [8:0] ender_in;
output reg [8:0] ender;
input [6:0] M;
input [6:0] tam_particao;
// Memória de Dados: M = 10
// Memória de Instruções: M = 50

// Soma deslocamento aos endereços 
// para cada tipo de processo
always @(*)
begin
	if(id_proc == 0)
		ender = ender_in;
	else if(id_proc == 1)
		ender = ender_in + M;
	else
		ender = ender_in + M + tam_particao;
end

endmodule