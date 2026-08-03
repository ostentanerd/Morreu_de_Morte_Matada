// --------------------------------------------------------
// 1. DEFINIÇÃO DOS INPUTS DE TECLADO E CONTROLE
// --------------------------------------------------------
var _tecla_voltar = keyboard_check_pressed(vk_escape);
var _controle_voltar = false;

// Verifica se existe um joystick e lê o botão 'Select' (View no Xbox)
if (instance_exists(obj_joystick)) {
    var _pad = obj_joystick.gamepad_slot;
    if (_pad != -1 && gamepad_is_connected(_pad)) {
        // gp_select é o botão View (o botãozinho da esquerda no Xbox)
        if (gamepad_button_check_pressed(_pad, gp_select)) {
            _controle_voltar = true;
        }
    }
}

// --------------------------------------------------------
// 2. VERIFICAÇÃO DO MOUSE (Lógica original mantida)
// --------------------------------------------------------
mouse_em_cima = position_meeting(mouse_x, mouse_y, id);
var _clique_mouse = (mouse_em_cima && mouse_check_button_pressed(mb_left));

// Garante que o clique do controle seja único e não repetitivo
if (_controle_voltar || _tecla_voltar) {
    // Se apertou o controle ou ESC, simulamos o clique do mouse
    _clique_mouse = true;
}

// --------------------------------------------------------
// 3. AÇÃO DO BOTÃO (Executa se houver clique, mouse em cima ou input de teclado/controle)
// --------------------------------------------------------
if (_clique_mouse) {
    
    // EFEITO VISUAL OPCIONAL: Se for via controle/teclado, força o frame de hover
    image_index = 1; 
    
    // Garante que o jogo está salvo ANTES de sair da fase
    if (instance_exists(obj_controle)) {
        obj_controle.scr_salvar_jogo();
    }
    
    // Despausa o jogo caso o botão seja clicado durante o Hitstop (opcional, mas recomendado)
    if (variable_global_exists("scr_hitstop")) {
         global.scr_hitstop(0); // Cancela qualquer hitstop pendente
    }
    game_set_speed(60, gamespeed_fps);
    
    // Volta para o Menu Principal
    room_goto(rm_menu);
}