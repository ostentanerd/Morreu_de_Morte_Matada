part_type_destroy(part_fogo);
part_type_destroy(part_faisca);
part_system_destroy(part_sys);


// Paranoia check: Garante que o som do fogo não fique preso infinito na memória
if (audio_is_playing(som_fogo)) {
    audio_stop_sound(som_fogo);
}