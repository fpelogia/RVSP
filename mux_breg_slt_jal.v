module mux_breg_slt_jal(selSLT_JAL, dado, neg, atualPC, breg_in);

input [31:0] dado, atualPC;
input neg; 
input [1:0] selSLT_JAL;
output [31:0] breg_in;

assign breg_in = (selSLT_JAL == 1)? ({{31{1'b0}},neg}) : ((selSLT_JAL == 2)? atualPC: dado);


endmodule
