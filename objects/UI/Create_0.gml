enum UIState {
    MAIN_MENU,
    MAP_SELECT,
    SETTINGS,
    INGAME
}

ui_state = UIState.MAIN_MENU;

// Variables configurables
map_width = 100;
map_height = 100;
fill_percent = 0.45;

selected_map_seed = irandom(99999);

button_hover = -1;
