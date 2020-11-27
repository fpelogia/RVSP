module mux_ula(ALUSrc, dado2, imed, saida);
input ALUSrc;
input [31:0] dado2, imed;
output [31:0] saida;

assign saida = (ALUSrc == 1)? imed : dado2;


endmodule