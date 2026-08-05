// 0. TRAVA O MENU PRINCIPAL SE AS OPÇÕES ESTIVEREM ABERTAS
if (instance_exists(obj_menu_opcoes)) exit;

// --------------------------------------------------------
// GUARDA O ÍNDICE ANTERIOR PARA CHECAR SE MUDOU
// --------------------------------------------------------
var _index_ant = index;

// 1. INPUTS DE TECLADO / GAMEPAD
var _cima  = keyboard_check_pressed(vk_up)   || keyboard_check_pressed(ord("W"));
var _baixo = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var _enter = keyboard_check_pressed(ord("E")) || keyboard_check_pressed(vk_space);

if (instance_exists(obj_joystick)) {
    _enter = _enter || obj_joystick.input_next;
    
    var _pad = obj_joystick.gamepad_slot;
    if (_pad != -1 && gamepad_is_connected(_pad)) {
        var _gp_cima  = gamepad_button_check_pressed(_pad, gp_padu) || (gamepad_axis_value(_pad, gp_axislv) < -0.5);
        var _gp_baixo = gamepad_button_check_pressed(_pad, gp_padd) || (gamepad_axis_value(_pad, gp_axislv) > 0.5);
        
        _cima  = _cima  || _gp_cima;
        _baixo = _baixo || _gp_baixo;
    }
}

if (_cima) {
    index--;
    if (index < 0) index = array_length(opcoes) - 1;
}

if (_baixo) {
    index++;
    if (index >= array_length(opcoes)) index = 0;
}

// 2. DETECÇÃO DO MOUSE
if (font_exists(fnt_menu)) draw_set_font(fnt_menu);

var _centro_x = room_width / 2;
var _mx = mouse_x;
var _my = mouse_y;
var _clique = mouse_check_button_pressed(mb_left);

for (var i = 0; i < array_length(opcoes); i++) {
    var _texto = opcoes[i];
    var _y = y_inicial + (i * espacamento);
    
    var _largura_caixa = string_width(_texto) * 1.2; 
    var _altura_caixa  = string_height(_texto) * 1.2;
    
    var _esq = _centro_x - (_largura_caixa / 2);
    var _dir = _centro_x + (_largura_caixa / 2);
    var _cima_caixa  = _y - (_altura_caixa / 2);
    var _baixo_caixa = _y + (_altura_caixa / 2);
    
    if (_mx >= _esq && _mx <= _dir && _my >= _cima_caixa && _my <= _baixo_caixa) {
        index = i; // Seleciona a opção apontada
        if (_clique) _enter = true;
    }
}

// --------------------------------------------------------
// TOCAR SOM APENAS SE A SELEÇÃO MUDOU DE VERDADE
// --------------------------------------------------------
if (index != _index_ant) {
    if (instance_exists(obj_audio)) obj_audio.tocar_sfx(snd_menu_navegar);
}

// 3. ANIMAÇÃO DE ESCALA (LERP)
for (var i = 0; i < array_length(opcoes); i++) {
    var _escala_alvo = (i == index) ? 1.5 : 1.0;
    escala_opcoes[i] = lerp(escala_opcoes[i], _escala_alvo, 0.15);
}

// 4. EXECUÇÃO DA OPÇÃO
if (_enter) {
    if (instance_exists(obj_audio)) obj_audio.tocar_sfx(snd_menu_clique);

    switch (index) {
        case 0: // CONTINUAR
            if (instance_exists(obj_controle)) {
                obj_controle.scr_carregar_jogo();
                var _fase_destino = asset_get_index("rm_fase" + string(obj_controle.fase_maxima));
                if (_fase_destino != -1) room_goto(_fase_destino);
                else room_goto(rm_fase1);
            } else {
                room_goto(rm_fase1);
            }
            break;
            
        case 1: // NOVO JOGO
            if (instance_exists(obj_controle)) {
                obj_controle.fase_maxima = 1;
                obj_controle.scr_salvar_jogo();
            }
            room_goto(rm_fase1);
            break;
            
        case 2: // SELECIONAR FASE
            room_goto(rm_selecao_fases);
            break;

        case 3: // CONTROLES
            room_goto(rm_controles);
            break;

        case 4: // OPÇÕES
            instance_create_layer(0, 0, "Instances", obj_menu_opcoes);
            io_clear();
            break;
            
        case 5: // SAIR
            game_end();
            break;
    }
}