// No ROOM START do obj_controle, adicione a trava para a cutscene:
if (instance_exists(obj_audio) && room != rm_cutscene) {
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