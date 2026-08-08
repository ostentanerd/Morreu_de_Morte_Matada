var _status = video_get_status();

if (_status == video_status_playing) {
    video_comecou = true;
}

// --- CHECAGEM DE INPUTS ---
var _pular_teclado = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("E"));

var _pular_gamepad = false;
if (gamepad_is_connected(0)) {
    _pular_gamepad = gamepad_button_check_pressed(0, gp_start) || gamepad_button_check_pressed(0, gp_face1);
}

var _pular_joystick = false;
if (instance_exists(obj_joystick)) {
    _pular_joystick = mouse_check_button_pressed(mb_left);
}

var _quer_pular = _pular_teclado || _pular_gamepad || _pular_joystick;

// Fecha o vídeo ao terminar ou ao pressionar para pular
if ((video_comecou && _status == video_status_closed) || _quer_pular) {
    video_close();
    display_set_gui_size(384, 216); // Retorna a GUI para a resolução pixel art original do jogo
    
    if (variable_global_exists("proxima_sala_cutscene") && global.proxima_sala_cutscene != -1) {
        room_goto(global.proxima_sala_cutscene);
    } else {
        room_goto(rm_tutorial);
    }
}