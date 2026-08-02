// 0. HITSTOP (Congelamento de impacto)
if (hitstop_timer > 0) {
    hitstop_timer--;
    game_set_speed(15, gamespeed_fps);
    exit; // Para a leitura do step aqui temporariamente
} else {
    game_set_speed(60, gamespeed_fps);
}

// 1. INPUTS VIA JOYSTICK
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
            loading_timer = 60;
            obj_joystick.input_next = false;
            io_clear();
        }
    }
}

// 2. SISTEMA DE TRANSIÇÃO, DESBLOQUEIO DE FASE E TELA DE CRÉDITOS
if (em_loading) {
    loading_timer--;
    
    if (loading_timer <= 0) {
        em_loading = false;
        
        // Pega o nome da sala atual
        var _nome_sala = room_get_name(room);
        var _numero_str = string_digits(_nome_sala);
        
        // Verifica se a sala é uma fase (se tem número no nome)
        if (_numero_str != "") {
            var _fase_atual_num = real(_numero_str);
            var _proxima_fase_num = _fase_atual_num + 1;
            
            // ---------------------------------------------------
            // CHECA SE É A ÚLTIMA FASE (FASE 5)
            // ---------------------------------------------------
            if (_fase_atual_num == 5) {
                
                // Manda para a tela de créditos!
                room_goto(rm_creditos);
                
            } else {
                // SE FOR UMA FASE NORMAL (1, 2, 3, 4)...
                
                // Salva o progresso se bateu o recorde
                if (_proxima_fase_num > fase_maxima) {
                    fase_maxima = _proxima_fase_num;
                    scr_salvar_jogo(); 
                }
                
                // Carrega a próxima fase pelo nome exato (rm_fase2, rm_fase3...)
                var _proxima_sala = asset_get_index("rm_fase" + string(_proxima_fase_num));
                if (_proxima_sala != -1) {
                    room_goto(_proxima_sala);
                } else {
                    room_goto(rm_selecao_fases); // Prevenção de erro
                }
            }
        } else {
            // Se a sala não tem número (ex: tutorial), só vai pra próxima sala genérica
            if (room_next(room) != -1) {
                room_goto_next();
            } else {
                room_goto(rm_selecao_fases);
            }
        }
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