/*

   Código do Sistema Operacional em C-
   Autor: Frederico José Ribeiro Pelogia (133619)
   Lab. de Sistemas Operacionais 2021.2

=========================================
    Utilização da Memória de Dados
      ╔═════════╗
    0 ║ PC_ant  ║
    1 ║ id_proc ║
    2 ║ PC_prox ║
    3 ║ $x0     ║---
   ...║         ║   |-> registradores do processo anterior
   32 ║ $ra     ║---
   33 ║ $x0     ║---
  ... ║         ║   |-> registradores do próximo processo 
   62 ║ $ra     ║---
      ╚═════════╝ 
=========================================
*/
void salva_pc(){
    int x;
    x = salva_pc();
    /* Espaço na MD reservado ao SO */
    MD_write(x, 0);
}

void salva_regs(){
    MD_write(0, 3);
    MD_write(1, 4);
    MD_write(2, 5);
    MD_write(3, 6);
    MD_write(4, 7);
    MD_write(5, 8);
    MD_write(6, 9);
    MD_write(7, 10);
    MD_write(8, 11);
    MD_write(9, 12);
    MD_write(10, 13);
    MD_write(11, 14);
    MD_write(12, 15);
    MD_write(13, 16);
    MD_write(14, 17);
    MD_write(15, 18);
    MD_write(16, 19);
    MD_write(17, 20);
    MD_write(18, 21);
    MD_write(19, 22);
    MD_write(20, 23);
    MD_write(21, 24);
    MD_write(22, 25);
    MD_write(23, 26);
    MD_write(24, 27);
    MD_write(27, 28);
    MD_write(28, 29);
    MD_write(29, 30);
    MD_write(30, 31);
    MD_write(31, 32);
}

void recupera_regs(){
    int desl = 30; //usa $aux_so
    MD_read(0, 3 + desl);
    MD_read(1, 4 + desl);
    MD_read(2, 5 + desl);
    MD_read(3, 6 + desl);
    MD_read(4, 7 + desl);
    MD_read(5, 8 + desl);
    MD_read(6, 9 + desl);
    MD_read(7, 10 + desl);
    MD_read(8, 11 + desl);
    MD_read(9, 12 + desl);
    MD_read(10, 13 + desl);
    MD_read(11, 14 + desl);
    MD_read(12, 15 + desl);
    MD_read(13, 16 + desl);
    MD_read(14, 17 + desl);
    MD_read(15, 18 + desl);
    MD_read(16, 19 + desl);
    MD_read(17, 20 + desl);
    MD_read(18, 21 + desl);
    MD_read(19, 22 + desl);
    MD_read(20, 23 + desl);
    MD_read(21, 24 + desl);
    MD_read(22, 25 + desl);
    MD_read(23, 26 + desl);
    MD_read(24, 27 + desl);
    MD_read(27, 28 + desl);
    MD_read(28, 29 + desl);
    MD_read(29, 30 + desl);
    MD_read(30, 31 + desl);
    MD_read(31, 32 + desl);
}



void main(void) { 
    /* Aqui começa a execução do SO */
    int id_proc;
    int novo_id_proc;
    int pc_ant;

    pc_ant = get_pc_ant();
    salva_pc(pc_ant);
    if(pc_ant != 0){ 
        /* Salva registradores do processo preemptado */
        salva_regs();
    }

    MD_read(id_proc, 1); /* Lê id do processo anterior */
    if(id_proc == 0){
        id_proc = 1;
        MD_write(id_proc, 1);
    }else{
        if(id_proc == 2){
            id_proc = 1;
            MD_write(id_proc, 1);
        }else{
            novo_id_proc = id_proc + 1; /* Avança fila */
            MD_write(novo_id_proc, 1);
        }
    }  

    apaga_display_7s();

    /* Recupera dados do processo a ser executado */
    recupera_regs(id_proc);


    /* Avança fila, transferindo dados salvos */
    while(base != 33){
        MD_read(temp, base + 3);
        MD_write(temp, base + 30);
        base = base + 1        
    }

    /* Recupera PC do processo a ser executado */
    MD_read(pc_prox, 2);

    /* Avança fila, transferindo PC_ant para MD[2] */
    MD_read(temp, 1);
    MD_write(temp, 2);

    jr_ctx(pc_prox); /* Seta PC e executa proc. MD[1] */

}