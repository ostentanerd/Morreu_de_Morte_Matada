// 1. Verifica se o mouse está sobre o botão
mouse_em_cima = position_meeting(mouse_x, mouse_y, id);
var _clique_mouse = (mouse_em_cima && mouse_check_button_pressed(mb_left));

// 2. Quando clicar no botão
if (_clique_mouse) {
    
    // Garante que o jogo está salvo ANTES de sair da fase
    if (instance_exists(obj_controle)) {
        obj_controle.scr_salvar_jogo();
    }
    
    // Despausa o jogo caso o botão seja clicado durante o Hitstop (opcional)
    game_set_speed(60, gamespeed_fps); 
    
    // Volta para o Menu Principal
    room_goto(rm_menu); 
}