module ULA(sel, X, Y, res, neg, zero);
	input [3:0] sel;
	input[31:0] X,Y;
	output reg [31:0] res;
	output neg;
	output zero; 

	always @(X or Y or sel) begin
		case (sel)
			4'b0000: res = X + Y; // soma
			4'b0001: res = X - Y; // subtracao
			4'b0010: res = X & Y; // AND
			4'b0011: res = X | Y;// OR
			4'b0100: res = X << Y;// desl. esq.
			4'b0101: res = X >> Y;// desl. dir
			4'b0110: res = X ^ Y;// XOR
			4'b0111: res = ~X;// NOT (x)
			4'b1000: res = X ~^ Y;// XNOR
			4'b1001: res = X * Y;// multiplicação
			4'b1010: res = X / Y;// divisão
			default: res = 0;
		endcase
	end
	
	assign neg = res[31]; // reposta negativa ?!
	assign zero = (res == 0);// resposta nula ?!

	

	
endmodule
