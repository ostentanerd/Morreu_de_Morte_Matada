// Se a foice sumiu (ex: saiu da tela) e a vítima AINDA está viva:
if (instance_exists(obj_vitima) && instance_exists(obj_controle)) {
    // Se a armadilha também não está caindo no momento, o jogador errou a jogada
    if (!instance_exists(obj_armadilha) || !obj_armadilha.caindo) {
        obj_controle.game_over = true;
    }
}