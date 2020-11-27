module contr_ula (ULAop, f3, f7, ULAsel);

	input[1:0] ULAop;
	input[2:0] f3;
	input[6:0] f7;
	output reg[3:0]  ULAsel;
	
	// ver com mais calma depois, ligando 
	// com a unidade de controle
	
	always @(*) begin
		case(f3)
			0:
				if (f7 == 32) ULAsel <= 1;
				else ULAsel <= 0;
			default: ULAsel <= 0;
		endcase
	end







endmodule