draw_set_font(fnt_menu_controle);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _cx = floor(room_width / 2); // 192

// Título no topo da tela (travado em inteiro)
draw_set_color(c_white);
draw_text(_cx, floor(25), "CONTROLES");

var _func_nome_tecla = function(_tecla) {
    if (_tecla == vk_space) return "ESPAÇO";
    if (_tecla == vk_enter) return "ENTER";
    if (_tecla == vk_escape) return "ESC";
    return chr(_tecla);
};

// Alturas fixas em pixels inteiros
var _pos_ys = [62, 87, 112, 137];

for (var i = 0; i < array_length(menu_opcoes); i++) {
    var _cor = (selecionado == i) ? c_yellow : c_white;
    draw_set_color(_cor);
    
    var _estado_redefinindo = false;
    if (i == 0 && redefinindo == "shoot") _estado_redefinindo = true;
    if (i == 1 && redefinindo == "reset") _estado_redefinindo = true;
    if (i == 2 && redefinindo == "next")  _estado_redefinindo = true;
    if (i == 3 && redefinindo == "voltar")_estado_redefinindo = true;
    
    // Trava a posição Y em um número inteiro exato para evitar sub-pixels
    var _y_atual = floor(_pos_ys[i]);
    
    if (_estado_redefinindo) {
        draw_text(_cx, _y_atual, menu_opcoes[i] + ": [ APERTE... ]");
    } else {
        var _txt_tecla = "";
        if (i == 0) _txt_tecla = _func_nome_tecla(global.key_shoot);
        if (i == 1) _txt_tecla = _func_nome_tecla(global.key_reset);
        if (i == 2) _txt_tecla = _func_nome_tecla(global.key_next);
        if (i == 3) _txt_tecla = _func_nome_tecla(global.key_voltar);
        
        draw_text(_cx, _y_atual, menu_opcoes[i] + ": " + _txt_tecla);
    }
}
var _centro_x = room_width / 2;
var _titulo_y = 180;

// Rodapé na parte inferior da tela (travado em inteiro)
draw_set_color(c_white);
var _titulo_escala = 0.6; // Título bem maior que o resto
draw_text_transformed(_centro_x, _titulo_y, "Setas + ENTER | ESC para voltar", _titulo_escala, _titulo_escala, 0);
//draw_text(_cx, floor(100), "Setas + ENTER | ESC para voltar");

draw_set_halign(fa_left);
draw_set_valign(fa_top);