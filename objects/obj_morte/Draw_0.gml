draw_self();

// Só desenha a mira se estiver mirando E NÃO estiver em Game Over
if (instance_exists(obj_joystick)) {
    var _esta_em_game_over = false;
    if (instance_exists(obj_controle)) {
        _esta_em_game_over = obj_controle.game_over;
    }
    
    if (obj_joystick.input_aim && !_esta_em_game_over) {
        var _dir = obj_joystick.aim_angle;
        var _target_x = x + lengthdir_x(250, _dir);
        var _target_y = y + lengthdir_y(250, _dir);
        
        draw_set_color(c_red);
        draw_line_width(x, y, _target_x, _target_y, 2);
        draw_set_color(c_white);
    }
}