// Aplica gravidade e rotação aos pedaços
speed = max(0, speed - 0.1); // Vai desacelerando no ar
y += gravidade;
image_angle += rot_speed;

// Começa a sumir após bater no chão ou desacelerar
alpha -= 0.02;
image_alpha = alpha;

// Destrói o caco quando ficar invisível
if (alpha <= 0) {
    instance_destroy();
}