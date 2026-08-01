// 1. Pega a largura e altura da GUI (com trava de segurança contra valor 0)
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (_gui_w <= 0) _gui_w = window_get_width();
if (_gui_h <= 0) _gui_h = window_get_height();

// Pega as posições do mouse na interface
var _gui_x = device_mouse_x_to_gui(0);
var _gui_y = device_mouse_y_to_gui(0);

// Garante que o cursor do sistema continue escondido
window_set_cursor(cr_none);

// -------------------------------------------------------------
// 1. TELA DE GAME OVER (SÓ DESENHA SE ESTIVER REALMENTE EM GAME OVER)
// -------------------------------------------------------------
if (game_over == true) {
    // Escurece o fundo
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    
    // RESETA O ALPHA NA HORA para não deixar nada mais invisível
    draw_set_alpha(1.0);
    
    // Configura alinhamento do texto ao centro
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Mensagem de Derrota
    draw_set_color(c_red);
    draw_text(_gui_w / 2, _gui_h / 2 - 15, "VOCE ERROU!");
    
    draw_set_color(c_white);
    draw_text(_gui_w / 2, _gui_h / 2 + 10, "Pressione 'R' ou SELECT para tentar de novo");
    
    // Reseta alinhamentos para o padrão
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

// RESETA O ALPHA E A COR (Garante que a mira e o jogo desenhem normal)
draw_set_alpha(1.0);
draw_set_color(c_white);

// -------------------------------------------------------------
// 2. DESENHO DA MIRA (DESENHADA POR CIMA DA INTERFACE)
// -------------------------------------------------------------
var _ang = 0;
if (instance_exists(obj_joystick)) {
    _ang = obj_joystick.aim_angle;
}

if (sprite_exists(spr_mira)) {
    draw_sprite_ext(
        spr_mira,           // Sprite da mira
        mira_frame,         // Frame 0 ou 1
        _gui_x, _gui_y,     // Posição no mouse/GUI
        2, 2,               // Escala 2x
        _ang,               // Rotação vinda do joystick
        c_white,            // Cor
        1                   // Opacidade
    );
}