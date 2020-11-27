module gera_imediato(entr_parte1, entr_parte2, saida);
/*
 Espera-se que a segunda parte da entrada tenha passado pelo mux_gimm
*/
	input[6:0] entr_parte1;
	input[4:0] entr_parte2;
	output reg[31:0] saida;
	always @(*) begin
		saida = {{20{entr_parte1[6]}}, entr_parte1, entr_parte2};	
	end

endmodule