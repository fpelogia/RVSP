module contador_quantum(clk, quantum_over, reset);
	
	parameter quantum = 10;
	
	input clk, reset;
	output reg quantum_over;
	
	reg [6:0] contador;
	
	always @ (posedge clk or posedge reset)
	begin
		if(reset == 1)
		begin
			contador <= 0;
			quantum_over <= 0;
		end
		else if (contador == quantum)
			begin
				contador <= 0;
				quantum_over <= 1;
			end
		else
			begin
				contador<= contador+1;
				quantum_over <= 0;
			end
		
	end
	
endmodule
