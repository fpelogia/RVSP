module banco_de_registradores(clk,rl1, rl2, resc, dado, h_esc, d1, d2);
	input clk;
	input [31:0] dado; // dado a ser escrito
	input [4:0] rl1, rl2, resc; //endereco dos regs 
	input h_esc;
	output [31:0] d1,d2;
	
	reg [31:0] x[30:0]; // 31 reg's de 32 bits


	always @(posedge(clk)) begin
		if (h_esc == 1)	x[resc] = dado; //escrita

	end
	//leituras
	assign d1 = x[rl1];
	assign d2 = x[rl2];

endmodule
