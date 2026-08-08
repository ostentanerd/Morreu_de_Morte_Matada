cortada = false;

// Trça uma linha invisível reto para baixo (ex: até 128 pixels abaixo da corda)
// Procura por qualquer objeto filho de obj_armadilha_pai (ou obj_lustre)
meu_objeto_preso = collision_line(x, y, x, y + 128, obj_armadilha_pai, false, true);

// Se encontrou o lustre/armadilha pendurado:
if (meu_objeto_preso != noone) {
    with (meu_objeto_preso) {
        gravity = 0; // Mantém o lustre preso no ar sem cair
        speed = 0;
    }
}