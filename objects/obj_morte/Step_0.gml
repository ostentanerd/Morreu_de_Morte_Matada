if (instance_exists(obj_joystick)) {
    
    // Pega o estado do game_over no controle (se existir)
    var _esta_em_game_over = false;
    if (instance_exists(obj_controle)) {
        _esta_em_game_over = obj_controle.game_over;
    }
    
    // SÓ PERMITE ATIRAR SE NÃO ESTIVER EM GAME OVER!
    if (!_esta_em_game_over) {
        if (obj_joystick.input_shoot) {
            if (!instance_exists(obj_foice)) {
                var _foice = instance_create_layer(x, y, "Instances", obj_foice);
                _foice.direction = obj_joystick.aim_angle;
                _foice.speed = 12;
            }
        }
    }
}