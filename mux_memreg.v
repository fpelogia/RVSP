module mux_memreg (MemToReg,ULAres, memout, saida, HD_out);
input[1:0] MemToReg;
input[31:0] ULAres, memout, HD_out;
output[31:0] saida;

assign saida = (MemToReg == 0)? ULAres : ((MemToReg == 1)? memout : HD_out );
endmodule
