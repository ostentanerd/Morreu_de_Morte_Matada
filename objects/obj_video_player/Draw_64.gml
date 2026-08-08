// 1. Captura os dados do vídeo
var _dados_video = video_draw();
var _status_desenho = _dados_video[0];

// 2. Quando há um quadro NOVO (status 0), copia para a nossa surface própria
if (_status_desenho == 0) {
    var _sub_surface = _dados_video[1];
    
    if (surface_exists(_sub_surface)) {
        var _sw = surface_get_width(_sub_surface);
        var _sh = surface_get_height(_sub_surface);
        
        // Cria a surface buffer na primeira execução ou se for perdida
        if (!surface_exists(surf_video)) {
            surf_video = surface_create(_sw, _sh);
        }
        
        // Copia a imagem do vídeo para a nossa surface
        surface_set_target(surf_video);
        draw_surface(_sub_surface, 0, 0);
        surface_reset_target();
    }
}

// 3. DESENHA A SURFACE BUFFERIZADA (Fica 100% liso, sem piscar preto!)
if (surface_exists(surf_video)) {
    draw_surface_stretched(surf_video, 0, 0, display_get_gui_width(), display_get_gui_height());
} else {
    // Fundo preto apenas enquanto o 1º frame do vídeo não carrega
    draw_set_color(c_black);
    draw_set_alpha(1.0);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
}

// 4. Texto "Pressione ESPAÇO para pular"
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

if (font_exists(fnt_menu)) draw_set_font(fnt_menu);

var _alpha = abs(sin(current_time / 300));
draw_set_alpha(_alpha);

var _margin_x = display_get_gui_width() - 24;
var _margin_y = display_get_gui_height() - 20;

draw_set_color(c_black);
draw_text(_margin_x + 2, _margin_y + 2, "Pressione ESPAÇO para pular");

draw_set_color(c_white);
draw_text(_margin_x, _margin_y, "Pressione ESPAÇO para pular");

// Reseta padrões do Draw
draw_set_alpha(1.0);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);