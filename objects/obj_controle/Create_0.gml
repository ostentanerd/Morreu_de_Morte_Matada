persistent = true;

// Esconde o cursor padrão do sistema operacional
window_set_cursor(cr_none);

// Variável para controlar a animação da mira
mira_frame = 0;

// Ajusta o tamanho da janela (4x a resolução 384x216 = 1536x864)
var _escala = 4;
window_set_size(384 * _escala, 216 * _escala);

// Alarm para centralizar a janela na tela do PC
alarm[0] = 1;