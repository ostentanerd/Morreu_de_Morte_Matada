if (instance_exists(obj_joystick)) {
    
    // -------------------------------------------------------------
    // 1. VIRA O PERSONAGEM PARA O LADO DA MIRA
    // -------------------------------------------------------------
    var _angle = obj_joystick.aim_angle;

    // Se o ângulo da mira estiver apontando para a esquerda (entre 90° e 270°)
    if (_angle > 90 && _angle < 270) {
        image_xscale = -1; // Vira para a esquerda
    } else {
        image_xscale = 1;  // Vira para a direita
    }

    // -------------------------------------------------------------
    // 2. LÓGICA DE DISPARO DA FOICE
    // -------------------------------------------------------------
    var _bloqueado = false;

    if (instance_exists(obj_controle)) {
        _bloqueado = obj_controle.game_over || obj_controle.vitoria || obj_controle.em_loading;
    }

    // Só permite atirar se não estiver bloqueado
    if (!_bloqueado) {
        if (obj_joystick.input_shoot) {
            if (!instance_exists(obj_foice)) {
                var _foice = instance_create_layer(x, y, "Instances", obj_foice);
                _foice.direction = _angle;
                _foice.image_angle = _angle;
                _foice.speed = 12;

                // Consome o tiro para não disparar no mesmo frame novamente
                obj_joystick.input_shoot = false;
            }
        }
    }
}