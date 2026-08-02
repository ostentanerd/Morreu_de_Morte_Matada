// Pega a largura e altura da interface gráfica (GUI)
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (_gui_w <= 0) _gui_w = window_get_width();
if (_gui_h <= 0) _gui_h = window_get_height();

// Pega a posição do ponteiro do mouse na camada de GUI
var _gui_x = device_mouse_x_to_gui(0);
var _gui_y = device_mouse_y_to_gui(0);

// Garante que o cursor do Windows permaneça oculto
window_set_cursor(cr_none);

// -------------------------------------------------------------
// A. TELA DE GAME OVER / DERROTA
// -------------------------------------------------------------
if (game_over == true) {
    // Desenha overlay escuro com 60% de opacidade
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Mensagem de erro em vermelho
    draw_set_color(c_red);
    draw_text(_gui_w / 2, _gui_h / 2 - 15, "ALVO ERRADO!");
    
    // Instrução em branco
    draw_set_color(c_white);
    draw_text(_gui_w / 2, _gui_h / 2 + 10, "Pressione 'R' para Reiniciar");
    
    // Reseta o alinhamento do texto
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// -------------------------------------------------------------
// B. TELA DE VITÓRIA
// -------------------------------------------------------------
if (vitoria == true && !em_loading) {
    // Overlay escuro transparente
    draw_set_color(c_black);
    draw_set_alpha(0.6);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Mensagem de sucesso em verde limão
    draw_set_color(c_lime);
    draw_text(_gui_w / 2, _gui_h / 2 - 15, "ALVO ELIMINADO!");
    
    // Instrução para avançar de fase usando a tecla E
    draw_set_color(c_white);
    draw_text(_gui_w / 2, _gui_h / 2 + 10, "Pressione 'E' para a Próxima Fase");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// -------------------------------------------------------------
// C. TELA DE CARREGAMENTO (LOADING)
// -------------------------------------------------------------
if (em_loading == true) {
    // Fundo 100% preto opaco
    draw_set_color(c_black);
    draw_set_alpha(1.0);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_set_color(c_white);
    
    // Animação de pontinhos piscando a cada 250ms
    var _pontos = string_repeat(".", (current_time div 250) mod 4);
    draw_text(_gui_w / 2, _gui_h / 2, "CARREGANDO" + _pontos);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// Garante resete de opacidade e cor para os próximos desenhos
draw_set_alpha(1.0);
draw_set_color(c_white);

// -------------------------------------------------------------
// D. DESENHO DA MIRA CUSTOMIZADA (Oculta apenas durante o Loading)
// -------------------------------------------------------------
if (!em_loading) {
    var _ang = 0;
    if (instance_exists(obj_joystick)) {
        _ang = obj_joystick.aim_angle; // Ângulo de rotação vindo do analógico/mouse
    }

    if (sprite_exists(spr_mira)) {
        draw_sprite_ext(
            spr_mira,    // Sprite da mira
            mira_frame,  // Frame 0 (normal) ou Frame 1 (pressionado)
            _gui_x,      // Posição X da GUI
            _gui_y,      // Posição Y da GUI
            2, 2,        // Escala 2x
            _ang,        // Ângulo de rotação
            c_white,     // Cor de mescla
            1            // Opacidade total
        );
    }
}