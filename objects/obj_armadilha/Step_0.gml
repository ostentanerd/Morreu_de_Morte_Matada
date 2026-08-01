// Se a corda foi cortada, a armadilha cai
if (caindo) {
    vsp += gravidade;
    y += vsp;
}

// Destrói se cair fora da sala
if (y > room_height + 100) {
    instance_destroy();
}