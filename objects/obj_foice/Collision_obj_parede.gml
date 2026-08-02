// Só processa a batida se a proteção estiver liberada
if (pode_ricochetear) {
    
    // 1. Executa o ricochete
    move_bounce_solid(true);

    // 2. Decrementa 1 ricochete
    bounces_left--;

    // 3. Ativa o bloqueio temporário
    pode_ricochetear = false;
    
    // Libera para poder ricochetear de novo após 3 frames (tempo para sair de dentro da parede)
    alarm[0] = 3;

    // 4. Se gastou todos os ricochetes, destrói a foice
    if (bounces_left <= 0) {
        instance_destroy();
    }
}