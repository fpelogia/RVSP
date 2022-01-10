module mux_memreg (MemToReg,ULAres, memout, saida);
input MemToReg;
input[31:0] ULAres, memout;
output[31:0] saida;

assign saida = (MemToReg == 0)? ULAres : memout;
endmodule
