module gerencia_PC(clk, novoPC, atualPC, reset);
input clk, reset;
input[31:0] novoPC;
output[31:0] atualPC;
reg [31:0] proxPC;

assign atualPC = (reset == 1)? 0 : proxPC;

always @(posedge clk or posedge reset) begin
	if(reset == 1) begin
		proxPC <= 0;
	end
	else
		proxPC <= novoPC;
end


endmodule
