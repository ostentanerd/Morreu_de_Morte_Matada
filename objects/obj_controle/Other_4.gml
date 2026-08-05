// No Room Start Event do obj_controle:
if (instance_exists(obj_audio)) {
    obj_audio.tocar_musica(snd_musica_fase_01);
}




game_over     = false;
vitoria       = false;
em_loading    = false;
loading_timer = 0;
timer_derrota = 0; // Reseta o timer de tolerância

// Reseta a trava ao iniciar/reiniciar a sala
foice_lancada = false;

io_clear();