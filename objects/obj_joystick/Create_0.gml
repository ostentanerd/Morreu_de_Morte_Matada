// Se já existir OUTRA instância deste objeto ativa, destrói a cópia nova!
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}


// Garante que persista entre as salas
persistent = true;

// Configuração do Gamepad
gamepad_slot = 0;
gamepad_set_axis_deadzone(gamepad_slot, 0.25);

// -------------------------------------------------------------
// ESTADOS DE INPUT (Acessados pelos outros objetos)
// -------------------------------------------------------------
aim_angle   = 0;       // Ângulo da mira em graus (0 a 360)
input_aim   = false;   // Se está segurando o botão de mirar
input_shoot = false;   // Se soltou o botão para lançar
input_reset = false;   // Se apertou o botão de reiniciar a fase

// Posição de origem para calcular a mira (Morte)
origin_x = x;
origin_y = y;