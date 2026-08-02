// 1. ATUALIZA A POSIÇÃO DE ORIGEM DA MIRA
if (instance_exists(obj_morte)) {
    origin_x = obj_morte.x;
    origin_y = obj_morte.y;
}

// 2. LEITURA DE INPUTS (MOUSE + TECLADO)
var _mb_aim    = mouse_check_button(mb_left);
var _mb_shoot  = mouse_check_button_released(mb_left);
var _kb_reset  = keyboard_check_pressed(ord("R"));
var _kb_next   = keyboard_check_pressed(ord("E"));
var _kb_voltar = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_backspace);

var _mouse_angle = point_direction(origin_x, origin_y, mouse_x, mouse_y);

// 3. LEITURA DE INPUTS (CONTROLE XBOX / PLAYSTATION)
var _gp_aim          = false;
var _gp_shoot        = false;
var _gp_reset        = false;
var _gp_next         = false;
var _gp_voltar       = false;
var _gp_using_analog = false;
var _gp_angle        = 0;

if (gamepad_is_connected(gamepad_slot)) {
    _gp_aim    = gamepad_button_check(gamepad_slot, gp_shoulderR);
    _gp_shoot  = gamepad_button_check_released(gamepad_slot, gp_shoulderR);
    _gp_reset  = gamepad_button_check_pressed(gamepad_slot, gp_select);
    _gp_next   = gamepad_button_check_pressed(gamepad_slot, gp_face1); // Botão 'A' (Xbox) / 'X' (PS)
    _gp_voltar = gamepad_button_check_pressed(gamepad_slot, gp_face2); // Botão 'B' (Xbox) / 'Círculo' (PS)
    
    var _axis_x = gamepad_axis_value(gamepad_slot, gp_axisr_x);
    var _axis_y = gamepad_axis_value(gamepad_slot, gp_axisr_y);
    
    if (point_distance(0, 0, _axis_x, _axis_y) > 0.3) {
        _gp_using_analog = true;
        _gp_angle = point_direction(0, 0, _axis_x, _axis_y);
    }
}

// 4. CONSOLIDAÇÃO DOS DADOS DE SAÍDA
input_aim    = _mb_aim || _gp_aim;
input_shoot  = _mb_shoot || _gp_shoot;
input_reset  = _kb_reset || _gp_reset;
input_next   = _kb_next || _gp_next;
input_voltar = _kb_voltar || _gp_voltar;

if (_gp_using_analog) {
    aim_angle = _gp_angle;
} else {
    aim_angle = _mouse_angle;
}