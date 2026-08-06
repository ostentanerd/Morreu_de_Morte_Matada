// 1. FUNDO PRETO
draw_set_color(c_black);
draw_set_alpha(1.0);
draw_rectangle(0, 0, 384, 216, false);

// 2. DESENHA A ARTE DO TUTORIAL (Centralizada no topo/centro)
if (pagina_atual < total_paginas) {
    var _spr = sprites_tutorial[pagina_atual];
    if (sprite_exists(_spr)) {
        // Posição (192, 85) - Subi um pouquinho a imagem para dar mais espaço ao texto
        draw_sprite(_spr, 0, 192, 85);
    }
}

// ==========================================
// NOVIDADE: 2.5 DESENHA O TEXTO DA PÁGINA
// ==========================================
draw_set_font(fnt_tutorial); 
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top); // Alinha pelo topo para o \n empurrar para baixo

// Pega o texto da página atual e desenha no Y = 135 (logo abaixo da imagem)
var _texto_atual = textos_tutorial[pagina_atual];
draw_text(192, 135, _texto_atual);
// ==========================================


// 3. CONTADOR DE PÁGINAS (Ex: 1 / 3)
draw_set_color(c_gray); // Coloquei cinza para dar destaque ao texto principal
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//var _indicador = string(pagina_atual + 1) + " / " + string(total_paginas);
//draw_text(192, 175, _indicador);


// 4. INSTRUÇÃO COMPACTA
draw_set_color(c_yellow);
draw_text(192, 195, "[ESPAÇO / ENTER / CLIQUE]");

// Reseta padrões do GameMaker
draw_set_halign(fa_left);
draw_set_valign(fa_top);