// Atualiza a animação da mira lendo a saída do obj_joystick
if (instance_exists(obj_joystick)) {
    if (obj_joystick.input_aim) {
        mira_frame = 1; // Pressionado
    } else {
        mira_frame = 0; // Normal
    }
    
    // Se o botão de reset for acionado
    if (obj_joystick.input_reset) {
        room_restart();
    }
}