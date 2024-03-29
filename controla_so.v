module controla_so(clk, clk_rapido, reset, HALT, Sel_BIOS, id_proc_atual, id_proc, Set_ctx, Set_pid_0);

input clk, clk_rapido, reset, HALT, Set_ctx, Set_pid_0;
input [1:0] id_proc_atual;
output reg Sel_BIOS;
output reg[1:0] id_proc;

reg BIOS_MODE = 1'b1;
reg [1:0] PID = 2'b00;


always @(posedge clk or posedge reset) begin
	if(reset == 1) begin
		BIOS_MODE <= 1;
	end
	else if (HALT == 1 && BIOS_MODE == 1)
	begin
		BIOS_MODE <= 0;
	end
	else if(Set_pid_0 == 1)
	begin
		PID <= 2'b00;// id_proc <-- 0 (SO vai executar)
	end
	else if(Set_ctx == 1)
	begin
		PID <= id_proc_atual;// pega novo id_proc da MD
	end
end

always @(posedge clk_rapido) begin
	Sel_BIOS <= BIOS_MODE;
	id_proc <= PID;
end

endmodule