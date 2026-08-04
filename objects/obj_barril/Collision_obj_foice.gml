// 1. (Opcional) Cria restos de madeira se você tiver uma sprite/objeto de barril quebrado
 instance_create_layer(x, y, "Instances", obj_barril_quebrado);

// 2. Destrói o barril diretamente sem criar a explosão
instance_destroy();