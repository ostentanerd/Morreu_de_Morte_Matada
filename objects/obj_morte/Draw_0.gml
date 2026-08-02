draw_self();

if (instance_exists(obj_joystick)) {
    
    // Verifica se a mira deve ser bloqueada
    var _bloqueado = false;
    
    if (instance_exists(obj_controle)) {
        // Esconde a mira se deu Game Over, se Venceu ou se está no Loading
        _bloqueado = obj_controle.game_over || obj_controle.vitoria || obj_controle.em_loading;
    }
    
    // SÓ DESENHA A LINHA VERMELHA SE ESTIVER MIRANDO E NÃO ESTIVER BLOQUEADO
    if (obj_joystick.input_aim && !_bloqueado) {
        var _dir = obj_joystick.aim_angle;
        var _target_x = x + lengthdir_x(250, _dir);
        var _target_y = y + lengthdir_y(250, _dir);
        
        draw_set_color(c_red);
        draw_line_width(x, y, _target_x, _target_y, 2);
        
        // Sempre reseta a cor para c_white após desenhar linhas ou formas
        draw_set_color(c_white);
    }
}