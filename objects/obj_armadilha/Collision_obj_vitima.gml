if (caindo) {
    // 1. Spawna a vítima morta no mesmo local e na mesma direção
    if (instance_exists(other)) {
        var _corpo = instance_create_layer(other.x, other.y, "Instances", obj_vitima_morta);
        _corpo.image_xscale = other.image_xscale;
        
        instance_destroy(other);
    }

    // 2. Criar estilhaços
    repeat (8) {
        instance_create_layer(x, y, "Instances", obj_estilhaco);
    }
    
    // 3. Marca Vitória no controle
    if (instance_exists(obj_controle)) {
        obj_controle.vitoria = true;
    }

    // 4. Hitstop (Pausa dramática de impacto)
    global.scr_hitstop(4);
    
    // 5. Destrói a armadilha ao impactar
    instance_destroy();
}