// Escolhe um frame aleatório da sprite para variar os cacos
image_index = irandom(image_number - 1);
image_speed = 0; // Para não ficar piscando os frames

// Define uma direção aleatória para cima/lados ao explodir
direction = random_range(30, 150); 
speed = random_range(1, 4);

// Rotação visual e gravidade do caco
rot_speed = random_range(-05, 05);
gravidade = 0.5;

// Transparência para sumir suavemente
alpha = 1;