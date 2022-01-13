module divisor_freq (CLK_50, CLK_1);

	input CLK_50;
	output reg CLK_1;
	
	reg [25:0] OUT;
	//reg OUT;
	
	
	always @ (posedge CLK_50)
	begin
		// PARA USAR COM CLK DE 50MHz do kit FPGA
		
		if (OUT == 27'd50000000)
			begin
				OUT<= 0;
				CLK_1 <= 1;
			end
		else
			begin
				OUT<= OUT+1;
				CLK_1 <= 0;
			end
		
		/*
		if (OUT == 1)
			begin
				OUT<= 0;
				CLK_1 <= 1;
			end
		else
			begin
				OUT<= OUT+1;
				CLK_1 <= 0;
			end
		*/
	end
	
endmodule
