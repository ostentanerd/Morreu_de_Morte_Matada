var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

draw_set_font(fnt_dica);

// 1. ESCALA EXATA IGUAL AO STEP (1.0)
var _escala = 1.0; 

var _spr_w = sprite_get_width(spr_barra_fundo);
var _spr_h = sprite_get_height(spr_barra_fundo);

var _bar_largura_final = _spr_w * _escala;
var _bar_altura_final  = _spr_h * _escala;

// 2. FUNDO ESCURO SEMITRANSPARENTE (OVERLAY)
draw_set_alpha(0.85 * alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, _gui_w, _gui_h, false);

// Garante opacidade total para o texto e barras
draw_set_alpha(1.0); 

// 3. DESENHO DAS OPÇÕES E BARRAS
for (var i = 0; i < array_length(opcoes); i++) {
    var _y_pos = start_y + (i * espacamento);
    var _cor   = (i == opc_selecionada) ? c_yellow : c_white;
    
    draw_set_color(_cor);
    
    if (i == 0 || i == 1) {
        var _valor_vol = (i == 0) ? global.vol_musica : global.vol_sfx;
        var _pct_texto = string(round(_valor_vol * 100)) + "%";
        
        var _bx1 = (_gui_w / 2) - (_bar_largura_final / 2);
        var _by1 = _y_pos - (_bar_altura_final / 2);
        
        // Nome da opção à esquerda da barra
        draw_set_halign(fa_right);
        draw_set_valign(fa_middle);
        draw_text(_bx1 - 15, _y_pos, opcoes[i]);
        
        // Fundo da barra
        var _subimg = (i == opc_selecionada) ? 1 : 0;
        draw_sprite_ext(spr_barra_fundo, _subimg, _bx1, _by1, _escala, _escala, 0, c_white, alpha);
        
        // Preenchimento
        var _largura_corte_px = _spr_w * _valor_vol;
        if (_largura_corte_px > 0) {
            draw_sprite_part_ext(
                spr_barra_preenchimento, 0,
                0, 0,
                _largura_corte_px, _spr_h,
                _bx1, _by1,
                _escala, _escala,
                c_white, alpha
            );
        }
        
        // Ponteiro
        var _ponteiro_x = _bx1 + (_largura_corte_px * _escala);
        draw_sprite_ext(spr_barra_ponteiro, 0, _ponteiro_x, _y_pos, _escala, _escala, 0, c_white, alpha);
        
        // Porcentagem à direita
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(_bx1 + _bar_largura_final + 15, _y_pos, _pct_texto);
        
    } else {
        // Opção "VOLTAR"
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_gui_w / 2, _y_pos, opcoes[i]);
    }
}

// Reseta padrões do GameMaker
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1.0);