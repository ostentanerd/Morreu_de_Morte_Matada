var _gui_x = device_mouse_x_to_gui(0);
var _gui_y = device_mouse_y_to_gui(0);

// Garante que o cursor continue escondido
window_set_cursor(cr_none);

// Pega o ângulo de mira atual do joystick
var _ang = 0;
if (instance_exists(obj_joystick)) {
    _ang = obj_joystick.aim_angle;
}

// Desenha a mira (com frame animado + rotação + posição na GUI)
if (sprite_exists(spr_mira)) {
    draw_sprite_ext(
        spr_mira,           // Sprite da mira
        mira_frame,         // Frame 0 ou 1
        _gui_x, _gui_y,     // Posição no mouse/GUI
        2, 2,               // Escala 1x
        _ang,               // Rotação vinda do joystick
        c_white,            // Cor
        1                   // Opacidade
    );
}