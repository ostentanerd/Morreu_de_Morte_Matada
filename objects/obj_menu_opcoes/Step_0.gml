var _gui_w = display_get_gui_width();

// -------------------------------------------------------------
// 0. ATUALIZAÇÃO DA TRANSIÇÃO DE FADE
// -------------------------------------------------------------
alpha = lerp(alpha, alpha_alvo, velocidade_fade);

if (fechando) {
    if (alpha <= 0.02) {
        if (instance_exists(obj_controle)) obj_controle.scr_salvar_opcoes();
        io_clear();
        instance_destroy();
    }
    exit;
}

// -------------------------------------------------------------
// 1. CÁLCULO DAS POSIÇÕES REAIS DAS BARRAS E TEXTOS
// -------------------------------------------------------------
var _musica_bx1 = (_gui_w / 2) - 80;
var _musica_by1 = start_y + (0 * espacamento) - (bar_altura / 2);

var _sfx_bx1 = (_gui_w / 2) - 80;
var _sfx_by1 = start_y + (1 * espacamento) - (bar_altura / 2);

// Área dinâmica da opção "VOLTAR" baseada no tamanho da fonte
draw_set_font(fnt_dica);
var _txt_w = string_width(opcoes[2]);
var _txt_h = string_height(opcoes[2]);

var _voltar_x1 = (_gui_w / 2) - (_txt_w / 2) - 15; // Margem de clique à esquerda
var _voltar_x2 = (_gui_w / 2) + (_txt_w / 2) + 15; // Margem de clique à direita
var _voltar_y1 = start_y + (2 * espacamento) - (_txt_h / 2) - 5;
var _voltar_y2 = start_y + (2 * espacamento) + (_txt_h / 2) + 5;

// -------------------------------------------------------------
// 2. CONTROLE DO MOUSE (CLIQUE E ARRASTO)
// -------------------------------------------------------------
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

var _clique_inicio    = device_mouse_check_button_pressed(0, mb_left);
var _segurando_clique = device_mouse_check_button(0, mb_left);
var _soltou_clique    = device_mouse_check_button_released(0, mb_left);

// --- BARRA DE MÚSICA (HOVER & ARRASTO) ---
if (point_in_rectangle(_mx, _my, _musica_bx1 - 100, _musica_by1, _musica_bx1 + bar_largura, _musica_by1 + bar_altura)) {
    opc_selecionada = 0;
}

if (_clique_inicio && point_in_rectangle(_mx, _my, _musica_bx1, _musica_by1, _musica_bx1 + bar_largura, _musica_by1 + bar_altura)) {
    arrastando_musica = true;
    opc_selecionada = 0;
}

if (arrastando_musica) {
    if (_segurando_clique) {
        global.vol_musica = clamp((_mx - _musica_bx1) / bar_largura, 0.0, 1.0);
        if (global.musica_atual != -1) {
            audio_sound_gain(global.musica_atual, global.vol_musica, 0);
        }
    }
    if (_soltou_clique) {
        arrastando_musica = false;
        if (instance_exists(obj_controle)) obj_controle.scr_salvar_opcoes();
    }
}

// --- BARRA DE SFX (HOVER & ARRASTO) ---
if (point_in_rectangle(_mx, _my, _sfx_bx1 - 100, _sfx_by1, _sfx_bx1 + bar_largura, _sfx_by1 + bar_altura)) {
    opc_selecionada = 1;
}

if (_clique_inicio && point_in_rectangle(_mx, _my, _sfx_bx1, _sfx_by1, _sfx_bx1 + bar_largura, _sfx_by1 + bar_altura)) {
    arrastando_sfx = true;
    opc_selecionada = 1;
}

if (arrastando_sfx) {
    if (_segurando_clique) {
        global.vol_sfx = clamp((_mx - _sfx_bx1) / bar_largura, 0.0, 1.0);
    }
    if (_soltou_clique) {
        arrastando_sfx = false;
        if (instance_exists(obj_audio)) obj_audio.tocar_sfx(snd_menu_navegar);
        if (instance_exists(obj_controle)) obj_controle.scr_salvar_opcoes();
    }
}

// --- CLIQUE E HOVER NA OPÇÃO "VOLTAR" ---
if (point_in_rectangle(_mx, _my, _voltar_x1, _voltar_y1, _voltar_x2, _voltar_y2)) {
    opc_selecionada = 2; // Destaca o texto "VOLTAR" em amarelo ao passar o mouse
    
    if (_clique_inicio) {
        if (instance_exists(obj_audio)) obj_audio.tocar_sfx(snd_menu_clique);
        fechando = true;
        alpha_alvo = 0;
    }
}

// -------------------------------------------------------------
// 3. LEITURA DOS INPUTS (TECLADO E GAMEPAD)
// -------------------------------------------------------------
var _cima      = keyboard_check_pressed(vk_up)    || keyboard_check_pressed(ord("W"));
var _baixo     = keyboard_check_pressed(vk_down)  || keyboard_check_pressed(ord("S"));
var _esquerda  = keyboard_check(vk_left)          || keyboard_check(ord("A"));
var _direita   = keyboard_check(vk_right)         || keyboard_check(ord("D"));
var _confirmar = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("E"));
var _voltar    = keyboard_check_pressed(vk_escape);

if (instance_exists(obj_joystick)) {
    _confirmar = _confirmar || obj_joystick.input_next;
    var _pad = obj_joystick.gamepad_slot;
    if (_pad != -1 && gamepad_is_connected(_pad)) {
        var _gp_cima   = gamepad_button_check_pressed(_pad, gp_padu) || (gamepad_axis_value(_pad, gp_axislv) < -0.5);
        var _gp_baixo  = gamepad_button_check_pressed(_pad, gp_padd) || (gamepad_axis_value(_pad, gp_axislv) > 0.5);
        var _gp_esq    = gamepad_button_check(_pad, gp_padl)        || (gamepad_axis_value(_pad, gp_axislh) < -0.5);
        var _gp_dir    = gamepad_button_check(_pad, gp_padr)        || (gamepad_axis_value(_pad, gp_axislh) > 0.5);
        var _gp_voltar = gamepad_button_check_pressed(_pad, gp_face2);
        
        _cima     = _cima     || _gp_cima;
        _baixo    = _baixo    || _gp_baixo;
        _esquerda = _esquerda || _gp_esq;
        _direita  = _direita  || _gp_dir;
        _voltar   = _voltar   || _gp_voltar;
    }
}

// -------------------------------------------------------------
// 4. MOVER A SELEÇÃO
// -------------------------------------------------------------
if (_cima) {
    opc_selecionada--;
    if (opc_selecionada < 0) opc_selecionada = array_length(opcoes) - 1;
    if (instance_exists(obj_audio)) obj_audio.tocar_sfx(snd_menu_navegar);
}

if (_baixo) {
    opc_selecionada++;
    if (opc_selecionada >= array_length(opcoes)) opc_selecionada = 0;
    if (instance_exists(obj_audio)) obj_audio.tocar_sfx(snd_menu_navegar);
}

// -------------------------------------------------------------
// 5. AJUSTAR OS VOLUMES
// -------------------------------------------------------------
timer_navegacao--;

if (timer_navegacao <= 0) {
    if (opc_selecionada == 0) {
        if (_esquerda) {
            global.vol_musica = clamp(global.vol_musica - 0.05, 0.0, 1.0);
            if (global.musica_atual != -1) audio_sound_gain(global.musica_atual, global.vol_musica, 0);
            if (instance_exists(obj_controle)) obj_controle.scr_salvar_opcoes();
            timer_navegacao = 5;
        }
        if (_direita) {
            global.vol_musica = clamp(global.vol_musica + 0.05, 0.0, 1.0);
            if (global.musica_atual != -1) audio_sound_gain(global.musica_atual, global.vol_musica, 0);
            if (instance_exists(obj_controle)) obj_controle.scr_salvar_opcoes();
            timer_navegacao = 5;
        }
    }
    
    if (opc_selecionada == 1) {
        if (_esquerda) {
            global.vol_sfx = clamp(global.vol_sfx - 0.05, 0.0, 1.0);
            if (instance_exists(obj_controle)) obj_controle.scr_salvar_opcoes();
            timer_navegacao = 6;
        }
        if (_direita) {
            global.vol_sfx = clamp(global.vol_sfx + 0.05, 0.0, 1.0);
            if (instance_exists(obj_controle)) obj_controle.scr_salvar_opcoes();
            timer_navegacao = 6;
        }
    }
}

// -------------------------------------------------------------
// 6. INICIAR FECHAMENTO (FADE OUT)
// -------------------------------------------------------------
if ((_confirmar && opc_selecionada == 2) || _voltar) {
    if (instance_exists(obj_audio)) obj_audio.tocar_sfx(snd_menu_clique);
    fechando = true;
    alpha_alvo = 0;
}