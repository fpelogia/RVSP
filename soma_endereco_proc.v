module soma_endereco_proc(id_proc, ender_in, ender, M, tam_particao);

input [1:0] id_proc;
input [8:0] ender_in;
output reg [8:0] ender;
input [6:0] M;
input [6:0] tam_particao;

// Soma deslocamento aos endereços 
// para cada tipo de processo
always @(*)
begin
	if(id_proc == 2'b00)
		ender = ender_in;
	else if(id_proc == 2'b01)
		ender = ender_in + M;
	else
		ender = ender_in + M + tam_particao;
end

endmodule