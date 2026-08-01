// Desenha a própria sprite do jogador
draw_self();

// Desenha a linha guia vermelha enquanto o jogador estiver segurando o botão de mirar
if (instance_exists(obj_joystick)) {
    if (obj_joystick.input_aim) {
        var _dir = obj_joystick.aim_angle;
        
        // Comprimento da linha vermelha (250 pixels)
        var _target_x = x + lengthdir_x(250, _dir);
        var _target_y = y + lengthdir_y(250, _dir);
        
        // Desenha a linha de mira
        draw_set_color(c_red);
        draw_line_width(x, y, _target_x, _target_y, 2);
        
        // IMPORTANTE: Reseta a cor de desenho de volta para branco!
        draw_set_color(c_white); 
    }
}