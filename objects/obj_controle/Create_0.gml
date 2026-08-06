// Garante que os desenhos do DRAW GUI fiquem no tamanho certo da Pixel Art
display_set_gui_size(384, 216);



// =============================================================
// 1. TRAVA DE SEGURANÇA (SINGLETON)
// Deve ser a PRIMEIRA coisa a rodar para interromper duplicatas imediatamente.
// =============================================================
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

persistent = true;

// -------------------------------------------------------------
// CONFIGURAÇÕES DE JANELA E TELA
// -------------------------------------------------------------
window_set_cursor(cr_none); // Esconde o cursor padrão do Windows

var _escala = 4;
window_set_size(384 * _escala, 216 * _escala);
alarm[0] = 1; // Alarme para centralizar a janela (window_center())

// -------------------------------------------------------------
// OPÇÕES DE ÁUDIO (opcoes.ini)
// -------------------------------------------------------------
scr_salvar_opcoes = function() {
    ini_open("opcoes.ini");
    ini_write_real("Audio", "vol_musica", global.vol_musica);
    ini_write_real("Audio", "vol_sfx", global.vol_sfx);
    ini_close();
};

scr_carregar_opcoes = function() {
    ini_open("opcoes.ini");
    global.vol_musica = ini_read_real("Audio", "vol_musica", 0.7);
    global.vol_sfx    = ini_read_real("Audio", "vol_sfx", 0.8);
    ini_close();
};

scr_carregar_opcoes(); // Carrega as opções de áudio ao iniciar

// -------------------------------------------------------------
// PROGRESSO DO JOGO (save_jogo.ini)
// -------------------------------------------------------------
fase_maxima = 1; // Padrão: Apenas a fase 1 liberada

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

scr_carregar_jogo(); // Carrega o progresso ao iniciar

// -------------------------------------------------------------
// VARIÁVEIS DE ESTADO E FLUXO DE JOGO
// -------------------------------------------------------------
mira_frame    = 0;
game_over     = false;
vitoria       = false;
em_loading    = false;
loading_timer = 0;

// Mecânica de Foice / Derrota
timer_derrota = 0;
foice_lancada = false;

// -------------------------------------------------------------
// SCREEN SHAKE E HITSTOP
// -------------------------------------------------------------
shake_time      = 0;
shake_magnitude = 0;
hitstop_timer   = 0;

global.scr_hitstop = function(_frames) {
    hitstop_timer = _frames;
};

// -------------------------------------------------------------
// DICAS E TELA DE LOADING
// -------------------------------------------------------------
randomize(); // Garante sorteios aleatórios únicos a cada inicialização
arte_escolhida = -1;
alpha_loading  = 0;
dica_escolhida = "DICA: Explore bem as gavetas e cômodas.";