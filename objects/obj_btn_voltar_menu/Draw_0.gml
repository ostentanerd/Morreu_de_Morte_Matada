// 1. Muda o frame da sprite se o mouse estiver em cima
if (mouse_em_cima) {
    image_index = 1;
} else {
    image_index = 0;
}

// 2. Desenha a imagem do botão
draw_self();

// 3. Configurações de alinhamento e fonte
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (font_exists(fnt_volta)) {
    draw_set_font(fnt_volta);
}

// Arredonda as coordenadas para evitar sub-píxeis
var _px = round(x);
var _py = round(y);

// TRUQUE DA NITIDEZ: 
// Como a fonte agora é grande (ex: tamanho 32), reduza a escala para 0.5 
// para ela ficar do tamanho ideal no botão, mas com uma nitidez perfeita!
var _escala_texto = 0.5; 

// Sombra do texto (com deslocamento proporcional à escala)
/*draw_set_color(c_black);
draw_text_transformed(_px + 1, _py + 1, "MENU", _escala_texto, _escala_texto, 0);
*/


// Texto principal nítido
draw_set_color(c_white);
draw_text_transformed(_px, _py, "MENU", _escala_texto, _escala_texto, 0);

// Reseta as configurações do GameMaker
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);