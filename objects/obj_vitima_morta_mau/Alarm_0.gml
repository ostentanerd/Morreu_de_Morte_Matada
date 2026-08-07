if (instance_exists(obj_controle)) {
    // Se a causa da morte foi a armadilha, ativa a vitória. Senão, ativa o game over.
    if (causa_morta == "vitoria") {
        obj_controle.vitoria = true;
    } else {
        obj_controle.game_over = true;
    }
}