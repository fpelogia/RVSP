module mux_gimm(sel_tipo_s_ou_b, entr, parte2im);
	//espera-se na entrada inst[31:7]
	input[24:0] entr;
	input sel_tipo_s_ou_b;
	output[4:0] parte2im;
	assign parte2im = (sel_tipo_s_ou_b == 1'b0)? entr[17:13]:entr[4:0];
endmodule