// -------------------------------------------------------------
// 1. CHECA COLISÃO COM A FOICE (QUANDO A VELA AINDA ESTÁ PARADA)
// -------------------------------------------------------------
if (!caindo) {
    var _foice = instance_place(x, y, obj_foice);
    
    if (_foice != noone) {
        caindo = true;
        
        var _forca = 5; 
        var _dir = _foice.direction;
        
        hsp = lengthdir_x(_forca, _dir);
        vsp = lengthdir_y(_forca, _dir);
        rot_speed = -sign(hsp) * 10;
    }
}

// -------------------------------------------------------------
// 2. REDUÇÃO DA LUZ E PARTÍCULAS DE FOGO NO PAVIO
// -------------------------------------------------------------
if (caindo) {
    // Reduz o tamanho e a opacidade da luz gradualmente até 0
    luz_tamanho = max(0, luz_tamanho - luz_apagar_velocidade);
    luz_alpha = max(0, luz_alpha - (luz_apagar_velocidade * 0.5));
}

// Só desenha o fogo no pavio se a luz ainda não apagou completamente
if (luz_tamanho > 0.1) {
    var _distancia_pavio = 16; // Altura do pavio em relação à sprite
    var _fogo_x = x + lengthdir_x(_distancia_pavio, image_angle + 90);
    var _fogo_y = y + lengthdir_y(_distancia_pavio, image_angle + 90);

    part_particles_create(part_sys, _fogo_x, _fogo_y, part_fogo, 1);
}

// -------------------------------------------------------------
// 3. MOVIMENTAÇÃO, FÍSICA E QUIQUES
// -------------------------------------------------------------
if (caindo) {
    vsp += grav;
    image_angle += rot_speed;
    
    // Faíscas saem enquanto a vela ainda estiver um pouco acesa
    if (luz_tamanho > 0.05) {
        part_particles_create(part_sys, x, y, part_faisca, 1);
    }

    // Colisão Horizontal
    if (place_meeting(x + hsp, y, obj_parede)) {
        while (!place_meeting(x + sign(hsp), y, obj_parede)) {
            x += sign(hsp);
        }
        hsp = -hsp * 0.6; 
        rot_speed = -rot_speed * 0.7;
        part_particles_create(part_sys, x, y, part_faisca, 3);
    }
    x += hsp;
    
    // Colisão Vertical
    if (place_meeting(x, y + vsp, obj_parede)) {
        while (!place_meeting(x, y + sign(vsp), obj_parede)) {
            y += sign(vsp);
        }
        
        if (abs(vsp) > 1.5) {
            vsp = -vsp * 0.5;
            hsp *= 0.8;
            rot_speed *= 0.6;
            part_particles_create(part_sys, x, y, part_faisca, 3);
        } 
        else {
            // Apaga ao parar no chão
            repeat (3) {
                instance_create_layer(x + random_range(-2, 2), y, "Instances", obj_fumaca);
            }
            instance_destroy(); 
        }
    } else {
        y += vsp;
    }
}

esta_ativa = caindo;