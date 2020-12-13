// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// single read/write clock

module data_mem_ram
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=6)
(
	//memoria com 64 slots de 32 bits
	input [(DATA_WIDTH-1):0] entr,
	input [(ADDR_WIDTH-1):0] end_lei, end_esc,
	input h_esc, clk,
	output [(DATA_WIDTH-1):0] saida
);

	// Declara a RAM de dados
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	integer i;
	
	initial begin
		for (i = 0; i < 2**ADDR_WIDTH; i = i + 1) begin
			ram[i] = 0;
		end
   end
	always @ (posedge clk)
	begin
		// escrita
		if (h_esc)
			ram[end_esc] <= entr;
	end
	assign saida = ram[end_lei];

endmodule
