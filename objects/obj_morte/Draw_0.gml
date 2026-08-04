// 1. Desenha a sprite da sombra com 40% de transparência
draw_sprite_ext(spr_sombra, 0, x, y + 18, 1, 1, 0, c_white, 0.4);

// 2. Desenha o personagem por cima
draw_self();

/*if (instance_exists(obj_joystick)) {
    
    // Verifica se a mira deve ser bloqueada
    var _bloqueado = false;
    
    if (instance_exists(obj_controle)) {
        // Esconde a mira se deu Game Over, se Venceu ou se está no Loading
        _bloqueado = obj_controle.game_over || obj_controle.vitoria || obj_controle.em_loading;
    }
    
    // O bloco abaixo desenhava a linha vermelha. Ele foi removido.
    // Agora, nada de visual relacionado à mira é desenhado aqui.
}