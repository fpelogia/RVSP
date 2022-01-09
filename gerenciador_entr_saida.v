module gerenciador_entr_saida(reset, clk_rapido, dado, stdout, RegToDisp);
input clk_rapido, reset;
input [31:0] dado;
input RegToDisp;//Sinal de Controle
output [31:0] stdout;
reg [31:0] proxSaida;

assign stdout = (reset == 1) ? 170 : proxSaida;

always @(posedge clk_rapido or posedge reset) begin
	if(reset == 1) 
		proxSaida <= 0;
	else if(RegToDisp == 1)
		proxSaida <= dado;
end

endmodule