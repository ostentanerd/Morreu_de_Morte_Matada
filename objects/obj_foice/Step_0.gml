// Faz a foice girar no ar
image_angle -= 10;

// SE A FOICE SAIR DA TELA (Errou o objetivo):
if (bbox_right < 0 || bbox_left > room_width || bbox_bottom < 0 || bbox_top > room_height) {
    // Destrói a foice e reinicia a fase
    instance_destroy();
    room_restart();
}


