// Código do SO
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
addi $x3, $zero, 3
addi $x4, $zero, 63 // 32 + 30 + 1
.INICIO_LOOP: // do {
lw $aux_so, $x3(0) // Transfere dados de registradores para o fim da fila
sw $aux_so, $x3(30)
addi $x3, $x3, 1
bne $x3, $x4, INICIO_LOOP // } while (x3 != 63)
nop
lw $aux_so $zero(0); // $aux_so <-- PC próximo
lw $x5 $zero(0); // $aux_so <-- PC anterior (preemptado ou finalizado)
sw $x5 $zero(2); // Transfere PC para o fim da fila
// começa recuperação dos registradores
addi $x6, $x6, 30
lw $x0, $x6(3)
lw $x1, $x6(4)
lw $x2, $x6(5)
lw $x3, $x6(6)
lw $x4, $x6(7)
lw $x5, $x6(8)
lw $x6, $x6(9)
lw $x7, $x6(10)
lw $x8, $x6(11)
lw $x9, $x6(12)
lw $x10, $x6(13)
lw $x11, $x6(14)
lw $x12, $x6(15)
lw $x13, $x6(16)
lw $x14, $x6(17)
lw $x15, $x6(18)
lw $x16, $x6(19)
lw $x17, $x6(20)
lw $x18, $x6(21)
lw $x19, $x6(22)
lw $x20, $x6(23)
lw $x21, $x6(24)
lw $x22, $x6(25)
lw $x23, $x6(26)
lw $x24, $x6(27)
lw $aux, $x6(28)
lw $rv, $x6(29)
lw $fp, $x6(30)
lw $sp, $x6(31)
lw $ra, $x6(32)
// termina recuperação dos registradores 
jr_flush_id_proc $aux_so // Parte para execução do programa escalonado