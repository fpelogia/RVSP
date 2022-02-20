module mux_instr_pc (inst_bios, inst_mi, inst, sel, troca_ctx, id_proc);

input sel, troca_ctx;
input [1:0] id_proc;
input [31:0] inst_bios, inst_mi;
output reg [31:0] inst;

	always @(*)
	begin
		if (troca_ctx == 1 && id_proc != 0)
			inst = 32'b00000000000000000001110011101111; //jal $aux_so 1 (salva PC)
		else if (sel == 0)
			inst = inst_mi;
		else
			inst = inst_bios;
	end

endmodule