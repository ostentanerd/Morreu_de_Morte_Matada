// Só explode se a vela estiver de fato caindo/acesa
if (other.caindo) {
    // 1. Cria o objeto de explosão no centro do barril
    instance_create_layer(x, y, "Instances", obj_explosao);
	explode = true;
	
	if (instance_exists(obj_audio)) {
	    obj_audio.tocar_sfx(snd_quabra_barril);
	}
	
	
	if (instance_exists(obj_audio)) {
	    obj_audio.tocar_sfx(snd_explacao);
	}
    
    // 2. Destrói a vela e o próprio barril
    with (other) instance_destroy();
    instance_destroy();
}