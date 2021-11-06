module mux_breg_slt_jal(selSLT_JAL, dado, neg, zero, atualPC, breg_in);

input [31:0] dado, atualPC;
input neg;
input zero;
input [1:0] selSLT_JAL;
output [31:0] breg_in;


// 1: SLT
// 2: JAL
// 3: SLET
assign breg_in = (selSLT_JAL == 1)? ({{31{1'b0}},neg}) : ((selSLT_JAL == 2)? atualPC: ((selSLT_JAL == 3)?{{31{1'b0}},(neg||zero)}:dado));


endmodule
