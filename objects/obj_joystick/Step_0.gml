// 1. Atualiza a posição de origem da mira
if (instance_exists(obj_morte)) {
    origin_x = obj_morte.x;
    origin_y = obj_morte.y;
}

// 2. Inputs de Teclado e Mouse (Integrados com o sistema de Rebind)
var _mb_aim    = mouse_check_button(mb_left);
var _mb_shoot  = mouse_check_button_released(mb_left);
var _kb_shoot  = keyboard_check_released(global.key_shoot);
var _kb_reset  = keyboard_check_pressed(global.key_reset);
var _kb_next   = keyboard_check_pressed(global.key_next);
var _kb_voltar = keyboard_check_pressed(global.key_voltar) || keyboard_check_pressed(vk_backspace);

// 3. Inputs do Controle de Xbox
var _gp_aim    = false;
var _gp_shoot  = false;
var _gp_reset  = false;
var _gp_next   = false;
var _gp_voltar = false;
var _axis_x    = 0;
var _axis_y    = 0;

// Garante que re-checa se o controle foi conectado/reconectado
if (gamepad_slot == -1 || !gamepad_is_connected(gamepad_slot)) {
    for (var i = 0; i < gamepad_get_device_count(); i++) {
        if (gamepad_is_connected(i)) {
            gamepad_slot = i;
            gamepad_set_axis_deadzone(gamepad_slot, 0.35);
            break;
        }
    }
}

if (gamepad_slot != -1 && gamepad_is_connected(gamepad_slot)) {
    _axis_x = gamepad_axis_value(gamepad_slot, gp_axisrh);
    _axis_y = gamepad_axis_value(gamepad_slot, gp_axisrv);
    
    // DEADZONE MANUAL: Ignora qualquer toque leve ou drift abaixo de 0.35
    if (abs(_axis_x) < 0.35) _axis_x = 0;
    if (abs(_axis_y) < 0.35) _axis_y = 0;
    
    var _analogue_movido = (_axis_x != 0 || _axis_y != 0);
    
    _gp_aim    = _analogue_movido || gamepad_button_check(gamepad_slot, global.gp_shoot) || gamepad_button_check(gamepad_slot, gp_shoulderr);
    _gp_shoot  = gamepad_button_check_released(gamepad_slot, global.gp_shoot);
    
    _gp_reset  = gamepad_button_check_pressed(gamepad_slot, global.gp_reset);    
    _gp_next   = gamepad_button_check_pressed(gamepad_slot, global.gp_next);    
    _gp_voltar = gamepad_button_check_pressed(gamepad_slot, global.gp_voltar);    
}

// 4. Detecção de Dispositivo Ativo (Prioridade para o Controle quando em uso)
var _analog_movido = (point_distance(0, 0, _axis_x, _axis_y) > 0.35) || _gp_aim || _gp_shoot;
var _mouse_clicado = mouse_check_button_pressed(mb_any);
var _mouse_movido_forte = (abs(mouse_x - last_mouse_x) > 5 || abs(mouse_y - last_mouse_y) > 5);

// Se você empurrar o analógico ou apertar botão no controle, ele assume e trava no controle
if (_analog_movido) {
    using_gamepad = true;
} 
// O mouse só reassume se você clicar nele de fato ou mover o mouse de forma brusca
else if (_mouse_clicado || _mouse_movido_forte) {
    using_gamepad = false;
}

// Atualiza a mira de acordo com o dispositivo ativo (Calculado de forma limpa e única)
if (using_gamepad) {
    if (_axis_x != 0 || _axis_y != 0) {
        aim_angle = point_direction(0, 0, _axis_x, _axis_y);
    }
} 
else {
    aim_angle = point_direction(origin_x, origin_y, mouse_x, mouse_y);
}

last_mouse_x = mouse_x;
last_mouse_y = mouse_y;

// 5. Consolidação Final
input_aim    = _mb_aim || _gp_aim;
input_shoot  = _mb_shoot || _kb_shoot || _gp_shoot;
input_reset  = _kb_reset || _gp_reset;
input_next   = _kb_next || _gp_next;
input_voltar = _kb_voltar || _gp_voltar;