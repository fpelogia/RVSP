module mux_instr_pc (inst_bios, inst_mi, inst, sel);

input sel;
input [31:0] inst_bios, inst_mi;
output [31:0] inst;

	assign inst = (sel == 0) ? inst_mi : inst_bios;

endmodule