module controla_so(bloq_cpu, reset, HALT, sel_BIOS);

input HALT, reset;
output sel_BIOS, bloq_cpu;
reg BIOS_MODE = 1;
reg CPU_HAB = 1;

assign sel_BIOS = (BIOS_MODE == 1) ? 1 : 0;
assign bloq_cpu = ~ CPU_HAB;

always @(*) begin
	if(reset)
		BIOS_MODE = 1'b1;
	else if(HALT == 1 && BIOS_MODE == 1) begin
		CPU_HAB = 1'b1;
		BIOS_MODE = 1'b0;
	end
end


endmodule