draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (font_exists(fnt_menu)) {
    draw_set_font(fnt_menu);
}

var _centro_x = room_width / 2;

// --- TÍTULO DO JOGO ---
var _titulo_y = 62;
var _titulo_escala = 1.6; // Título bem maior que o resto

// Sombra do Título
draw_set_color(c_black);
draw_text_transformed(_centro_x + 1, _titulo_y + 1, "Morreu de Morte Matada", _titulo_escala -0.3, _titulo_escala -0.3, 0);

// Cor do Título (Um tom de vermelho escuro para dar um clima mais denso)
draw_set_color(make_color_rgb(180, 20, 20));
draw_text_transformed(_centro_x, _titulo_y, "Morreu de Morte Matada", _titulo_escala -0.3, _titulo_escala -0.3, 0);


// --- OPÇÕES DO MENU ---
for (var i = 0; i < array_length(opcoes); i++) {
    var _y = y_inicial + (i * espacamento);
    var _texto = opcoes[i];
    var _escala = escala_opcoes[i]; // Pega o tamanho animado atual que está rodando no Step
    
    // Sombra das opções (aumenta e diminui junto com o texto)
    draw_set_color(c_black);
    draw_text_transformed(_centro_x + 1, _y + 1, _texto, _escala -0.5, _escala -0.5, 0);
    
    if (i == index) {
        // Texto selecionado (amarelo)
        draw_set_color(c_yellow);
    } else {
        // Texto normal (branco, para destacar mais contra o fundo preto)
        draw_set_color(c_white); 
    }
    
    // Desenha a opção usando o text_transformed para aplicar a escala
    draw_text_transformed(_centro_x, _y, _texto, _escala -0.5, _escala -0.5, 0);
}

// Reseta o alinhamento e a fonte padrão
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(-1);