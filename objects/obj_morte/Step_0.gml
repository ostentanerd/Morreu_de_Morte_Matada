if (instance_exists(obj_joystick)) {
    
    var _bloqueado = false;
    
    if (instance_exists(obj_controle)) {
        _bloqueado = obj_controle.game_over || obj_controle.vitoria || obj_controle.em_loading;
    }
    
    // SÓ PERMITE ATIRAR SE NÃO ESTIVER BLOQUEADO
    if (!_bloqueado) {
        if (obj_joystick.input_shoot) {
            if (!instance_exists(obj_foice)) {
                var _foice = instance_create_layer(x, y, "Instances", obj_foice);
                _foice.direction = obj_joystick.aim_angle;
                _foice.image_angle = obj_joystick.aim_angle; // <--- ADICIONE ESTA LINHA PARA A FOICE GIRAR VISUALMENTE
                _foice.speed = 12;
                
                // Consome o tiro para não disparar no mesmo frame novamente
                obj_joystick.input_shoot = false;
            }
        }
    }
}