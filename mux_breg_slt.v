module mux_breg_slt(selSLT, dado, neg, breg_in);

input [31:0] dado;
input neg, selSLT;
output [31:0] breg_in;

assign breg_in = (selSLT == 1)? {{31{1'b0}},neg} : dado;

endmodule
