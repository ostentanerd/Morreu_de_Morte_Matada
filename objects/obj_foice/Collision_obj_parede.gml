// Dentro do evento de colisão da obj_foice com a parede (ou no script de ricochete):
if (pode_ricochetear) {
    
    move_bounce_solid(true); // Exemplo da sua física de rebate
    
    // --- CHAME O SOM AQUI ---
    if (instance_exists(obj_audio)) {
        obj_audio.tocar_sfx(snd_ricochete);
    }
    
    bounces_left--;
    pode_ricochetear = false;
    alarm[0] = 5; // Cooldown


    // 4. Se gastou todos os ricochetes, destrói a foice
    if (bounces_left <= 0) {
        instance_destroy();
    }
}