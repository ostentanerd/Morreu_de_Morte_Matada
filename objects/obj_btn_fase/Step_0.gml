// 1. Checa se esta fase está bloqueada de acordo com o recorde do obj_controle
if (instance_exists(obj_controle)) {
    bloqueado = (numero_fase > obj_controle.fase_maxima);
}

// 2. Checa o mouse
mouse_em_cima = position_meeting(mouse_x, mouse_y, id);

// --- SOM DE HOVER / NAVEGAÇÃO ---
// Toca apenas no frame exato em que o mouse ENTRA no botão liberado
if (mouse_em_cima && !mouse_estava_em_cima && !bloqueado) {
    if (instance_exists(obj_audio)) {
        obj_audio.tocar_sfx(snd_menu_navegar);
    }
}

// Atualiza o estado do mouse para o próximo frame
mouse_estava_em_cima = mouse_em_cima;

var _clique_mouse = (mouse_em_cima && mouse_check_button_pressed(mb_left));

// 3. Clique para carregar a fase se estiver liberada
if (_clique_mouse && !bloqueado) {
    var _rm_alvo = asset_get_index("rm_fase" + string(numero_fase));
    
    // --- CHAME O SOM DE CLIQUE AQUI ---
    if (instance_exists(obj_audio)) {
        obj_audio.tocar_sfx(snd_menu_clique);
    }
    
    if (_rm_alvo != -1 && instance_exists(obj_controle)) {
        // Evita clicar se já estiver em loading
        if (!obj_controle.em_loading) {
            obj_controle.em_loading = true;
            obj_controle.loading_timer = 240; 
            obj_controle.alpha_loading = 0; 
            io_clear();
            
            // Sorteio da Arte
            var _lista_de_artes = [spr_arte1, spr_arte2, spr_arte3];
            var _index_sorteado = irandom(array_length(_lista_de_artes) - 1);
            obj_controle.arte_escolhida = _lista_de_artes[_index_sorteado];
            
            // Sorteio da Dica
            var _sorteio = irandom(2);
            switch(_sorteio) {
                case 0: obj_controle.dica_escolhida = "DICA: Explore bem as gavetas e cômodas."; break;
                case 1: obj_controle.dica_escolhida = "DICA: Pague o engenheiro para subir o nível das barricadas."; break;
                case 2: obj_controle.dica_escolhida = "DICA: Você pode atirar enquanto estiver na escada."; break;
            }
            
            obj_controle.room_alvo_botao = _rm_alvo;
        }
    }
}