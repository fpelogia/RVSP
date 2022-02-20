module gerencia_PC(clk, novoPC, atualPC, reset, HALT, id_proc, troca_ctx);
input clk, reset, HALT, troca_ctx;
input [1:0] id_proc;
input[31:0] novoPC;
output[31:0] atualPC;
reg [31:0] proxPC;

assign atualPC = proxPC;

always @(posedge clk or posedge reset) begin
	if(reset == 1) begin
		proxPC <= 0;
	end
	else if(HALT == 1)
	begin
		if(id_proc == 0)
			proxPC <= 0;
		else
			proxPC <= 67; // (P - 3)
	end
	else if (troca_ctx == 1 && id_proc != 0)
		proxPC <= 68; // (P - 2)
	else
		proxPC <= novoPC;
end


endmodule
