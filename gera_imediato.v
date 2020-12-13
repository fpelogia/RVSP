module gera_imediato(entr_parte1, entr_parte2, imed19, selSLT_JAL, saida);
/*
 Espera-se que a segunda parte da entrada tenha passado pelo mux_gimm
*/
	input[6:0] entr_parte1;
	input[4:0] entr_parte2;
	input [18:0] imed19;
	input [1:0] selSLT_JAL;
	output [31:0] saida;
	/*always @(*) begin
		saida = 	
	end*/
	assign saida = (selSLT_JAL == 2)? {{13{imed19[18]}}, imed19} : {{20{entr_parte1[6]}}, entr_parte1, entr_parte2};

endmodule
