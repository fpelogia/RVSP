module gerenciador_entr_saida(reset, clk, dado, stdout, RegToDisp, SwToReg, switches, dado_sw32);
input clk, reset;
input [31:0] dado;
input RegToDisp, SwToReg;//Sinais de Controle
input [15:0] switches; // 16 Switches do Kit DE2-115
output [31:0] stdout, dado_sw32;
reg [31:0] proxSaida;
reg [31:0] proxEntrada;

assign stdout = (reset == 1) ? 170 : proxSaida;
assign dado_sw32 = proxEntrada;

always @(posedge clk or posedge reset) begin
	if(reset == 1) 
		proxSaida <= 0;
	else if(RegToDisp == 1)
		proxSaida <= dado;
	else if(SwToReg == 1)
		proxEntrada <= ({{16{1'b0}},switches});
	else
		proxSaida <= 100;
		
	
end

endmodule