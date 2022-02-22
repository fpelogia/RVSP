// Código do SO
// aux_so tem o valor do PC do processo anterior
sw $aux_so, $zero(0) //aux_so é o registrador de endereço 25
// começa salvamento dos registradores
beq $aux_so, $zero, NAO_SALVA
sw $x0, $zero(3)
sw $x1, $zero(4)
sw $x2, $zero(5)
sw $x3, $zero(6)
sw $x4, $zero(7)
sw $x5, $zero(8)
sw $x6, $zero(9)
sw $x7, $zero(10)
sw $x8, $zero(11)
sw $x9, $zero(12)
sw $x10, $zero(13)
sw $x11, $zero(14)
sw $x12, $zero(15)
sw $x13, $zero(16)
sw $x14, $zero(17)
sw $x15, $zero(18)
sw $x16, $zero(19)
sw $x17, $zero(20)
sw $x18, $zero(21)
sw $x19, $zero(22)
sw $x20, $zero(23)
sw $x21, $zero(24)
sw $x22, $zero(25)
sw $x23, $zero(26)
sw $x24, $zero(27)
sw $aux, $zero(28)
sw $rv, $zero(29)
sw $fp, $zero(30)
sw $sp, $zero(31)
sw $ra, $zero(32)
.NAO_SALVA:
// termina salvamento dos registradores 
lw $x0, $zero(1) // $x0 <-- id_proc
bne $x0, $zero, ELSE_ID_0 // if (id_proc == 0)
nop
addi $x1, $zero, 1
sw $x1, $zero(1) // id_proc <-- 1
jal $aux_so .FIM_ELSE_ID_0
nop
.ELSE_ID_0: // else
addi $x1, $zero, 2
bne $x0, $x1, ELSE_ID_2 //if (id_proc == 2)
nop
addi $x1, $zero, 1
sw $x1, $zero(1) // id_proc <-- 1
jal $aux_so .FIM_ELSE_ID_2
nop
.ELSE_ID_2: // else
addi $x2, $x0, 1
sw $x2, $zero(1) // id_proc <-- id_proc + 1 
.FIM_ELSE_ID_2:
.FIM_ELSE_ID_0:
// começa recuperação dos registradores
addi $aux_so, $zero, 30
lw $x0, $aux_so(3)
lw $x1, $aux_so(4)
lw $x2, $aux_so(5)
lw $x3, $aux_so(6)
lw $x4, $aux_so(7)
lw $x5, $aux_so(8)
lw $x6, $aux_so(9)
lw $x7, $aux_so(10)
lw $x8, $aux_so(11)
lw $x9, $aux_so(12)
lw $x10, $aux_so(13)
lw $x11, $aux_so(14)
lw $x12, $aux_so(15)
lw $x13, $aux_so(16)
lw $x14, $aux_so(17)
lw $x15, $aux_so(18)
lw $x16, $aux_so(19)
lw $x17, $aux_so(20)
lw $x18, $aux_so(21)
lw $x19, $aux_so(22)
lw $x20, $aux_so(23)
lw $x21, $aux_so(24)
lw $x22, $aux_so(25)
lw $x23, $aux_so(26)
lw $x24, $aux_so(27)
lw $aux, $aux_so(28)
lw $rv, $aux_so(29)
lw $fp, $aux_so(30)
lw $sp, $aux_so(31)
lw $ra, $aux_so(32)
// termina recuperação dos registradores 
addi $aux, $zero, 3
addi $ra, $zero, 33
.INICIO_LOOP: // do {
lw $aux_so, $aux(0) // Transfere dados de registradores para o fim da fila
sw $aux_so, $aux(30)
addi $aux, $aux, 1
bne $aux, $ra, INICIO_LOOP // } while (x3 != 63)
nop
addi x1, $zero, 100 
OUT x1
lw $aux_so $zero(2); // $aux_so <-- PC próximo
lw $ra $zero(0); // $aux_so <-- PC anterior (preemptado ou finalizado)
sw $ra $zero(2); // Transfere PC para o fim da fila
jr_ctx $aux_so // Parte para execução do programa escalonado