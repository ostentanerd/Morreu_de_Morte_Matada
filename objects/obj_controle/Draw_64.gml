// =============================================================
// CONFIGURAÇÕES INICIAIS DA TELA E DO MOUSE (GUI)
// =============================================================

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (_gui_w <= 0) _gui_w = window_get_width();
if (_gui_h <= 0) _gui_h = window_get_height();

var _gui_x = device_mouse_x_to_gui(0);
var _gui_y = device_mouse_y_to_gui(0);

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
    
    // 🔤 1. ATIVA A FONTE GRANDE PARA O TÍTULO DE ERRO
    draw_set_font(fnt_titulo); 
    
    // Mensagem de erro em vermelho (Ajuste vertical para -40 para caber o texto maior)
    draw_set_color(c_red);
    draw_text(_gui_w / 2, _gui_h / 2 - 80, "ALVO ERRADO!");
    
    // 🔤 2. VOLTA PARA A FONTE MENOR PARA A INSTRUÇÃO
    draw_set_font(fnt_dica); 
    
    // Instrução em branco (Ajuste vertical para +20)
    draw_set_color(c_white);
    draw_text(_gui_w / 2, _gui_h / 2 + 20, "Pressione 'R' para Reiniciar");
    
    // Reseta alinhamento
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
    
    // 🔤 1. ATIVA A FONTE GRANDE PARA O TÍTULO DE SUCESSO
    draw_set_font(fnt_titulo); 
    
    // Mensagem de sucesso em verde limão (Ajuste vertical para -40)
    draw_set_color(c_lime);
    draw_text(_gui_w / 2, _gui_h / 2 - 80, "ALVO ELIMINADO!");
    
    // 🔤 2. VOLTA PARA A FONTE MENOR PARA A INSTRUÇÃO
    draw_set_font(fnt_dica); 
    
    // Instrução em branco (Ajuste vertical para +20)
    draw_set_color(c_white);
    draw_text(_gui_w / 2, _gui_h / 2 + 20, "Pressione 'E' para a Próxima Fase");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// -------------------------------------------------------------
// C. TELA DE CARREGAMENTO (COM ARTE E DICAS) - SEM ALTERAÇÃO
// -------------------------------------------------------------
if (em_loading == true) {
    
    draw_set_alpha(alpha_loading);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    
    if (sprite_exists(arte_escolhida)) {
        draw_sprite_stretched_ext(arte_escolhida, 0, 0, 0, _gui_w, _gui_h, c_white, alpha_loading);
    }
    
    draw_set_alpha(1.0); 
    
    // 🔤 ATIVA A FONTE PRÓPRIA PARA O LOADING (Mantém o tamanho normal)
    draw_set_font(fnt_dica); 
    
    draw_set_color(c_white);
    draw_set_halign(fa_right);
    draw_set_valign(fa_top); 
    var _pontos = string_repeat(".", (current_time div 250) mod 4);
    draw_text(_gui_w - 20, 20, "CARREGANDO" + _pontos);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var _pos_y_dica = _gui_h - 100; 
    
    draw_set_color(c_black);
    draw_text((_gui_w / 2) + 2, _pos_y_dica + 2, dica_escolhida);
    
    draw_set_color(c_white);
    draw_text(_gui_w / 2, _pos_y_dica, dica_escolhida);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1.0);
}

// -------------------------------------------------------------
// D. DESENHO DA MIRA CUSTOMIZADA (MOUSE OU CONTROLE LIVRE)
// -------------------------------------------------------------
if (!em_loading) {
    var _mira_x = 0;
    var _mira_y = 0;
    var _ang = 0;
    var _usando_controle = false;
    
    if (instance_exists(obj_joystick)) {
        _usando_controle = obj_joystick.using_gamepad;
        _ang = obj_joystick.aim_angle;
    }

    if (_usando_controle) {
        // SE FOR CONTROLE: A mira se move de forma livre pela tela com o analógico direito
        var _pad = obj_joystick.gamepad_slot;
        var _axis_x = 0;
        var _axis_y = 0;
        
        if (_pad != -1 && gamepad_is_connected(_pad)) {
            _axis_x = gamepad_axis_value(_pad, gp_axisrh);
            _axis_y = gamepad_axis_value(_pad, gp_axisrv);
        }
        
        // Se você quiser que a mira comece no centro da tela e se mova livremente:
        // (Ou você pode trocar (_gui_w/2, _gui_h/2) pelas coordenadas x e y do player se preferir que ela saia dele)
        var _centro_x = _gui_w / 2;
        var _centro_y = _gui_h / 2;
        
        // Velocidade/Alcance com que o analógico empurra a mira pela tela
        var _velocidade_mira = 15; 
        
        // Guarda a posição atual da mira no controle para ela não teleportar para o centro toda vez
        if (!variable_instance_exists(id, "gp_cursor_x")) {
            gp_cursor_x = _centro_x;
            gp_cursor_y = _centro_y;
        }
        
        // Move o cursor livremente baseado no analógico
        gp_cursor_x += _axis_x * _velocidade_mira;
        gp_cursor_y += _axis_y * _velocidade_mira;
        
        // Trava para a mira não sair dos limites da tela
        gp_cursor_x = clamp(gp_cursor_x, 50, _gui_w - 50);
        gp_cursor_y = clamp(gp_cursor_y, 50, _gui_h - 50);
        
        _mira_x = gp_cursor_x;
        _mira_y = gp_cursor_y;
    } 
    else {
        // SE FOR MOUSE: Segue o cursor normal da tela
        _mira_x = device_mouse_x_to_gui(0);
        _mira_y = device_mouse_y_to_gui(0);
        
        // Atualiza a posição do controle para acompanhar o mouse se houver troca de input
        gp_cursor_x = _mira_x;
        gp_cursor_y = _mira_y;
    }

    if (sprite_exists(spr_mira)) {
        draw_sprite_ext(
            spr_mira,    
            mira_frame,  
            _mira_x,     
            _mira_y,     
            2, 2,        
            _usando_controle ? _ang : 0, 
            c_white,     
            1            
        );
    }
}