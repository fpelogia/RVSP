module sistema_operacional(clk, clk_rapido, reset, dez_a, dez_b, dez_c, dez_d, dez_e, dez_f, dez_g, unid_a, unid_b, unid_c, unid_d, unid_e, unid_f, unid_g);

input clk_rapido;
wire clk_rap;
input reset;
output clk;
wire HALT;
wire [6:0] stdout_7b;
output dez_a, dez_b, dez_c, dez_d, dez_e, dez_f, dez_g;
output unid_a, unid_b, unid_c, unid_d, unid_e, unid_f, unid_g;
wire [31:0] atualPC;

// Habilitador
assign clk_rap = clk_rapido & ~HALT;//HALT bloqueia o uso do processador

// Processador RVSP
processador cpu(.clk_rapido(clk_rap), .clk(clk), .atualPC(atualPC), .HALT(HALT), .reset(reset), .stdout_7b(stdout_7b), .dez_a(dez_a), .dez_b(dez_b), .dez_c(dez_c), .dez_d(dez_d), .dez_e(dez_e), .dez_f(dez_f), .dez_g(dez_g), .unid_a(unid_a), .unid_b(unid_b), .unid_c(unid_c), .unid_d(unid_d), .unid_e(unid_e), .unid_f(unid_f), .unid_g(unid_g));

endmodule