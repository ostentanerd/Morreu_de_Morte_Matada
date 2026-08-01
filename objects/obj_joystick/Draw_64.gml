
/*


var _gui_x = device_mouse_x_to_gui(0);
var _gui_y = device_mouse_y_to_gui(0);

// Esconde o cursor do Windows
window_set_cursor(cr_none);

// Desenha a mira (com frame animado + rotação + posição na GUI)
draw_sprite_ext(
    spr_mira,           // Sprite da mira
    mira_frame,         // Usa a variável que muda o frame no clique
    _gui_x, _gui_y,     // Posição no mouse
    1, 1,               // Escala normal (1x)
    aim_angle,          // Rotação apontando na direção da mira
    c_white,            // Cor padrão
    1                   // Opacidade 100%
);