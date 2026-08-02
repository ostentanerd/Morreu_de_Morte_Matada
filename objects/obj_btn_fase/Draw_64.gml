/*// 1. Só tenta desenhar a sprite se ela realmente existir e estiver atribuída
if (sprite_exists(sprite_index)) {
    draw_sprite(sprite_index, image_index, x, y);
} else {
    // Fallback: se esqueceu de colocar sprite, desenha um retângulo simples para não travar
    draw_set_color(mouse_em_cima ? c_yellow : c_white);
    draw_rectangle(x - 25, y - 25, x + 25, y + 25, false);
}

// 2. Desenha o número da fase ou o ícone de bloqueado
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (bloqueado) {
    draw_set_color(c_red);
    draw_text(x, y, "X");
} else {
    draw_set_color(c_white);
    draw_text(x, y, string(numero_fase));
}

// Reseta o alinhamento
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);