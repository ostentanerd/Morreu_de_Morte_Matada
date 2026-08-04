if (!caindo) {
    caindo = true;
    
    var _forca = 5; 
    var _dir = other.direction;
    
    hsp = lengthdir_x(_forca, _dir);
    vsp = lengthdir_y(_forca, _dir);
    
    // Gira na direção em que foi arremessada
    rot_speed = -sign(hsp) * 10; 
}