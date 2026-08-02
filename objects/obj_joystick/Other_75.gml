var _type = async_load[? "event_type"];

if (_type == "gamepad discovered") {
    var _pad = async_load[? "pad_index"];
    gamepad_slot = _pad;
    gamepad_set_axis_deadzone(gamepad_slot, 0.25);
}

if (_type == "gamepad lost") {
    var _pad = async_load[? "pad_index"];
    if (gamepad_slot == _pad) {
        gamepad_slot = -1; // Reseta se o controle ativo for desconectado
    }
}