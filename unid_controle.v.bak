module unid_controle(f7, f3, opcode, regWrite, ALUSrc, SeltipoSouB, MemToReg, MemWrite,PCSrc, ALUOp, Tipo_Branch, selSLT);
input [6:0] opcode, f7;
input [2:0] f3;
output reg regWrite, ALUSrc,SeltipoSouB, MemToReg, MemWrite,PCSrc;
output [2:0]Tipo_Branch;
output selSLT;
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
				4: begin // xor rd,rs1,rs2
							regWrite = 1;
							ALUSrc = 0;
							SeltipoSouB = 0;
							MemToReg = 0;
							MemWrite = 0;
							PCSrc = 0;
							ALUOp = 4'b0110;
				end
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
		3:case(f3)
				0:begin //lb rd, rs1, imm
					regWrite = 1;
					ALUSrc = 1;
					SeltipoSouB = 0;
					MemToReg = 1;
					MemWrite = 0;
					PCSrc = 0;
					ALUOp = 4'b0000;
					end
				2:begin //lw rd, rs1, imm
					regWrite = 1;
					ALUSrc = 1;
					SeltipoSouB = 0;
					MemToReg = 1;
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
		7'b1100111:begin //jalr rd, rs1, imm
			//pensar em como salvar endereço do PC
			regWrite = 1;
			ALUSrc = 1;
			SeltipoSouB = 0;
			MemToReg = 0;
			MemWrite = 0;
			PCSrc = 1; // 2
			// modificar muxbranch adder para receber res da ULA
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
					6: begin// bltu rs1, rs2, imm
						regWrite = 0;
						ALUSrc = 0;
						SeltipoSouB = 1;
						MemToReg = 0;//X
						MemWrite = 0;
						PCSrc = 1;
						ALUOp = 4'b0001;
						//Tipo_Branch = 5;
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
		55: begin // lui rd, imm
			regWrite = 1;
			ALUSrc = 1;
			SeltipoSouB = 0;
			MemToReg = 0;
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
end
assign Tipo_Branch = (f3 == 0)? 1: ((f3 == 1)?	2: ((f3 == 4)? 3 : ((f3 == 5)? 4: ((f3 == 6)? 5 : 0))));
assign selSLT = (opcode == 51 && f3 == 2)? 1:0;

endmodule
