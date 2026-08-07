// 1. Desenha a sprite da sombra com 40% de transparência
draw_sprite_ext(spr_sombra, 0, x, y + 0.5, 1, 1, 0, c_white, 0.4);

// 2. Desenha o personagem por cima
draw_self();