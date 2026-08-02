// 1. Converte a posição do mouse para as coordenadas da interface (GUI)
var _gui_x = device_mouse_x_to_gui(0);
var _gui_y = device_mouse_y_to_gui(0);

// Checa se o mouse está dentro da caixa do botão (baseado no tamanho do Draw)
mouse_em_cima = (_gui_x >= x - 45 && _gui_x <= x + 45 && _gui_y >= y - 12 && _gui_y <= y + 12);

// 2. Checa o clique do mouse
var _clique_mouse = (mouse_em_cima && mouse_check_button_pressed(mb_left));

// 3. Checa a entrada vinda do obj_joystick
var _input_controle = false;
if (instance_exists(obj_joystick)) {
    _input_controle = obj_joystick.input_voltar;
}

// 4. Executa a troca de sala
if (_clique_mouse || _input_controle) {
    if (instance_exists(obj_joystick)) {
        obj_joystick.input_voltar = false; // Consome o input para não repetir
    }
    room_goto(rm_menu);
}