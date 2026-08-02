draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Título do Jogo
draw_set_color(c_white);
draw_text_transformed(room_width / 2, 50, "MEU JOGO", 1.5, 1.5, 0);

// Renderiza as opções
for (var i = 0; i < array_length(opcoes); i++) {
    var _y = 120 + (i * 30);
    
    if (i == index) {
        draw_set_color(c_yellow); // Opção selecionada fica amarela
        draw_text(room_width / 2, _y, "> " + opcoes[i] + " <");
    } else {
        draw_set_color(c_gray);
        draw_text(room_width / 2, _y, opcoes[i]);
    }
}

// Reseta o alinhamento
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);