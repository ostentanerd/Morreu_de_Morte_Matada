draw_self();

if (instance_exists(obj_joystick)) {
    
    // Verifica se a mira deve ser bloqueada
    var _bloqueado = false;
    
    if (instance_exists(obj_controle)) {
        // Esconde a mira se deu Game Over, se Venceu ou se está no Loading
        _bloqueado = obj_controle.game_over || obj_controle.vitoria || obj_controle.em_loading;
    }
    
    // O bloco abaixo desenhava a linha vermelha. Ele foi removido.
    // Agora, nada de visual relacionado à mira é desenhado aqui.
}