module gerencia_PC(clk, novoPC, atualPC);
input clk;
input[31:0] novoPC;
output[31:0] atualPC;
reg [31:0] proxPC;

assign atualPC = proxPC;

always @(posedge(clk)) begin
	proxPC = novoPC;
end


endmodule
