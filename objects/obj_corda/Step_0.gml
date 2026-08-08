if (cortada) {
    // Solta o objeto preso para que a gravidade faça ele cair
    if (meu_objeto_preso != noone && instance_exists(meu_objeto_preso)) {
        with (meu_objeto_preso) {
            gravity = 0.5; // Ativa a queda na vertical
        }
    }
    
    // Opcional: crie estilhaços de corda ou partículas aqui antes de destruir
    instance_destroy();
}