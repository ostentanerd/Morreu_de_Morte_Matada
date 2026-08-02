// Se o controle estiver congelado em Hitstop, pausa o movimento da foice
if (instance_exists(obj_controle) && obj_controle.hitstop_timer > 0) {
    exit; // Interrompe o movimento e a rotação no frame do congelamento
}

// Lógica normal da foice (rotação, limites de sala, etc.)
image_angle -= 10;

if (bbox_right < 0 || bbox_left > room_width || bbox_bottom < 0 || bbox_top > room_height) {
    instance_destroy();
    room_restart();
}

