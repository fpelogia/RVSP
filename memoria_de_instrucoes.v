// Quartus Prime Verilog Template
// Single port RAM with single read/write address and initial contents 
// specified with an initial block

module memoria_de_instrucoes
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=9)
(
	input [(ADDR_WIDTH-1):0] ender, //endereço recebido do PC
	input clk, //clock
	input InstrWrite,
	input [(DATA_WIDTH-1):0] dado, // instrução de 32 bits (entrada)
	output [(DATA_WIDTH-1):0] saida // instrução de 32 bits
);
	
	//Declara a RAM de instruções
	//A memória tem espaço para 2^6 = 64 instruções
	// representando 256 bytes de dados
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	
	//Inicializa memória de instruções (Com BIOS ok, não precisaremos mais)
	initial begin
		$readmemb("./inicializa_mem_inst.txt", ram);
	end

	always @ (posedge clk)
	begin
		// Escrita de Instrução na RAM
		if (InstrWrite)
			ram[ender] <= dado;

		addr_reg <= ender;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign saida = ram[addr_reg];

endmodule
