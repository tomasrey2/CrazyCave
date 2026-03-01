var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

button_hover = -1;

// ================= MAIN MENU =================
if (ui_state == UIState.MAIN_MENU)
{
    if (mouse_check_button_pressed(mb_left))
    {
        if (point_in_rectangle(mx, my, 300, 250, 500, 300)) {
            ui_state = UIState.MAP_SELECT;
        }
        
        if (point_in_rectangle(mx, my, 300, 320, 500, 370)) {
            ui_state = UIState.SETTINGS;
        }
        
        if (point_in_rectangle(mx, my, 300, 390, 500, 440)) {
            game_end();
        }
    }
}

// ================= MAP SELECT =================
if (ui_state == UIState.MAP_SELECT)
{
    if (keyboard_check_pressed(ord("R")))
    {
        selected_map_seed = irandom(99999);
        random_set_seed(selected_map_seed);
        generate_new_map(); // tu función
    }
    
    if (keyboard_check_pressed(vk_enter))
    {
        ui_state = UIState.INGAME;
    }
}

// ================= SETTINGS =================
if (ui_state == UIState.SETTINGS)
{
    if (keyboard_check_pressed(vk_escape))
        ui_state = UIState.MAIN_MENU;

    // Fullscreen toggle
    if (keyboard_check_pressed(ord("F")))
    {
        window_set_fullscreen(!window_get_fullscreen());
    }

    // Ajustar tamaño mapa
    if (keyboard_check_pressed(vk_up)) map_width += 10;
    if (keyboard_check_pressed(vk_down)) map_width = max(20, map_width - 10);

    // Ajustar dificultad
    if (keyboard_check_pressed(vk_right)) fill_percent = min(0.7, fill_percent + 0.05);
    if (keyboard_check_pressed(vk_left)) fill_percent = max(0.2, fill_percent - 0.05);
}