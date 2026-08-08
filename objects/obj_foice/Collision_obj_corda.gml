// 'other' é a corda que a foice acabou de tocar
with (other) {
    // Se a corda encontrou uma armadilha perto dela
    if (meu_objeto_preso != noone && instance_exists(meu_objeto_preso)) {
        meu_objeto_preso.caindo = true; // Ativa a queda!
    }
	
	// --- CHAME O SOM AQUI ---
		        if (instance_exists(obj_audio)) {
		            obj_audio.tocar_sfx(snd_foice_tiro);
		        }
    
    // Destrói a corda (efeito de corte)
    instance_destroy();
}