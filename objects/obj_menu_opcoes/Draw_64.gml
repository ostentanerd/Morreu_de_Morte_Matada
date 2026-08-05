var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

draw_set_font(fnt_dica);

// -------------------------------------------------------------
// FUNDO ESCURO SEMITRANSPARENTE (SUAVE COM ALPHA DE ENTRADA)
// -------------------------------------------------------------
draw_set_alpha(0.85 * alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, _gui_w, _gui_h, false);

// Ajusta a opacidade global dos textos e barras para acompanhar a transição
draw_set_alpha(alpha);

// -------------------------------------------------------------
// DESENHO UNIFICADO DAS OPÇÕES E BARRAS DE VOLUME
// -------------------------------------------------------------
for (var i = 0; i < array_length(opcoes); i++) {
    var _y_pos = start_y + (i * espacamento);
    var _cor = (i == opc_selecionada) ? c_yellow : c_white;
    
    draw_set_color(_cor);
    
    // Opções de volume (Música e SFX)
    if (i == 0 || i == 1) {
        var _valor_vol = (i == 0) ? global.vol_musica : global.vol_sfx;
        var _pct_texto = string(round(_valor_vol * 100)) + "%";
        
        // Texto do nome da opção
        draw_set_halign(fa_right);
        draw_set_valign(fa_middle);
        draw_text(_gui_w / 2 - 120, _y_pos, opcoes[i]);
        
        // Coordenadas da barra de volume
        var _bx1 = (_gui_w / 2) - 80;
        var _by1 = _y_pos - (bar_altura / 2);
        var _bx2 = _bx1 + bar_largura;
        var _by2 = _by1 + bar_altura;
        
        // Fundo cinza escuro
        draw_rectangle_color(_bx1, _by1, _bx2, _by2, c_dkgray, c_dkgray, c_dkgray, c_dkgray, false);
        
        // Preenchimento proporcional ao volume
        var _preenchimento_x = _bx1 + (bar_largura * _valor_vol);
        var _cor_barra = (i == opc_selecionada) ? c_lime : c_green;
        if (_valor_vol > 0) {
            draw_rectangle_color(_bx1, _by1, _preenchimento_x, _by2, _cor_barra, _cor_barra, _cor_barra, _cor_barra, false);
        }
        
        // Borda de seleção amarela ou borda preta padrão
        if (i == opc_selecionada) {
            draw_rectangle_color(_bx1 - 2, _by1 - 2, _bx2 + 2, _by2 + 2, c_yellow, c_yellow, c_yellow, c_yellow, true);
        } else {
            draw_rectangle_color(_bx1, _by1, _bx2, _by2, c_black, c_black, c_black, c_black, true);
        }
        
        // Texto da porcentagem
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(_bx2 + 20, _y_pos, _pct_texto);
        
    } else {
        // Opção "VOLTAR"
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_gui_w / 2, _y_pos, opcoes[i]);
    }
}

// Reseta o alinhamento de texto e opacidade padrão do GameMaker
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1.0);