// 1. Define o frame da sprite
if (bloqueado) {
    image_index = 2;
} else if (mouse_em_cima) {
    image_index = 1;
} else {
    image_index = 0;
}

// 2. Desenha a sprite do botão
draw_self();

// 3. Configurações para desenhar o texto do botão
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// TRAVA A FONTE DO BOTÃO: Garante que ele nunca use a fonte grande de dica/loading
draw_set_font(fnt_menu_controle); // <--- Troque "fnt_padrao" pelo nome da fonte normal do seu jogo

if (bloqueado) {
    draw_set_color(c_red);
    draw_text(x, y, "");
} else {
    draw_set_color(c_white);
    draw_text(x, y, string(numero_fase));
}

// Reseta as configurações de desenho
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);