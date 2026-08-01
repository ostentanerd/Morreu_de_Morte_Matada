if (instance_exists(obj_joystick)) {
    // Quando soltar o botão de disparo
    if (obj_joystick.input_shoot) {
        
        // SÓ CRIA A FOICE SE AINDA NÃO EXISTIR NENHUMA NA TELA!
        if (!instance_exists(obj_foice)) {
            var _foice = instance_create_layer(x, y, "Instances", obj_foice);
            
            // Define a direção da foice usando o ângulo da mira do joystick
            _foice.direction = obj_joystick.aim_angle;
            
            // Ajuste a velocidade do arremesso aqui (ex: 10 a 14 é um bom ritmo)
            //_foice.speed = 12; 
        }
    }
}