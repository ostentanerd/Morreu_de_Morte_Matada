if (caindo) {
    // Spawna os estilhaços ao bater no chão
    repeat (4) {
        instance_create_layer(x, y, "Instances", obj_estilhaco);
    }
    
    // Como bateu no chão e NÃO na vítima, ativa a tela de derrota!
    if (instance_exists(obj_controle)) {
        obj_controle.game_over = true;
		
    }
    
    instance_destroy();
}

// No evento de impacto/destruição do obj_armadilha:
if (instance_exists(obj_controle)) {
    obj_controle.shake_time = 12;      // Dura 12 frames (~0.2 segundos)
    obj_controle.shake_magnitude = 4; // Intensidade do tremor em pixels
}