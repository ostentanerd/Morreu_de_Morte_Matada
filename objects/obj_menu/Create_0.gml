opcoes = ["CONTINUAR", "NOVO JOGO", "FASE", "CONTROLES", "OPÇÕES", "SAIR"]; 
index = 0; // Opção selecionada

// Array para controlar a animação de escala
escala_opcoes = [1, 1, 1, 1, 1, 1];  

// Configuração de layout
y_inicial = 90; 
espacamento = 18; 

// TRAVA DE SEGURANÇA: Impede que cliques ao fechar submenus reativem o menu principal
cooldown_input = 0;