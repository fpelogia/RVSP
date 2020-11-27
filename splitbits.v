 module splitbits(d, ultimos4, penultimos4);
 input [31:0] d;
 output[3:0] ultimos4, penultimos4;
 assign ultimos4[3:0] = d[3:0];
 assign penultimos4[3:0] = d[7:4];
 endmodule
 