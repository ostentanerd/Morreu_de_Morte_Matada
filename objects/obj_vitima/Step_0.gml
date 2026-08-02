// -------------------------------------------------------------
// 1. CHECAGEM DE PAUSA & SPRITE IDLE
// -------------------------------------------------------------
if (pause_timer > 0) {
    pause_timer--;
    
    // Troca para a sprite de parado se existir
    if (sprite_exists(spr_vitima_idle)) {
        sprite_index = spr_vitima_idle;
    }
    
    exit; // Fica parado
}

// -------------------------------------------------------------
// 2. MOVIMENTAÇÃO & SPRITE ANDANDO
// -------------------------------------------------------------
x += move_speed * dir;

// Troca para a sprite de caminhada
if (sprite_exists(spr_vitima_walk)) {
    sprite_index = spr_vitima_walk;
}

// Inverte o lado para onde está olhando
if (dir != 0) {
    image_xscale = dir;
}
// -------------------------------------------------------------
// 3. LIMITES DO CAMINHO (COM PAUSA)
// -------------------------------------------------------------
// Chegou no limite da direita
if (x >= start_x + walk_distance) {
    x = start_x + walk_distance; // Trava a posição exata (evita tremer)
    dir = -1;                     // Prepara a direção oposta
    pause_timer = pause_time;    // Ativa a pausa!
} 
// Chegou no limite da esquerda
else if (x <= start_x - walk_distance) {
    x = start_x - walk_distance; // Trava a posição exata
    dir = 1;                     // Prepara a direção oposta
    pause_timer = pause_time;    // Ativa a pausa!
}

// -------------------------------------------------------------
// 4. COLISÃO COM PAREDE (CORRIGIDA)
// -------------------------------------------------------------
// Checa colisão com parede e ajusta a posição exata antes de virar
if (place_meeting(x + (move_speed * dir), y, obj_parede)) {
    
    // Encosta o mais perto possível da parede sem atravessar
    while (!place_meeting(x + sign(dir), y, obj_parede)) {
        x += sign(dir);
    }
    
    dir = -dir;               // Inverte a direção
    pause_timer = pause_time; // Ativa a pausa ao bater na parede também
}


// Se perdeu o nível, congela a vítima
if (instance_exists(obj_controle) && obj_controle.game_over) {
    exit; // Não executa o movimento de patrulha
}