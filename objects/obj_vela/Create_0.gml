event_inherited(); // Mantém o que tem no pai

// Volume base desejado para este efeito específico
vol_base_fogo = 0.5; 

// Toca o som de fogo em loop
som_fogo = audio_play_sound(snd_fogo_vela, 10, true);

// Aplica o volume inicial considerando o volume de SFX das opções
var _vol_sfx = 1;
if (instance_exists(obj_audio) && variable_instance_exists(obj_audio, "volume_sfx")) {
    _vol_sfx = obj_audio.volume_sfx;
} else if (variable_global_exists("vol_sfx")) {
    _vol_sfx = global.vol_sfx;
}

audio_sound_gain(som_fogo, vol_base_fogo * _vol_sfx, 0);

caindo = false;
hsp = 0;
vsp = 0;
grav = 0.25;
rot_speed = 0;
// -------------------------------------------------------------
// SISTEMA DE PARTÍCULAS
// -------------------------------------------------------------
part_sys = part_system_create();

// FORÇA AS PARTÍCULAS A FICAREM NA FRENTE DO OBJETO (depth - 1)
part_system_depth(part_sys, depth - 1);

// Partícula de Fogo (Aumentado um pouco o tamanho e a quantidade)
part_fogo = part_type_create();
part_type_shape(part_fogo, pt_shape_pixel);
part_type_size(part_fogo, 1, 2.5, -0.05, 0);          // Tamanho um pouco maior
part_type_color3(part_fogo, c_white, c_yellow, c_red);
part_type_alpha2(part_fogo, 1, 0);
part_type_speed(part_fogo, 0.3, 0.8, 0, 0);
part_type_direction(part_fogo, 80, 100, 0, 0);        // Flutua para cima
part_type_life(part_fogo, 10, 18);

// Partícula de Faísca
part_faisca = part_type_create();
part_type_shape(part_faisca, pt_shape_pixel);
part_type_size(part_faisca, 1, 1.2, -0.05, 0);
part_type_color2(part_faisca, c_yellow, c_orange);
part_type_alpha2(part_faisca, 1, 0);
part_type_speed(part_faisca, 0.5, 1.2, 0, 0);
part_type_direction(part_faisca, 0, 360, 0, 0);
part_type_life(part_faisca, 10, 18);


// -------------------------------------------------------------
// SISTEMA DE LUZ DA VELA
// -------------------------------------------------------------
luz_tamanho = 1.0;            // Escala atual do raio da luz (1.0 = 100%)
luz_alpha = 0.7;              // Opacidade base da luz
luz_apagar_velocidade = 0.055; // Velocidade com que a luz apaga ao cair (maior = mais rápido)