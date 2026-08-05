// -------------------------------------------------------------
// GARANTE QUE SÓ EXISTA UM GERENCIADOR DE ÁUDIO (SINGLETON)
// -------------------------------------------------------------
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

// Inicializa as variáveis apenas se elas ainda não existirem no sistema
if (!variable_global_exists("vol_musica"))   global.vol_musica = 0.8;
if (!variable_global_exists("vol_sfx"))      global.vol_sfx = 1.0;
if (!variable_global_exists("musica_atual")) global.musica_atual = -1;

// -------------------------------------------------------------
// FUNÇÃO PARA TOCAR SFX (COM VARIAÇÃO DE TOM OPCIONAL)
// -------------------------------------------------------------
tocar_sfx = function(_som, _pitch_var = 0.08) {
    if (!audio_exists(_som)) exit;
    
    var _inst = audio_play_sound(_som, 5, false);
    
    // Aplica o volume global de SFX atualizado
    audio_sound_gain(_inst, global.vol_sfx, 0);
    
    if (_pitch_var > 0) {
        audio_sound_pitch(_inst, random_range(1 - _pitch_var, 1 + _pitch_var));
    }
    return _inst;
};

// -------------------------------------------------------------
// FUNÇÃO PARA TOCAR MÚSICA (COM FADE SUAVE)
// -------------------------------------------------------------
tocar_musica = function(_som, _tempo_fade_ms = 400) {
    if (global.musica_atual != -1 && audio_is_playing(global.musica_atual)) {
        if (audio_get_name(global.musica_atual) == audio_get_name(_som)) exit;
        audio_sound_gain(global.musica_atual, 0, _tempo_fade_ms);
    }
    
    global.musica_atual = audio_play_sound(_som, 10, true);
    audio_sound_gain(global.musica_atual, 0, 0);
    audio_sound_gain(global.musica_atual, global.vol_musica, _tempo_fade_ms);
};