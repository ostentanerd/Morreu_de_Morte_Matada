y += vsp;
x += hsp;

// Vai sumindo aos poucos
image_alpha -= 0.02;

// Destrói quando ficar 100% transparente
if (image_alpha <= 0) {
    instance_destroy();
}