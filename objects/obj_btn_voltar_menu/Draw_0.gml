// 1. Muda o frame da sprite se o mouse estiver em cima (Efeito visual)
if (mouse_em_cima) {
    image_index = 1;
} else {
    image_index = 0;
}

// 2. Desenha a imagem do botão
draw_self();

// 3. Escreve a palavra "VOLTAR" (ou "MENU") no centro do botão
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Aplica a sua fonte personalizada se ela existir
if (font_exists(fnt_menu)) {
    draw_set_font(fnt_menu);
}

// Sombra do texto
draw_set_color(c_black);
draw_text(x + 1, y + 1, "MENU");

// Texto principal
draw_set_color(c_white);
draw_text(x, y, "MENU");

// Reseta o GameMaker
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);