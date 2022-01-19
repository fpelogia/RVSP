module controla_so(clk, reset, HALT, Sel_BIOS);

input clk, reset, HALT;
output reg Sel_BIOS;
reg BIOS_MODE = 1'b1;

always @(posedge clk or posedge reset) begin
	if(reset == 1) begin
		BIOS_MODE <= 1;
	end
	else if (HALT == 1 && BIOS_MODE == 1)
	begin
		BIOS_MODE <= 0;
	end
	else
	begin
		Sel_BIOS <= BIOS_MODE;
	end
end

endmodule