// Se a foice foi destruída e a vítima AINDA ESTÁ VIVA na fase, o arremesso falhou!
if (instance_exists(obj_vitima)) {
    // Checa se nenhum objetivo de vitória foi acionado (ex: o lustre caindo)
    // Se a vítima continuar viva após a foice sumir, reinicia a fase em 1 segundo
    if (instance_exists(obj_joystick)) {
        // Reinicia a fase para tentar novamente
        alarm_set(0, 60); // Opcional: ou chama room_restart() direto
    }
}