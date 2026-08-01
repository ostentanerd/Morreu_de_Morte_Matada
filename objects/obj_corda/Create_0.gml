// Procura uma armadilha logo abaixo da corda (em um raio de 32 pixels para baixo)
meu_objeto_preso = instance_place(x, y + 32, obj_armadilha);

// Se não achou logo colada, busca a armadilha mais próxima abaixo dela
if (meu_objeto_preso == noone) {
    meu_objeto_preso = instance_nearest(x, y + 16, obj_armadilha);
}