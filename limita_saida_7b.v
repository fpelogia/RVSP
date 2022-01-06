module limita_saida_7b (dado, d7b);
	input [31:0] dado;
	output [6:0] d7b;
	
	assign d7b = (dado <= 127)? dado[6:0] : 127;

endmodule