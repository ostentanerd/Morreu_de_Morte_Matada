var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

draw_set_font(fnt_dica);

// -------------------------------------------------------------
// 1. CONFIGURAÇÃO DE ESCALA E TAMANHO DAS BARRAS
// -------------------------------------------------------------
var _escala = 3.5; // Aumente para 3 ou 4 se ainda achar pequeno na tela

// Pega o tamanho original do seu sprite de fundo
var _spr_w = sprite_get_width(spr_barra_fundo);
var _spr_h = sprite_get_height(spr_barra_fundo);

// Tamanho final escalado na tela
var _bar_largura_final = _spr_w * _escala;
var _bar_altura_final  = _spr_h * _escala;

// -------------------------------------------------------------
// 2. FUNDO ESCURO SEMITRANSPARENTE (OVERLAY)
// -------------------------------------------------------------
draw_set_alpha(0.85 * alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, _gui_w, _gui_h, false);

draw_set_alpha(alpha); // Restaura alpha para o menu

// -------------------------------------------------------------
// 3. DESENHO DAS OPÇÕES E BARRAS
// -------------------------------------------------------------
for (var i = 0; i < array_length(opcoes); i++) {
    var _y_pos = start_y + (i * espacamento);
    var _cor   = (i == opc_selecionada) ? c_yellow : c_white;
    
    draw_set_color(_cor);
    
    // OPÇÕES COM BARRA DE VOLUME (MÚSICA E SFX)
    if (i == 0 || i == 1) {
        var _valor_vol = (i == 0) ? global.vol_musica : global.vol_sfx;
        var _pct_texto = string(round(_valor_vol * 100)) + "%";
        
        // Posição do canto superior esquerdo da barra (Centralizada na tela)
        var _bx1 = (_gui_w / 2) - (_bar_largura_final / 2);
        var _by1 = _y_pos - (_bar_altura_final / 2);
        
        // --- TEXTO DO NOME (Ancorado à esquerda da barra sem sobrepor) ---
        draw_set_halign(fa_right);
        draw_set_valign(fa_middle);
        draw_text(_bx1 - 20, _y_pos, opcoes[i]);
        
        // --- 1. SPRITE DE FUNDO ---
        var _subimg = (i == opc_selecionada) ? 1 : 0;
        draw_sprite_ext(spr_barra_fundo, _subimg, _bx1, _by1, _escala, _escala, 0, c_white, alpha);
        
        // --- 2. SPRITE DE PREENCHIMENTO (CORTADO E ESCALADO) ---
        var _largura_corte_px = _spr_w * _valor_vol; // Quantidade de pixels originais a desenhar
        
        if (_largura_corte_px > 0) {
            draw_sprite_part_ext(
                spr_barra_preenchimento, 0,
                0, 0,                          // Origem X, Y no sprite original
                _largura_corte_px, _spr_h,      // Largura e Altura cortadas
                _bx1, _by1,                    // Posição X, Y na tela
                _escala, _escala,              // Escala X, Y
                c_white, alpha
            );
        }
        
        // --- 3. SPRITE DO PONTEIRO/KNOB ---
        var _ponteiro_x = _bx1 + (_largura_corte_px * _escala);
        // Desenha centralizado verticalmente na linha
        draw_sprite_ext(spr_barra_ponteiro, 0, _ponteiro_x, _y_pos, _escala, _escala, 0, c_white, alpha);
        
        // --- TEXTO DA PORCENTAGEM (Ancorado à direita da barra) ---
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_text(_bx1 + _bar_largura_final + 20, _y_pos, _pct_texto);
        
    } else {
        // OPÇÃO "VOLTAR"
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_gui_w / 2, _y_pos, opcoes[i]);
    }
}

// Reseta padrões do GameMaker
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1.0);