if (!quebrada) {
    quebrada = true;
    
    // toca som de madeira quebrando (se tiver)
    // audio_play_sound(snd_caixa_quebrando, 1, false);
    
    // 1. Gera estilhaços aleatórios para dar efeito visual de explosão
    repeat(5) {
        var _estilhaco_visual = instance_create_layer(x, y, "Instances", obj_estilhaco_caixa);
        _estilhaco_visual.direction = random_range(0, 360);
        _estilhaco_visual.speed = random_range(3, 7);
        _estilhaco_visual.gravity = 0.25; // Peso caindo
    }
    
    // 2. Gera O ESTILHAÇO PRINCIPAL (Guiado na direção da Corda para a reação NUNCA falhar)
    if (instance_exists(obj_corda)) {
        var _corda_alvo = instance_nearest(x, y, obj_corda);
        var _estilhaco_preciso = instance_create_layer(x, y, "Instances", obj_estilhaco_caixa);
        
        // Aponta diretamente para a corda
        var _dir = point_direction(x, y, _corda_alvo.x, _corda_alvo.y);
        _estilhaco_preciso.direction = _dir;
        _estilhaco_preciso.speed = 8;
        _estilhaco_preciso.gravity = 0; // Voa reto como uma lâmina
        _estilhaco_preciso.e_corta_corda = true; // Marca como o estilhaço fatal
    }
    
    // Destrói a caixa
    instance_destroy();
}