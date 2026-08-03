// Singleton - Destrói cópias duplicadas
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

persistent = true;

// Configuração do Gamepad
gamepad_slot = -1; 

// Procura o controle na porta 0 primeiro (onde o Xbox fica na maioria dos PCs)
if (gamepad_is_connected(0)) {
    gamepad_slot = 0;
} else {
    // Se não estiver na 0, varre as outras portas
    for (var i = 0; i < gamepad_get_device_count(); i++) {
        if (gamepad_is_connected(i)) {
            gamepad_slot = i;
            break;
        }
    }
}

if (gamepad_slot != -1) {
    // Zona morta maior para evitar drift do analógico
    gamepad_set_axis_deadzone(gamepad_slot, 0.35);
}

// Estados de Input
aim_angle    = 0;       
input_aim    = false;   
input_shoot  = false;   
input_reset  = false;   
input_next   = false;   
input_voltar = false;   

origin_x = x;
origin_y = y;

last_mouse_x = mouse_x;
last_mouse_y = mouse_y;
using_gamepad = false;

image_speed = 0; // Impede a sprite de piscar
mouse_em_cima = false;

// Variável para garantir que o comando do controle não seja lido múltiplas vezes
pode_clicar_controle = true;

// VARIÁVEIS GLOBAIS PARA O SISTEMA DE TROCA DE TECLAS (REBIND)
if (!variable_global_exists("key_shoot")) {
    global.key_shoot  = vk_space;       
    global.key_reset  = ord("R");       // Padrão: R
    global.key_next   = ord("E");       // Padrão: E
    global.key_voltar = vk_escape;      
    
    global.gp_shoot   = gp_shoulderrb;  
    global.gp_reset   = gp_face2;       // Botão B
    global.gp_next    = gp_face1;       // Botão A
    global.gp_voltar  = gp_select;      
    
    // Carrega se houver arquivo salvo
    if (file_exists("config_controles.ini")) {
        ini_open("config_controles.ini");
        global.key_shoot  = ini_read_real("Controles", "key_shoot", vk_space);
        global.key_reset  = ini_read_real("Controles", "key_reset", ord("R"));
        global.key_next   = ini_read_real("Controles", "key_next", ord("E"));
        global.key_voltar = ini_read_real("Controles", "key_voltar", vk_escape);
        
        global.gp_shoot   = ini_read_real("Controles", "gp_shoot", gp_shoulderrb);
        global.gp_reset   = ini_read_real("Controles", "gp_reset", gp_face2);
        global.gp_next    = ini_read_real("Controles", "gp_next", gp_face1);
        global.gp_voltar  = ini_read_real("Contresol", "gp_voltar", gp_select);
        ini_close();
    }
}