// Faz a animação avançar devagar a cada frame
anim_index += anim_speed;

// 1. LEITURA DE ENTRADAS (Teclado, Mouse e Joystick)
var _avancar = keyboard_check_pressed(vk_space) 
            || keyboard_check_pressed(vk_enter) 
            || mouse_check_button_pressed(mb_left);

if (instance_exists(obj_joystick)) {
    if (variable_instance_exists(obj_joystick, "input_next") && obj_joystick.input_next) {
        _avancar = true;
        obj_joystick.input_next = false;
    }
}

// 2. MUDANÇA DE PÁGINA
if (_avancar && (!instance_exists(obj_controle) || !obj_controle.em_loading)) {
    pagina_atual++;
    anim_index = 0; // Reseta a animação para começar do início na nova página
    
    // Se passou da última imagem do tutorial:
    if (pagina_atual >= total_paginas) {
        pagina_atual = total_paginas - 1;
        
        if (instance_exists(obj_controle)) {
            obj_controle.room_alvo_botao = rm_fase1; 
            obj_controle.em_loading = true;
            obj_controle.loading_timer = 240;
            obj_controle.alpha_loading = 0;
        } else {
            room_goto(rm_fase1);
        }
    }
}