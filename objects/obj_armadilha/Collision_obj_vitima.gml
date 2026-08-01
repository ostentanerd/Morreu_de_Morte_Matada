// A armadilha esmagou a vítima!
show_debug_message("VÍTIMA ELIMINADA COM SUCESSO!");

// Chama a transição de fase ou avisa o obj_controle
if (instance_exists(obj_controle)) {
    // Exemplo: room_goto_next(); ou aciona timer de vitória
    room_goto_next();
	
	//room_restart(); // Por enquanto reinicia para testar
}