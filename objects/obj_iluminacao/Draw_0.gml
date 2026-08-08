var _cam   = view_camera[0];
var _cam_w = camera_get_view_width(_cam);
var _cam_h = camera_get_view_height(_cam);
var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);

// 1. GARANTE QUE A SURFACE EXISTE (CRIA SE FOI APAGADA DA MEMÓRIA)
if (!surface_exists(surface_luz)) {
    surface_luz = surface_create(_cam_w, _cam_h);
}

// 2. DESENHA NA SURFACE
surface_set_target(surface_luz);

// Limpa a surface com a cor escura da sombra (ex: 85% opacidade)
draw_clear_alpha(c_black, 0.50);

// Ativa o modo de "cortar" buracos na sombra
gpu_set_blendmode(bm_subtract);

// Desenha o recorte de luz de todas as velas no mapa
with (obj_vela) {
    if (luz_tamanho > 0) {
        var _distancia_pavio = 12;
        var _fogo_x = x + lengthdir_x(_distancia_pavio, image_angle + 90);
        var _fogo_y = y + lengthdir_y(_distancia_pavio, image_angle + 90);
        
        var _surf_x = _fogo_x - _cam_x;
        var _surf_y = _fogo_y - _cam_y;
        
        var _flicker = random_range(-0.05, 0.05);
        var _raio_final = max(0, luz_tamanho + _flicker);
        
        if (sprite_exists(spr_luz_brilho)) {
            draw_sprite_ext(spr_luz_brilho, 0, _surf_x, _surf_y, _raio_final, _raio_final, 0, c_white, luz_alpha);
        } else {
            draw_circle_color(_surf_x, _surf_y, 35 * _raio_final, c_white, c_black, false);
        }
    }
}

// Restaura o modo normal e reseta o alvo do desenho
gpu_set_blendmode(bm_normal);
surface_reset_target();

// 3. DESENHA A SURFACE COMPLETA SOBRE A TELA
draw_surface(surface_luz, _cam_x, _cam_y);