// Navegação do Menu (Seta Cima/Baixo ou W/S)
var _cima  = keyboard_check_pressed(vk_up)   || keyboard_check_pressed(ord("W"));
var _baixo = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var _enter = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

if (_cima) {
    index--;
    if (index < 0) index = array_length(opcoes) - 1;
}

if (_baixo) {
    index++;
    if (index >= array_length(opcoes)) index = 0;
}

// Confirmar Opção
if (_enter) {
    switch (index) {
        case 0: // JOGAR (Vai direto para a fase atual do progresso)
            if (instance_exists(obj_controle)) {
                // Vai para a última fase desbloqueada
                var _fase_destino = asset_get_index("rm_fase" + string(obj_controle.fase_maxima));
                if (_fase_destino != -1) room_goto(_fase_destino);
                else room_goto(rm_fase1);
            } else {
                room_goto(rm_fase1);
            }
            break;
            
        case 1: // SELECIONAR FASE
            room_goto(rm_selecao_fases);
            break;
            
        case 2: // SAIR
            game_end();
            break;
    }
}