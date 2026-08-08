io_clear();
display_set_gui_size(1280, 720);

// Desativa o loading do obj_controle para não dar conflito
if (instance_exists(obj_controle)) {
    obj_controle.em_loading = false;
    obj_controle.alpha_loading = 0;
}

video_open("cutscene.mp4");
video_enable_loop(false);

video_comecou = false;

// Buffer de surface para eliminar a piscação
surf_video = -1;