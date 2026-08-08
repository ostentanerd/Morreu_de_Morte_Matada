// Força o sprite correto
sprite_index = spr_estilhaco_caixa;

// Trava a animação e sorteia 1 dos 5 frames (0, 1, 2, 3, 4)
image_speed = 0;
image_index = irandom(image_number - 1);

// Efeito de rotação enquanto voa
rotacao_speed = random_range(-12, 12);

// Destrói após 60 frames (1 segundo) para não acumular na memória
alarm[0] = 60;