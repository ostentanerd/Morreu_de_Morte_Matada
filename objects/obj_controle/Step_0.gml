// 0. HITSTOP (Congelamento de impacto)
if (hitstop_timer > 0) {
    hitstop_timer--;
    game_set_speed(15, gamespeed_fps);
    exit;
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

// 2. SISTEMA DE TRANSIÇÃO E DESBLOQUEIO DE FASE
if (em_loading) {
    loading_timer--;
    
    if (loading_timer <= 0) {
        em_loading = false;
        
        // Verifica o nome da sala atual
        var _nome_sala = room_get_name(room);
        var _numero_str = string_digits(_nome_sala);
        
        // Se a sala atual tem número (ex: "rm_fase1"), atualiza a fase máxima
        if (_numero_str != "") {
            var _fase_atual_num = real(_numero_str);
            var _proxima_fase_num = _fase_atual_num + 1;
            
            // Se liberou uma fase maior que a máxima atual, salva no arquivo!
            if (_proxima_fase_num > fase_maxima) {
                fase_maxima = _proxima_fase_num;
                scr_salvar_jogo(); 
            }
        }
        
        // Troca para a próxima sala
        if (room_next(room) != -1) {
            room_goto_next();
        } else {
            room_goto(rm_selecao_fases); 
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
// -------------------------------------------------------------
// 4. SCREEN SHAKE (TREMOR DA CÂMERA)
// -------------------------------------------------------------
if (shake_time > 0) {
    shake_time--;
    
    var _cam_x = random_range(-shake_magnitude, shake_magnitude);
    var _cam_y = random_range(-shake_magnitude, shake_magnitude);
    
    camera_set_view_pos(view_camera[0], _cam_x, _cam_y);
} else {
    camera_set_view_pos(view_camera[0], 0, 0);
}


if (em_loading) {
    loading_timer--;
    
    if (loading_timer <= 0) {
        em_loading = false;
        
        if (room_next(room) != -1) {
            
            // 1. Pega o nome da sala atual (ex: "rm_fase1", "rm_fase2")
            var _nome_sala = room_get_name(room);
            
            // 2. Extrai apenas os números do nome da sala usando Expressão Regular
            var _numero_str = string_digits(_nome_sala);
            
            // 3. Se encontrou um número na sala atual, calcula o desbloqueio
            if (_numero_str != "") {
                var _fase_atual_num = real(_numero_str);
                var _proxima_fase_num = _fase_atual_num + 1;
                
                // Se a próxima fase for maior que o recorde atual, atualiza e salva
                if (_proxima_fase_num > fase_maxima) {
                    fase_maxima = _proxima_fase_num;
                    scr_salvar_jogo(); // Salva no arquivo .ini
                }
            }
            
            // Avança para a próxima sala na lista
            room_goto_next();
            
        } else {
            // Se venceu a última fase do jogo, volta para a seleção
            room_goto(rm_selecao_fases); 
        }
    }
}

// Quando você conclui uma fase (ex: rm_fase1):
var _nome_sala = room_get_name(room);
var _numero_str = string_digits(_nome_sala);

if (_numero_str != "") {
    var _fase_atual_num = real(_numero_str);
    var _proxima_fase_num = _fase_atual_num + 1; // Ex: Passou da 1, a próxima é a 2
    
    // Se a próxima fase for maior que o seu recorde, atualiza e salva no arquivo .ini!
    if (_proxima_fase_num > fase_maxima) {
        fase_maxima = _proxima_fase_num;
        
        // Escreve no Save
        ini_open("save.ini");
        ini_write_real("PROGRESSO", "fase_maxima", fase_maxima);
        ini_close();
    }
}