// 1. Executa o ricochete automático com base na física das superfícies sólidas
// O parâmetro 'true' (advance) faz a foice avançar um pouco para não ficar "fresa/travada" dentro da parede.
move_bounce_solid(true);

// 2. Decrementa o contador de ricochetes
bounces_left--;

// 3. Efeito opcional: Tocar som de impacto metálico
// audio_play_sound(snd_metal_hit, 1, false);

// 4. Se gastou todos os ricochetes e não acertou o objetivo, a tentativa falhou
if (bounces_left <= 0) {
    instance_destroy();
}