module unidade_de_controle(f7, f3, opcode, regWrite, ALUSrc, SeltipoSouB, MemToReg, MemWrite,PCSrc, ALUOp, Tipo_Branch, selSLT_JAL, SwToReg, RegToDisp, HALT, Sel_HD_w);
input [6:0] opcode, f7;
input [2:0] f3;
output reg regWrite, ALUSrc,SeltipoSouB, MemWrite,PCSrc, SwToReg;
output RegToDisp, HALT, Sel_HD_w;
output [2:0] Tipo_Branch;
output [1:0] selSLT_JAL;
output reg [1:0] MemToReg;
output reg [3:0] ALUOp;

always @(*) begin
	case (opcode)
		//Instrucao de tipo R
		51: case (f3)
				0: case (f7)
						
						0: begin // add rd,rs1,rs2
							regWrite = 1;
							ALUSrc = 0;
							SeltipoSouB = 0;
							MemToReg = 0;
							MemWrite = 0;
							PCSrc = 0;
							ALUOp = 4'b0000;
						end
						32: begin // sub rd,rs1,rs2
							regWrite = 1;
							ALUSrc = 0;
							SeltipoSouB = 0;
							MemToReg = 0;
							MemWrite = 0;
							PCSrc = 0;
							ALUOp = 4'b0001;
						end
						default: begin 
							regWrite = 1;
							ALUSrc = 1;
							SeltipoSouB = 0;
							MemToReg = 0;
							MemWrite = 0;
							PCSrc = 0;
							ALUOp = 4'b0000;
						end
					endcase
				1: begin // sll rd,rs1,rs2
					regWrite = 1;
					ALUSrc = 0;
					SeltipoSouB = 0;
					MemToReg = 0;
					MemWrite = 0;
					PCSrc = 0;
					ALUOp = 4'b0100;
					end
				2: begin // slt rd,rs1,rs2
					regWrite = 1;
					ALUSrc = 0;
					SeltipoSouB = 0;
					MemToReg = 0;
					MemWrite = 0;
					PCSrc = 0;
					ALUOp = 4'b0001;
					// para essa instrucao
					// o registrador deve 
					// receber neg
					end
				3: case (f7)						
						0: begin // mul rd,rs1,rs2
							regWrite = 1;
							ALUSrc = 0;
							SeltipoSouB = 0;
							MemToReg = 0;
							MemWrite = 0;
							PCSrc = 0;
							ALUOp = 4'b1001
							;
							end
						32: begin // div rd,rs1,rs2
							regWrite = 1;
							ALUSrc = 0;
							SeltipoSouB = 0;
							MemToReg = 0;
							MemWrite = 0;
							PCSrc = 0;
							ALUOp = 4'b1010;
							end
						default: begin // add rd,rs1,rs2
						regWrite = 1;
						ALUSrc = 0;
						SeltipoSouB = 0;
						MemToReg = 0;
						MemWrite = 0;
						PCSrc = 0;
						ALUOp = 4'b0000;
						end
					endcase
				4: case (f7)
						0: begin // xor rd,rs1,rs2
							regWrite = 1;
							ALUSrc = 0;
							SeltipoSouB = 0;
							MemToReg = 0;
							MemWrite = 0;
							PCSrc = 0;
							ALUOp = 4'b0110;//xor
							end
						32:begin // xnor rd,rs1,rs2
							regWrite = 1;
							ALUSrc = 0;
							SeltipoSouB = 0;
							MemToReg = 0;
							MemWrite = 0;
							PCSrc = 0;
							ALUOp = 4'b1000;//xnor
							end
						default:
							begin // (não deve chegar aqui) xor rd,rs1,rs2
							regWrite = 1;
							ALUSrc = 0;
							SeltipoSouB = 0;
							MemToReg = 0;
							MemWrite = 0;
							PCSrc = 0;
							ALUOp = 4'b0110;
							end	
					endcase
				5: begin // sll rd,rs1,rs2
					regWrite = 1;
					ALUSrc = 0;
					SeltipoSouB = 0;
					MemToReg = 0;
					MemWrite = 0;
					PCSrc = 0;
					ALUOp = 4'b0101;
					end
				6: begin // or rd,rs1,rs2
					regWrite = 1;
					ALUSrc = 0;
					SeltipoSouB = 0;
					MemToReg = 0;
					MemWrite = 0;
					PCSrc = 0;
					ALUOp = 4'b0011;
					end
				7: begin // and rd,rs1,rs2
					regWrite = 1;
					ALUSrc = 0;
					SeltipoSouB = 0;
					MemToReg = 0;
					MemWrite = 0;
					PCSrc = 0;
					ALUOp = 4'b0010;
					end	
				default: 
					begin 
					regWrite = 1;
					ALUSrc = 1;
					SeltipoSouB = 0;
					MemToReg = 0;
					MemWrite = 0;
					PCSrc = 0;
					ALUOp = 4'b0000;
					end
			endcase
		3:case(f3)
				2:begin //lw rd, rs1, imm
					regWrite = 1;
					ALUSrc = 1;
					SeltipoSouB = 0;
					MemToReg = 1;
					MemWrite = 0;
					PCSrc = 0;
					ALUOp = 4'b0000;
					end
			  default: begin 
								regWrite = 1;
								ALUSrc = 1;
								SeltipoSouB = 0;
								MemToReg = 0;
								MemWrite = 0;
								PCSrc = 0;
								ALUOp = 4'b0000;
				end
		  endcase
		19:begin //addi rd, rs1, imm
			regWrite = 1;
			ALUSrc = 1;
			SeltipoSouB = 0;
			MemToReg = 0;
			MemWrite = 0;
			PCSrc = 0;
			ALUOp = 4'b0000;
			end

		7'b1100011: case(f3) //Instrucoes do tipo B
					0: begin// beq rs1, rs2, imm
						regWrite = 0;
						ALUSrc = 0;
						SeltipoSouB = 1;
						MemToReg = 0;//X
						MemWrite = 0;
						PCSrc = 1;
						ALUOp = 4'b0001;
						//Tipo_Branch = 1;
						end
					1: begin// bne rs1, rs2, imm
						regWrite = 0;
						ALUSrc = 0;
						SeltipoSouB = 1;
						MemToReg = 0;//X
						MemWrite = 0;
						PCSrc = 1;
						ALUOp = 4'b0001;
						//Tipo_Branch = 2;
						end
					4: begin// blt rs1, rs2, imm
						regWrite = 0;
						ALUSrc = 0;
						SeltipoSouB = 1;
						MemToReg = 0;//X
						MemWrite = 0;
						PCSrc = 1;
						ALUOp = 4'b0001;
						//Tipo_Branch = 3;
						end
					5: begin// bge rs1, rs2, imm
						regWrite = 0;
						ALUSrc = 0;
						SeltipoSouB = 1;
						MemToReg = 0;//X
						MemWrite = 0;
						PCSrc = 1;
						ALUOp = 4'b0001;
						//Tipo_Branch = 4;
						end
					default: begin 
							regWrite = 1;
							ALUSrc = 1;
							SeltipoSouB = 0;
							MemToReg = 0;
							MemWrite = 0;
							PCSrc = 0;
							ALUOp = 4'b0000;
						end
			  endcase
		7'b1101111: begin // jal rd, imm
			regWrite = 1;
			ALUSrc = 1;
			SeltipoSouB = 0;
			MemToReg = 0;//X
			MemWrite = 0;
			PCSrc = 1;
			ALUOp = 4'b0000;//x
			end
		35: begin // sw rs1, rs2, imm
			regWrite = 0;
			ALUSrc = 1;
			SeltipoSouB = 1;
			MemToReg = 0;
			MemWrite = 1;
			PCSrc = 0;
			ALUOp = 4'b0000;
			end
		55: begin // IN rd
			regWrite = 1;
			ALUSrc = 0;
			SeltipoSouB = 0;
			MemToReg = 0;
			SwToReg = 1;
			MemWrite = 0;
			PCSrc = 0;
			ALUOp = 4'b0000;
			end
		23: begin // OUT rd
			regWrite = 0;
			ALUSrc = 0;
			SeltipoSouB = 0;
			MemToReg = 0;
			MemWrite = 0;
			PCSrc = 0;
			ALUOp = 4'b0000;
			end
		63: begin // HALT
			regWrite = 0;
			ALUSrc = 0;
			SeltipoSouB = 0;
			MemToReg = 0;
			MemWrite = 0;
			PCSrc = 0;
			ALUOp = 4'b0000;
			end
		62: begin // Syscall HD_TO_REG
			regWrite = 1; // Escreve dado lido do HD
			ALUSrc = 0;
			SeltipoSouB = 0;
			MemToReg = 2; //HD -> B.reg
			MemWrite = 0;
			PCSrc = 0;
			ALUOp = 4'b0000;
			end	
		61: begin // Syscall REG_TO_HD
			regWrite = 0; 
			ALUSrc = 0;
			SeltipoSouB = 0;
			MemToReg = 0;
			MemWrite = 0;
			PCSrc = 0;
			ALUOp = 4'b0000;
			end
		default: begin // NOP (No Operation)
			regWrite = 0;
			ALUSrc = 0;
			SeltipoSouB = 0;
			MemToReg = 0; 
			MemWrite = 0;
			PCSrc = 0;
			ALUOp = 4'b0000;
		end
	endcase
end
assign Tipo_Branch = (opcode == 7'b1101111)? 6: ((f3 == 0)? 1: ((f3 == 1)?	2: ((f3 == 4)? 3 : ((f3 == 5)? 4: ((f3 == 6)? 5 : 0)))));
assign selSLT_JAL = (opcode == 51 && f3 == 2)?((f7 == 32)?3:1):((opcode == 7'b1101111)? 2 : 0);
assign RegToDisp = (opcode == 23)? 1:0; // OUT
assign HALT = (opcode == 63)? 1:0;
assign Sel_HD_w = (opcode == 61)? 1 : 0; // REG_TO_HD

endmodule
