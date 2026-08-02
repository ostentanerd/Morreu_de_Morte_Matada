// -------------------------------------------------------------
// TRAVA DE SEGURANÇA: Evita duplicar o obj_controle
// -------------------------------------------------------------
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

persistent = true;



// Esconde o cursor padrão do Windows
window_set_cursor(cr_none);

// -------------------------------------------------------------
// FUNÇÕES DE SALVAMENTO (Sempre usando "save_jogo.ini")
// -------------------------------------------------------------
fase_maxima = 1; // Padrão: Apenas fase 1 liberada

scr_carregar_jogo = function() {
    ini_open("save_jogo.ini");
    fase_maxima = ini_read_real("PROGRESSO", "fase_maxima", 1);
    ini_close();
};

scr_salvar_jogo = function() {
    ini_open("save_jogo.ini");
    ini_write_real("PROGRESSO", "fase_maxima", fase_maxima);
    ini_close();
};

// Carrega o save assim que o objeto é criado
scr_carregar_jogo();

// -------------------------------------------------------------
// VARIÁVEIS DE ESTADO E FLUXO
// -------------------------------------------------------------
mira_frame    = 0;
game_over     = false;
vitoria       = false;
em_loading    = false;
loading_timer = 0;

// -------------------------------------------------------------
// SCREEN SHAKE E HITSTOP
// -------------------------------------------------------------
shake_time      = 0;
shake_magnitude = 0;
hitstop_timer   = 0;

global.scr_hitstop = function(_frames) {
    hitstop_timer = _frames;
};

// Configuração de tamanho da janela
var _escala = 4;
window_set_size(384 * _escala, 216 * _escala);
alarm[0] = 1; // Alarme para centralizar a tela