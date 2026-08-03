if (redefinindo == noone) {
    var _baixo = keyboard_check_pressed(vk_down) || (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_padd));
    var _cima  = keyboard_check_pressed(vk_up)   || (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_padu));
    var _confirmar = keyboard_check_pressed(vk_enter) || (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face1));
    var _sair = keyboard_check_pressed(vk_escape) || (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face2));

    if (_baixo) selecionado++;
    if (_cima)  selecionado--;

    if (selecionado > array_length(menu_opcoes) - 1) selecionado = 0;
    if (selecionado < 0) selecionado = array_length(menu_opcoes) - 1;

    // Seleção por clique do mouse ajustada para a tela 384x216
    var _my = mouse_y;
    var _clique = mouse_check_button_pressed(mb_left);

    if (_clique) {
        if (_my > 60  && _my < 85)   { selecionado = 0; _confirmar = true; } // Atirar
        else if (_my > 85  && _my < 110) { selecionado = 1; _confirmar = true; } // Reiniciar
        else if (_my > 110 && _my < 135) { selecionado = 2; _confirmar = true; } // Próxima Fase
        else if (_my > 135 && _my < 160) { selecionado = 3; _confirmar = true; } // Voltar
    }

    if (_confirmar) {
        if (selecionado == 0) redefinindo = "shoot";
        if (selecionado == 1) redefinindo = "reset";
        if (selecionado == 2) redefinindo = "next";
        if (selecionado == 3) redefinindo = "voltar";
        io_clear(); 
    }

    if (_sair) {
        room_goto(rm_menu); 
    }
} 
else {
    // Modo de captura de Teclado
    if (keyboard_check_pressed(vk_anykey)) {
        var _nova_tecla = keyboard_lastkey;
        
        if (_nova_tecla != vk_escape) {
            if (redefinindo == "shoot")  global.key_shoot = _nova_tecla;
            if (redefinindo == "reset")  global.key_reset = _nova_tecla;
            if (redefinindo == "next")   global.key_next  = _nova_tecla;
            if (redefinindo == "voltar") global.key_voltar = _nova_tecla;
            
            ini_open("config_controles.ini");
            ini_write_real("Controles", "key_shoot", global.key_shoot);
            ini_write_real("Controles", "key_reset", global.key_reset);
            ini_write_real("Controles", "key_next",  global.key_next);
            ini_write_real("Controles", "key_voltar", global.key_voltar);
            ini_close();
        }
        redefinindo = noone;
        io_clear();
    }

    // Modo de captura de Controle
    if (gamepad_is_connected(0)) {
        for (var i = gp_face1; i <= gp_axisrv; i++) {
            if (gamepad_button_check_pressed(0, i)) {
                if (redefinindo == "shoot")  global.gp_shoot = i;
                if (redefinindo == "reset")  global.gp_reset = i;
                if (redefinindo == "next")   global.gp_next  = i;
                if (redefinindo == "voltar") global.gp_voltar = i;
                
                ini_open("config_controles.ini");
                ini_write_real("Controles", "gp_shoot", global.gp_shoot);
                ini_write_real("Controles", "gp_reset", global.gp_reset);
                ini_write_real("Controles", "gp_next",  global.gp_next);
                ini_write_real("Controles", "gp_voltar", global.gp_voltar);
                ini_close();
                
                redefinindo = noone;
                io_clear();
                break;
            }
        }
    }
}