if (instance_exists(obj_joystick)) {
    
    // -------------------------------------------------------------
    // 1. VIRA O PERSONAGEM PARA O LADO DA MIRA
    // -------------------------------------------------------------
    var _angle = obj_joystick.aim_angle;

    if (_angle > 90 && _angle < 270) {
        image_xscale = -1; // Vira para a esquerda
    } else {
        image_xscale = 1;  // Vira para a direita
    }

    // -------------------------------------------------------------
    // 2. LÓGICA DE DISPARO DA FOICE (MÁXIMO DE 1 POR TENTATIVA)
    // -------------------------------------------------------------
    var _bloqueado = false;

    if (instance_exists(obj_controle)) {
        // Bloqueia se deu Game Over, Vitória, Loading OU se a foice JÁ FOI LANÇADA nesta tentativa!
        _bloqueado = obj_controle.game_over || obj_controle.vitoria || obj_controle.em_loading || obj_controle.foice_lancada;
    }

    // Só permite atirar se NADA estiver bloqueado
    if (!_bloqueado) {
        if (obj_joystick.input_shoot) {
            if (!instance_exists(obj_foice)) {
                
                // Cria a foice
                var _foice = instance_create_layer(x, y, "Instances", obj_foice);
                _foice.direction = _angle;
                _foice.image_angle = _angle;
                _foice.speed = 08;

                // TRAVA DEFINITIVA: Avisa o controle que o tiro único da rodada já foi usado!
                if (instance_exists(obj_controle)) {
                    obj_controle.foice_lancada = true;
                }

                // Consome o botão de tiro
                obj_joystick.input_shoot = false;
            }
        }
    }
}