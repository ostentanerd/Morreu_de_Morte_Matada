/*/ 'other' se refere à corda específica que foi atingida pela foice
with (other) {
    // Se essa corda tiver um objeto preso associado a ela
    if (meu_objeto_preso != noone && instance_exists(meu_objeto_preso)) {
        // Solta a armadilha!
        meu_objeto_preso.caindo = true;
    }
    
    // Opcional: Criar efeito de partículas/som de corda cortando
    
    // Destrói a corda (dando o efeito de que foi cortada)
    instance_destroy();
}

// A foice continua voando normal depois de cortar a corda!