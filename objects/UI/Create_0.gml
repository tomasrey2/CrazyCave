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

// Dificultad
difficulty_selected = 1; // 0 = Fácil, 1 = Normal, 2 = Difícil
difficulty_levels = [0.65, 0.5, 0.45];
difficulty_names = ["FACIL", "NORMAL", "DIFICIL"];

// Sistema de niveles
game_won = false;
current_level = 1;
max_levels = 5;

// Créditos finales
credits_timer = 0;
credits_min_frames = room_speed * 4; // 4 segundos mínimos en pantalla
credits_auto_return_frames = room_speed * 8; // volver al menú automáticamente en 8 segundos
