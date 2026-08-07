var _xx = other.x;
var _yy = other.y;
var _xscale = other.image_xscale;
var _layer = other.layer;

instance_destroy(other);

// Cria a vítima morta e define que foi por ERRO (Derrota)
var _morta = instance_create_layer(_xx, _yy, _layer, obj_vitima_morta_mau);
_morta.image_xscale = _xscale;
_morta.causa_morta = "derrota"; 

instance_destroy(); // Destrói a foice