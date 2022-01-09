// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// separate read/write clocks

module buffer_saida_disp

// por enquanto ARRD_WIDTH = 2, por ser um para cada d7s
// depois aumentar para incluir LCD

#(parameter DATA_WIDTH=7, parameter ADDR_WIDTH=2)
(
	input [(DATA_WIDTH-1):0] dado,
	input [(ADDR_WIDTH-1):0] end_lei, end_esc,
	input hab_esc, read_clock, write_clock, halt,
	output reg [3:0] disp_dezena,
	output reg [3:0] disp_unidade
);
	
	// Declara o buffer de saída
	reg [DATA_WIDTH-1:0] buffer[2**ADDR_WIDTH-1:0];
	
	always @ (posedge write_clock)
	begin
		// Escrita
		buffer[end_esc] <= dado;
	end
	
	integer i;
	always @ (posedge read_clock)
	begin
		// Leitura
		
		if (halt == 1) 
		begin
			disp_unidade <= 4'b1010; // traço
			disp_dezena <= 4'b1010; // traço
		end
		else if(buffer[end_lei] >= 99)
		begin
			disp_unidade <= 4'b0000; // O
			disp_dezena<= 4'b1011;   // F   -> Overflow
		end
		else
		begin
			
			disp_unidade = 0;
			disp_dezena = 0;
			
			for( i=6; i>=0; i=i-1 ) begin
					
				if( disp_dezena >= 5 )
					disp_dezena = disp_dezena + 3;
					
				if( disp_unidade >= 5 )
					disp_unidade = disp_unidade + 3;

				disp_dezena = disp_dezena << 1;
				disp_dezena[0] = disp_unidade[3];
				disp_unidade = disp_unidade << 1;
				disp_unidade[0] = buffer[end_lei][i];
			end
			
		end
	end
	
endmodule

