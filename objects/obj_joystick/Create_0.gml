// Singleton - Destrói cópias
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

persistent = true;

// Configuração do Gamepad
gamepad_slot = -1; // -1 indica que nenhum gamepad foi detectado ainda

// Procura por um gamepad já conectado ao iniciar
for (var i = 0; i < gamepad_get_device_count(); i++) {
    if (gamepad_is_connected(i)) {
        gamepad_slot = i;
        gamepad_set_axis_deadzone(gamepad_slot, 0.25);
        break;
    }
}

// -------------------------------------------------------------
// ESTADOS DE INPUT (Acessados pelos outros objetos)
// -------------------------------------------------------------
aim_angle    = 0;       // Ângulo da mira em graus (0 a 360)
input_aim    = false;   // Se está segurando o botão de mirar
input_shoot  = false;   // Se soltou o botão para lançar
input_reset  = false;   // Se apertou o botão de reiniciar a fase (R no Teclado)
input_next   = false;   // Se apertou o botão de avançar de fase (E no Teclado)
input_voltar = false;   // <<< ADICIONE ESTA LINHA (Botão B no Xbox / ESC)

// Posição de origem para cálculo de mira
origin_x = x;
origin_y = y;

// Controle de movimento do mouse (para alternância de dispositivo)
last_mouse_x = mouse_x;
last_mouse_y = mouse_y;
using_gamepad = false;