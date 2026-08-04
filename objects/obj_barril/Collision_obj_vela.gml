// Só explode se a vela estiver de fato caindo/acesa
if (other.caindo) {
    // 1. Cria o objeto de explosão no centro do barril
    instance_create_layer(x, y, "Instances", obj_explosao);
    
    // 2. Destrói a vela e o próprio barril
    with (other) instance_destroy();
    instance_destroy();
}