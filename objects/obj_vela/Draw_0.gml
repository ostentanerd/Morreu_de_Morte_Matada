// Desenha a sprite da vela normalmente
draw_self();
/*
// -------------------------------------------------------------
// DESENHO DA LUZ (MODO ADITIVO / BM_ADD)
// -------------------------------------------------------------
if (luz_tamanho > 0) {
    var _distancia_pavio = 12;
    var _fogo_x = x + lengthdir_x(_distancia_pavio, image_angle + 90);
    var _fogo_y = y + lengthdir_y(_distancia_pavio, image_angle + 90);

    // Efeito de fogo oscilando/tremeluzindo (Flicker)
    var _flicker = random_range(-0.09, 0.09);
    var _raio_final = max(0, luz_tamanho + _flicker);
    
    // Ativa o blend aditivo para somar a cor da luz com o fundo
    gpu_set_blendmode(bm_add);
    
    // SE VOCÊ TIVER UMA SPRITE DE LUZ (ex: spr_luz_brilho):
    if (sprite_exists(spr_luz_brilho)) {
        draw_sprite_ext(spr_luz_brilho, 0, _fogo_x, _fogo_y, _raio_final, _raio_final, 0, c_yellow, luz_alpha);
    } 
    // SE NÃO TIVER SPRITE, DESENHA UM CÍRCULO SUAVE POR CÓDIGO:
    else {
        draw_circle_color(_fogo_x, _fogo_y, 30 * _raio_final, c_orange, c_black, false);
    }
    
    // Restaura o modo normal de desenho
    gpu_set_blendmode(bm_normal);
}