// 0. HITSTOP (Congelamento de impacto)
if (hitstop_timer > 0) {
    hitstop_timer--;
    game_set_speed(15, gamespeed_fps);
    exit; // Para a leitura do step aqui temporariamente
} else {
    game_set_speed(60, gamespeed_fps);
}

// 1. INPUTS VIA JOYSTICK E TECLADO
if (instance_exists(obj_joystick)) {
    mira_frame = obj_joystick.input_aim ? 1 : 0;
    
    // Reiniciar Fase
    if (obj_joystick.input_reset && !vitoria && !em_loading) {
        game_over = false;
        vitoria = false;
        em_loading = false;
        obj_joystick.input_reset = false;
        room_restart();
    }
    
    // Avançar de Fase ao Vencer
    if (vitoria && !em_loading) {
        if (obj_joystick.input_next) { 
            vitoria = false;
            em_loading = true;
            loading_timer = 240; 
            alpha_loading = 0; 
            obj_joystick.input_next = false;
            io_clear();
            
            // Sorteio da Arte
            var _lista_de_artes = [spr_arte1, spr_arte2, spr_arte3];
            var _index_sorteado = irandom(array_length(_lista_de_artes) - 1);
            arte_escolhida = _lista_de_artes[_index_sorteado];
            
            // Sorteio da Dica
            var _sorteio = irandom(2);
            switch(_sorteio) {
                case 0: dica_escolhida = "DICA: Explore bem as gavetas e cômodas."; break;
                case 1: dica_escolhida = "DICA: Pague o engenheiro para subir o nível das barricadas."; break;
                case 2: dica_escolhida = "DICA: Você pode atirar enquanto estiver na escada."; break;
            }
        }
    }
}

// -------------------------------------------------------------
// 1.4 DETECTA SE A FOICE FOI LANÇADA
// -------------------------------------------------------------
if (instance_exists(obj_foice)) {
    foice_lancada = true;
}

// -------------------------------------------------------------
// 1.5 CHECAGEM INTELIGENTE DE DERROTA (COM TOLERÂNCIA DE TEMPO)
// -------------------------------------------------------------
if (!game_over && !vitoria && !em_loading && foice_lancada) {
    
    // 1. Só avalia se a foice já não existe mais na tela
    if (!instance_exists(obj_foice)) {
        
        // 2. Procura se existe QUALQUER armadilha filha ativa no momento
        var _tem_armadilha_ativa = false;
        
        with (obj_armadilha_pai) {
            if (variable_instance_exists(id, "esta_ativa") && esta_ativa) {
                _tem_armadilha_ativa = true;
                break; // Encontrou uma ativa, para a busca
            }
        }
        
        // 3. Se nenhuma armadilha estiver ativa, conta o tempo de segurança
        if (!_tem_armadilha_ativa) {
            timer_derrota++;
            
            // Espera 30 frames (meio segundo) de silêncio total antes de dar Game Over
            if (timer_derrota >= 60) {
                if (instance_exists(obj_vitima)) {
                    game_over = true;
                }
            }
        } else {
            // Se encontrou alguma armadilha em ação, reseta o timer
            timer_derrota = 0;
        }
    } else {
        // Enquanto a foice existir na tela, o timer fica zerado
        timer_derrota = 0;
    }
}

// 2. SISTEMA DE TRANSIÇÃO, DESBLOQUEIO DE FASE E TELA DE CRÉDITOS
if (em_loading) {
    
    // -> TRAVA DE SEGURANÇA DA ARTE (NOVIDADE AQUI) <-
    if (arte_escolhida == -1) {
        var _lista_de_artes = [spr_arte1, spr_arte2, spr_arte3];
        var _index_sorteado = irandom(array_length(_lista_de_artes) - 1);
        arte_escolhida = _lista_de_artes[_index_sorteado];
    }
    
    // Trava de segurança para a dica
    if (dica_escolhida == "") {
        var _sorteio = irandom(2);
        switch(_sorteio) {
            case 0: dica_escolhida = "DICA: Explore bem as gavetas e cômodas."; break;
            case 1: dica_escolhida = "DICA: Pague o engenheiro para subir o nível das barricadas."; break;
            case 2: dica_escolhida = "DICA: Você pode atirar enquanto estiver na escada."; break;
        }
    }
    
    loading_timer--;
    
    // FADE IN: Primeira metade do tempo (Aparecendo)
    if (loading_timer > 120) {
        alpha_loading += 0.02; 
        if (alpha_loading > 1) alpha_loading = 1; 
    } 
    // FADE OUT: Segunda metade do tempo (Sumindo)
    else {
        alpha_loading -= 0.02; 
        if (alpha_loading < 0) alpha_loading = 0; 
    }
    
    // EXATAMENTE NA METADE DO TEMPO: Troca de sala
    if (loading_timer == 120) {
        
        if (variable_instance_exists(id, "room_alvo_botao") && room_alvo_botao != undefined) {
            room_goto(room_alvo_botao);
            room_alvo_botao = undefined; 
        } 
        else {
            var _nome_sala = room_get_name(room);
            var _numero_str = string_digits(_nome_sala);
            
            if (_numero_str != "") {
                var _fase_atual_num = real(_numero_str);
                var _proxima_fase_num = _fase_atual_num + 1;
                
                if (_fase_atual_num == 5) {
                    room_goto(rm_creditos);
                } else {
                    if (_proxima_fase_num > fase_maxima) {
                        fase_maxima = _proxima_fase_num;
                        scr_salvar_jogo(); 
                    }
                    
                    var _proxima_sala = asset_get_index("rm_fase" + string(_proxima_fase_num));
                    if (_proxima_sala != -1) {
                        room_goto(_proxima_sala);
                    } else {
                        room_goto(rm_selecao_fases);
                    }
                }
            } else {
                if (room_next(room) != -1) {
                    room_goto_next();
                } else {
                    room_goto(rm_selecao_fases);
                }
            }
        }
    }
    
    // FINALIZA O LOADING QUANDO O TIMER ZERAR
    if (loading_timer <= 0) {
        em_loading = false;
        arte_escolhida = -1; // -> NOVIDADE: Reseta a arte para forçar um novo sorteio no próximo loading!
    }
}

// 3. SCREEN SHAKE (TREMOR DA CÂMERA)
if (shake_time > 0) {
    shake_time--;
    var _cam_x = random_range(-shake_magnitude, shake_magnitude);
    var _cam_y = random_range(-shake_magnitude, shake_magnitude);
    camera_set_view_pos(view_camera[0], _cam_x, _cam_y);
} else {
    camera_set_view_pos(view_camera[0], 0, 0);
}