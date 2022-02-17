module controla_so(clk, reset, HALT, Sel_BIOS, id_proc_atual, id_proc, Set_ctx);

input clk, reset, HALT, Set_ctx;
input [1:0] id_proc_atual;
output reg Sel_BIOS;
output reg [1:0] id_proc;

reg BIOS_MODE = 1'b1;
reg PID = 1'b0;

always @(posedge clk or posedge reset) begin
	if(reset == 1) begin
		BIOS_MODE <= 1;
	end
	else if (HALT == 1 && BIOS_MODE == 1)
	begin
		BIOS_MODE <= 0;
	end
	else if(Set_ctx == 1)
	begin
		PID <= id_proc_atual;// pega novo id_proc da MD
	end
	else
	begin
		Sel_BIOS <= BIOS_MODE;
		id_proc <= PID;
	end
	
end

endmodule