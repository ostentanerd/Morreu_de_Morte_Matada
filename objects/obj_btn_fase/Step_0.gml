// 1. Checa se esta fase está bloqueada de acordo com o recorde do obj_controle
if (instance_exists(obj_controle)) {
    bloqueado = (numero_fase > obj_controle.fase_maxima);
}

// 2. Checa o mouse
mouse_em_cima = position_meeting(mouse_x, mouse_y, id);
var _clique_mouse = (mouse_em_cima && mouse_check_button_pressed(mb_left));

// 3. Clique para carregar a fase se estiver liberada
if (_clique_mouse && !bloqueado) {
    var _rm_alvo = asset_get_index("rm_fase" + string(numero_fase));
    if (_rm_alvo != -1) {
        room_goto(_rm_alvo);
    }
}