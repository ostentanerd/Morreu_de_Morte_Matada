// A Morte não pode matar diretamente com a foice!
show_debug_message("VOCÊ PERDEU: A foice encostou na vítima!");

// Opcional: Criar efeito sonoro de falha / partículas de sangue falso

// Destrói a foice para interromper a jogada
instance_destroy();

// Reinicia a fase após um pequeno intervalo ou imediatamente
room_restart();