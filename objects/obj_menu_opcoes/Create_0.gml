alpha = 1;             // Começa totalmente invisível
alpha_alvo = 1;        // Transiciona para visível
velocidade_fade = 0.12; // Velocidade da transição
fechando = false;       // Controla se o menu está no processo de fechar

// Lista de opções da tela
opcoes = ["MÚSICA", "SFX", "VOLTAR"];
opc_selecionada = 0; // 0 = Música, 1 = SFX, 2 = Voltar

// Trava para navegação via teclado/gamepad
timer_navegacao = 0;

// Estados de clique/arrasto pelo mouse
arrastando_musica = false;
arrastando_sfx    = false;

// Configurações Globais do Layout do Menu (Ajustadas para 384x216)
start_y     = 70;  
espacamento = 50;  
bar_largura = 120;
bar_altura  = 16;