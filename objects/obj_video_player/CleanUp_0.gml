video_close();
display_set_gui_size(384, 216);

// Libera a memória da surface personalizada ao sair
if (surface_exists(surf_video)) {
    surface_free(surf_video);
}