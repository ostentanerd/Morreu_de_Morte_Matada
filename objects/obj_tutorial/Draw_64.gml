// 1. FUNDO PRETO
draw_set_color(c_black);
draw_set_alpha(1.0);
draw_rectangle(0, 0, 384, 216, false);

// 2. DESENHA A ARTE DO TUTORIAL (Reduzida para caber na tela)
if (pagina_atual < total_paginas) {
    var _spr = sprites_tutorial[pagina_atual];
    if (sprite_exists(_spr)) {
        
        // Define o tamanho da imagem (0.3 ou 0.35 costuma encaixar perfeitamente em telas pequenas)
        var _escala_img = 0.33; 
        
        // Desenha a sprite animada com a escala menor centralizada
        draw_sprite_ext(_spr, anim_index, 192, 75, _escala_img, _escala_img, 0, c_white, 1.0);
    }
}

// 2.5 DESENHA O TEXTO DA PÁGINA
draw_set_font(fnt_tutorial); 
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top); 

var _texto_atual = textos_tutorial[pagina_atual];
draw_text(192, 155, _texto_atual);

// 4. INSTRUÇÃO COMPACTA (Reduzida)
draw_set_color(c_yellow);
// Os valores 0.7 e 0.7 controlam o tamanho horizontal e vertical do texto
draw_text_transformed(192, 190, "[ESPAÇO / ENTER / CLIQUE]", 0.7, 0.7, 0);

// Reseta padrões do GameMaker
draw_set_halign(fa_left);
draw_set_valign(fa_top);