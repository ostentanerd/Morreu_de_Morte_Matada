// 'other' é a corda que a foice acabou de tocar
with (other) {
    // Se a corda encontrou uma armadilha perto dela
    if (meu_objeto_preso != noone && instance_exists(meu_objeto_preso)) {
        meu_objeto_preso.caindo = true; // Ativa a queda!
    }
    
    // Destrói a corda (efeito de corte)
    instance_destroy();
}