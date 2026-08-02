// A Morte não pode matar diretamente com a foice!
show_debug_message("VOCÊ PERDEU: A foice encostou na vítima!");

// A Morte não pode acertar o alvo diretamente!
if (instance_exists(obj_controle)) {
    obj_controle.game_over = true;
}

instance_destroy(); // Destrói a foice

