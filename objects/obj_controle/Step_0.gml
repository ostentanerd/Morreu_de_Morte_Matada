if (instance_exists(obj_joystick)) {
    // Animação do frame da mira
    mira_frame = obj_joystick.input_aim ? 1 : 0;
    
    // REINICIAR A SALA
    if (obj_joystick.input_reset) {
        // Reseta o estado de game over ANTES de dar o restart
        game_over = false;
        
        // Limpa o botão para evitar loop infinito
        obj_joystick.input_reset = false;
        
        // Reinicia a fase
        room_restart();
    }
}