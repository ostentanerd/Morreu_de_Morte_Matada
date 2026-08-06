// 1. (Opcional) Cria restos de madeira se você tiver uma sprite/objeto de barril quebrado
 instance_create_layer(x, y, "Instances", obj_barril_quebrado);
 if (instance_exists(obj_audio)) {
	    obj_audio.tocar_sfx(snd_quabra_barril);
	}
    

// 2. Destrói o barril diretamente sem criar a explosão
instance_destroy();