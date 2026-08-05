// 1. Desenha a sombra
draw_sprite_ext(spr_sombra, 0, x, y + 18, 1, 1, 0, c_white, 0.4);

// 2. Desenha o personagem
draw_self();

// 3. RASTRO PONTILHADO DE MIRA
if (instance_exists(obj_joystick)) {
    
    var _bloqueado = false;
    if (instance_exists(obj_controle)) {
        // Agora também esconde a mira se a foice já tiver sido lançada!
        _bloqueado = obj_controle.game_over || obj_controle.vitoria || obj_controle.em_loading || obj_controle.foice_lancada;
    }
    
    // Desenha a mira APENAS se não estiver bloqueado
    if (obj_joystick.input_aim && !instance_exists(obj_foice) && !_bloqueado) {
        
        var _curr_x   = x;
        var _curr_y   = y;
        var _dir      = obj_joystick.aim_angle;
        
        var _dist_max        = 300;
        var _tamanho_traco   = 4;
        var _espaco_traco    = 6;
        var _passo           = _tamanho_traco + _espaco_traco;
        
        var _ja_quicou       = false;
        var _dist_acumulada  = 12;
        
        draw_set_alpha(0.35);
        
        while (_dist_acumulada < _dist_max) {
            
            var _x1 = _curr_x + lengthdir_x(_dist_acumulada, _dir);
            var _y1 = _curr_y + lengthdir_y(_dist_acumulada, _dir);
            
            var _x2 = _curr_x + lengthdir_x(_dist_acumulada + _tamanho_traco, _dir);
            var _y2 = _curr_y + lengthdir_y(_dist_acumulada + _tamanho_traco, _dir);
            
            if (position_meeting(_x1, _y1, obj_parede)) {
                if (_ja_quicou) break;
                
                _ja_quicou = true;
                
                var _prev_x = _curr_x + lengthdir_x(_dist_acumulada - 4, _dir);
                var _prev_y = _curr_y + lengthdir_y(_dist_acumulada - 4, _dir);
                
                if (position_meeting(_x1, _prev_y, obj_parede)) {
                    _dir = 180 - _dir;
                } else if (position_meeting(_prev_x, _y1, obj_parede)) {
                    _dir = 360 - _dir;
                } else {
                    _dir = _dir + 180;
                }
                
                draw_circle_color(_prev_x, _prev_y, 2, c_white, c_white, false);
                
                _curr_x = _prev_x;
                _curr_y = _prev_y;
                _dist_acumulada = 0; 
                continue;
            }
            
            draw_line_color(_x1, _y1, _x2, _y2, c_white, c_white);
            _dist_acumulada += _passo;
        }
        
        draw_set_alpha(1.0);
    }
}