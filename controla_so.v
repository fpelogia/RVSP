module controla_so(clk, reset, HALT, WAIT, READY, bloq_cpu, Sel_BIOS);

input clk, reset, HALT, WAIT, READY;
output reg Sel_BIOS, bloq_cpu;
reg BIOS_MODE = 1;
reg CPU_BLOCK = 0;

always @(posedge clk or posedge reset) begin
	if(reset == 1) begin
		BIOS_MODE <= 1;
	end
	else if (HALT == 1 && BIOS_MODE == 1)
	begin
		BIOS_MODE <= 0;
	end
	else if (READY == 1)
	begin
		CPU_BLOCK <= 0; // Usuário confirma entrada
	end
	else if (WAIT == 1 && CPU_BLOCK == 0)
	begin
		CPU_BLOCK <= 1; // Bloqueia CPU enquanto espera por Entrada
	end
	else
	begin
		Sel_BIOS <= BIOS_MODE;
		bloq_cpu <= CPU_BLOCK;
	end
end

endmodule