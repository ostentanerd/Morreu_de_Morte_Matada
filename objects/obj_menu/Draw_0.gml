/*

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (font_exists(fnt_menu)) {
    draw_set_font(fnt_menu);
}

var _gui_w = display_get_gui_width();
var _centro_x = _gui_w / 2;

// --- TÍTULO DO JOGO ---
var _titulo_y = 65;
var _titulo_escala = 1.6; 

draw_set_color(c_black);
draw_text_transformed(_centro_x + 1, _titulo_y + 1, "Morreu de Morte Matada", _titulo_escala -0.3, _titulo_escala -0.3, 0);

draw_set_color(make_color_rgb(180, 20, 20));
draw_text_transformed(_centro_x, _titulo_y, "Morreu de Morte Matada", _titulo_escala -0.3, _titulo_escala -0.3, 0);

// --- OPÇÕES DO MENU ---
for (var i = 0; i < array_length(opcoes); i++) {
    var _y = y_inicial + (i * espacamento);
    var _texto = opcoes[i];
    var _escala = escala_opcoes[i]; 
    
    draw_set_color(c_black);
    draw_text_transformed(_centro_x + 1, _y + 1, _texto, _escala -0.5, _escala -0.5, 0);
    
    if (i == index) {
        draw_set_color(c_yellow);
    } else {
        draw_set_color(c_white); 
    }
    
    draw_text_transformed(_centro_x, _y, _texto, _escala -0.5, _escala -0.5, 0);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(-1);