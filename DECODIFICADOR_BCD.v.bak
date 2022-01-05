module DECODIFICADOR_BCD(d4, a, b, c, d, e, f, g);
/*
Para ser utilizado nos testes com o kit FPGA
*/
	input [3:0] d4;
	output a,b,c,d,e,f,g;
	reg [6 : 0] d7s;

	always @(*)
	begin
		case (d4)
		
			4'b0000: 
				d7s=7'b0000001;
			4'b0001: 
				d7s=7'b1001111;
			4'b0010: 
				d7s=7'b0010010;
			4'b0011: 
				d7s=7'b0000110;
			4'b0100: 
				d7s=7'b1001100;
			4'b0101: 
				d7s=7'b0100100;
			4'b0110:
				d7s=7'b0100000;
			4'b0111:
				d7s=7'b0001111;
			4'b1000: 
				d7s=7'b0000000;
			4'b1001: 
				d7s=7'b0000100;
			default: 
				d7s = 7'b1111111;	
		endcase
	end
	assign {a,b,c,d,e,f,g} = d7s;
	
endmodule
