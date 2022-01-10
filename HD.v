module HD
#(parameter BITS_TRILHA=4, parameter BITS_SETOR=6)
(
	//memoria com 64 slots de 32 bits
	input [31:0] dado_entr,
	input [(BITS_TRILHA-1):0] trilha,
    input [(BITS_SETOR-1):0] setor,
	input Sel_HD_Lei_Esc, read_clock, write_clock,
	output reg [31:0] saida
);
	localparam  NUM_SETORES=2**BITS_SETOR;
	
	// Declara o HD Simulado (1024 slots -> 16 trilhas e 64 setores)
	reg [31:0] hd_sim[((2**BITS_TRILHA)*(2**BITS_SETOR))-1:0];
	
	always @ (posedge write_clock)
	begin
		// Escrita no HD
		if (Sel_HD_Lei_Esc)
			hd_sim[trilha*NUM_SETORES + setor] <= dado_entr;
	end
	
	always @ (posedge read_clock)
	begin
		// Leitura no HD
		saida <= hd_sim[trilha*NUM_SETORES + setor];
	end
	
endmodule
