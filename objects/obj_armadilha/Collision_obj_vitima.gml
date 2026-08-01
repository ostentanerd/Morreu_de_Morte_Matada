// A armadilha esmagou a vítima!
show_debug_message("VÍTIMA ELIMINADA COM SUCESSO!");


if (caindo) {
    // Spawna os estilhaços
    repeat (4) {
        instance_create_layer(x, y, "Instances", obj_estilhaco);
    }
    
    // Elimina a vítima
    with (other) {
        // Pode acionar sprite de derrota ou sangue aqui
        instance_destroy();
    }
    
    // Destrói o lustre
    instance_destroy();
}


// Chama a transição de fase ou avisa o obj_controle
if (instance_exists(obj_controle)) {
    // Exemplo: room_goto_next(); ou aciona timer de vitória
   // room_goto_next();
	
	//room_restart(); // Por enquanto reinicia para testar
}