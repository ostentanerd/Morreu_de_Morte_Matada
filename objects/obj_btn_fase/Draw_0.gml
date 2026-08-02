// 1. Define o frame da sprite
if (bloqueado) {
    image_index = 2;
} else if (mouse_em_cima) {
    image_index = 1;
} else {
    image_index = 0;
}

// 2. Desenha a sprite do botão no mundo do jogo (384x216)
draw_self();

// 3. Desenha o número da fase ou ícone
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (bloqueado) {
    draw_set_color(c_red);
    draw_text(x, y, "X");
} else {
    draw_set_color(c_white);
    draw_text(x, y, string(numero_fase));
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);