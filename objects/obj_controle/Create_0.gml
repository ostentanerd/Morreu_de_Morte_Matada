// Garante que só exista 1 controle ativo na memória
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit; // Para a execução do script para a cópia extra
}

persistent = true;

// Esconde o cursor
window_set_cursor(cr_none);

mira_frame = 0;
game_over  = false;

// Ajuste do tamanho da janela
var _escala = 4;
window_set_size(384 * _escala, 216 * _escala);
alarm[0] = 1;