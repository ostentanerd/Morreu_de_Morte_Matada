// -------------------------------------------------------------
// ANIMAÇÃO DE ENTRADA E SAÍDA (FADE)
// -------------------------------------------------------------
alpha = 0;              // Começa totalmente invisível
alpha_alvo = 1;         // Transiciona para visível
velocidade_fade = 0.12; // Velocidade da transição (0.05 mais lento, 0.2 mais rápido)
fechando = false;       // Controla se o menu está no processo de fechar




// Lista de opções da tela
opcoes = ["MÚSICA", "(SFX)", "VOLTAR"];
opc_selecionada = 0; // 0 = Música, 1 = SFX, 2 = Voltar

// Trava para navegação via teclado/gamepad
timer_navegacao = 0;

// Estados de clique/arrasto pelo mouse
arrastando_musica = false;
arrastando_sfx    = false;

// Configurações Globais do Layout do Menu (Usadas no Step e Draw GUI)
start_y      = 220;
espacamento  = 80;
bar_largura  = 200;
bar_altura   = 16;