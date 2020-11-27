module mux_branch_adder(PCSrc,Tipo_Branch, imed, ULA_res,neg, zero, atualPC, novoPC);
input PCSrc, neg, zero;
input [2:0] Tipo_Branch;
input [31:0] atualPC, imed, ULA_res;	
output reg [31:0] novoPC;

always @(*)begin
	if (PCSrc == 1)begin	
		case (Tipo_Branch)
			0: novoPC = atualPC + imed;
			1:	begin //beq
					if (zero == 1) novoPC = atualPC + imed;
					else	novoPC = atualPC + 1'd1;
				end
			2:	begin //bne
					if (zero == 0) novoPC = atualPC + imed;
					else	novoPC = atualPC + 1'd1;
				end
			3:	begin //blt
					if (neg == 1) novoPC = atualPC + imed;
					else	novoPC = atualPC + 1'd1;
				end
			4:	begin //bge
					if (zero == 1 || neg == 0) novoPC = atualPC + imed;
					else	novoPC = atualPC + 1'd1;
				end
			5:	begin //bltu
					if (neg == 1) novoPC = atualPC + imed;
					else	novoPC = atualPC + 1'd1;
					// pensar em como tratar unsigned
				end
			default: novoPC = atualPC + imed;
		endcase
	end
	else novoPC = atualPC + 1'd1;
end

endmodule
