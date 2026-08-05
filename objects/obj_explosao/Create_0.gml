event_inherited(); // Mantém o que tem no pai
esta_ativa = true; // Enquanto existir, conta como ativa



// Raio de alcance da explosão em pixels
var _raio = 43;

// Se a vítima existir e estiver no alcance da explosão
if (instance_exists(obj_vitima)) {
    with (obj_vitima) {
        // Checa se esta vítima específica está dentro da área da explosão
        if (point_distance(x, y, other.x, other.y) <= _raio) {
            
            // 1. Spawna o corpo morto exatamente na posição e lado da vítima
            var _corpo = instance_create_layer(x, y, "Instances", obj_vitima_morta);
            _corpo.image_xscale = image_xscale;
            
            // 2. Define que a causa da morte foi o alvo correto (Vitória)
            _corpo.causa_morta = "vitoria"; 
            
            // 3. Destrói a vítima viva
            instance_destroy(); 
        }
    }
}

// Destrói caixas/obstáculos próximos também
if (instance_exists(obj_caixa)) {
    with (obj_caixa) {
        if (point_distance(x, y, other.x, other.y) <= _raio) {
            instance_destroy();
        }
    }
}