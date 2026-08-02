// Define a cor de destaque
if (mouse_em_cima) {
    draw_set_color(c_yellow);
} else {
    draw_set_color(c_white);
}

// Desenha a caixa do botão usando as coordenadas do próprio objeto na GUI
draw_rectangle(x - 45, y - 12, x + 45, y + 12, false);

// Desenha o texto + ícone do controle
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (gamepad_is_connected(0)) {
    draw_text(x, y, "[B] VOLTAR");
} else {
    draw_text(x, y, "VOLTAR");
}

// Reseta o alinhamento padrão
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);