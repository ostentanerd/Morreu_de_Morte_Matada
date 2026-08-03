// 1. Navegação via Teclado / Gamepad
var _cima  = keyboard_check_pressed(vk_up)   || keyboard_check_pressed(ord("W"));
var _baixo = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var _enter = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

if (instance_exists(obj_joystick)) {
    // Confirma com o botão 'A' do controle
    _enter = _enter || obj_joystick.input_next;
    
    // ADICIONADO: Permite subir e descer no menu usando o D-pad ou Analógico Esquerdo do controle
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
// --------------------------------------------------------
// 2. NAVEGAÇÃO E CLIQUE PELO MOUSE
// --------------------------------------------------------
if (font_exists(fnt_menu)) draw_set_font(fnt_menu);

var _centro_x = room_width / 2;
var _mouse_x = mouse_x;
var _mouse_y = mouse_y;
var _clique = mouse_check_button_pressed(mb_left);

for (var i = 0; i < array_length(opcoes); i++) {
    var _texto = opcoes[i];
    var _y = y_inicial + (i * espacamento);
    
    // Calcula o tamanho da "caixa de colisão" invisível ao redor da palavra
    // Multiplicamos por 1.5 pois é o tamanho máximo que a palavra vai chegar
    var _largura_caixa = string_width(_texto) * 1.5; 
    var _altura_caixa = string_height(_texto) * 1.5;
    
    var _esq = _centro_x - (_largura_caixa / 2);
    var _dir = _centro_x + (_largura_caixa / 2);
    var _cima_caixa = _y - (_altura_caixa / 2);
    var _baixo_caixa = _y + (_altura_caixa / 2);
    
    // Verifica se o mouse está dentro da caixa dessa palavra específica
    if (_mouse_x >= _esq && _mouse_x <= _dir && _mouse_y >= _cima_caixa && _mouse_y <= _baixo_caixa) {
        
        // Se o mouse tocou na palavra, ela vira a opção selecionada
        index = i; 
        
        // Se o jogador clicar com o botão esquerdo, simula o "Enter"
        if (_clique) {
            _enter = true;
        }
    }
}

// --------------------------------------------------------
// 3. ANIMAÇÃO SUAVE DE CRESCER (LERP)
// --------------------------------------------------------
for (var i = 0; i < array_length(opcoes); i++) {
    // Se a opção for a selecionada, o tamanho alvo é 1.5x, senão, é 1.0x
    var _escala_alvo = (i == index) ? 1.5 : 1.0;
    
    // A função LERP faz o tamanho atual ir até o tamanho alvo de forma suave e macia
    escala_opcoes[i] = lerp(escala_opcoes[i], _escala_alvo, 0.15);
}

// --------------------------------------------------------
// 4. EXECUTA A OPÇÃO SELECIONADA
// --------------------------------------------------------
if (_enter) {
    if (instance_exists(obj_controle)) {
        obj_controle.scr_carregar_jogo();
    }

    switch (index) {
        case 0: // CONTINUAR
            if (instance_exists(obj_controle)) {
                var _fase_destino = asset_get_index("rm_fase" + string(obj_controle.fase_maxima));
                if (_fase_destino != -1) {
                    room_goto(_fase_destino);
                } else {
                    room_goto(rm_fase1);
                }
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

        case 3: // CONTROLES (Abre a room de remapeamento de teclas que criamos)
            room_goto(rm_controles);
            break;
            
        case 4: // SAIR
            game_end();
            break;
    }
}