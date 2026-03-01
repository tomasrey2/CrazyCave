var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();
var center_x = gui_width / 2;
var center_y = gui_height / 2;

var text_width = 150;
var text_height = 30;

button_hover = -1;

// ================= MAIN MENU =================
if (ui_state == UIState.MAIN_MENU)
{
    if (mouse_check_button_pressed(mb_left))
    {
        // JUGAR
        if (point_in_rectangle(mx, my, center_x - text_width, center_y - 50 - text_height, 
                                       center_x + text_width, center_y - 50 + text_height)) {
            ui_state = UIState.MAP_SELECT;
        }
        
        // CONFIGURACION
        if (point_in_rectangle(mx, my, center_x - text_width, center_y + 20 - text_height, 
                                       center_x + text_width, center_y + 20 + text_height)) {
            ui_state = UIState.SETTINGS;
        }
        
        // SALIR
        if (point_in_rectangle(mx, my, center_x - text_width, center_y + 90 - text_height, 
                                       center_x + text_width, center_y + 90 + text_height)) {
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
        
        // Regenerar tiles del mapa
        with (Ofloor) instance_destroy();
        with (Ograss) instance_destroy();
        with (Owater) instance_destroy();
        with (Orocks) instance_destroy();
        with (Ofire) instance_destroy();
        with (Omineral) instance_destroy();
        with (Oportal) instance_destroy();
        with (Owater_level) instance_destroy();
        
        // Obtener referencia a map_generator
        var gen = instance_find(map_generator, 0);
        if (gen != noone)
        {
            // Limpiar grid anterior
            if (ds_exists(gen.grid, ds_type_grid))
            {
                ds_grid_destroy(gen.grid);
            }
            
            // Crear nuevo grid
            gen.grid = ds_grid_create(gen.map_width, gen.map_height);
            
            // Inicializar con ruido
            for (x = 0; x < gen.map_width; x++)
            {
                for (y = 0; y < gen.map_height; y++)
                {
                    if (x == 0 || y == 0 || x == gen.map_width - 1 || y == gen.map_height - 1)
                    {
                        gen.grid[# x, y] = 1;
                    }
                    else
                    {
                        gen.grid[# x, y] = (random(1) < gen.fill_percent);
                    }
                }
            }
            
            // Suavizar mapa
            with (gen) {
                repeat(iterations)
                {
                    smooth_map(grid);
                }
            }
            
            // Conectar regiones
            with (gen) {
                var regions = get_regions(grid);
                if (array_length(regions) > 1)
                {
                    connect_regions(grid, regions);
                }
            }
            
            // Colocar rocas y generar tiles
            with (gen) {
                place_rocks(grid, 0.02);
                generate_tiles(grid);
            }
            
            // Spawear objetos del juego
            spawn_game_objects();
        }
    }
    
    if (keyboard_check_pressed(vk_enter))
    {
        current_level = 1; // Resetear nivel al empezar
        ui_state = UIState.INGAME;
    }
}

// ================= SETTINGS =================
if (ui_state == UIState.SETTINGS)
{
    if (keyboard_check_pressed(vk_escape))
        ui_state = UIState.MAIN_MENU;

    // Seleccionar dificultad con flechas
    if (keyboard_check_pressed(vk_left))
        difficulty_selected = max(0, difficulty_selected - 1);
    
    if (keyboard_check_pressed(vk_right))
        difficulty_selected = min(2, difficulty_selected + 1);
    
    // Actualizar fill_percent basado en la dificultad seleccionada
    fill_percent = difficulty_levels[difficulty_selected];
    
    // Sincronizar con map_generator si existe
    if (instance_exists(map_generator))
    {
        map_generator.fill_percent = fill_percent;
    }
}

// ================= INGAME =================
if (ui_state == UIState.INGAME)
{
    if (game_won)
    {
        // Mantener créditos en pantalla por un tiempo mínimo
        credits_timer += 1;

        // Permitir ENTER solo después del tiempo mínimo
        if (credits_timer >= credits_min_frames && keyboard_check_pressed(vk_enter))
        {
            game_won = false;
            current_level = 1;
            credits_timer = 0;
            
            // Reiniciar HP y puntos del jugador
            if (instance_exists(Ohuman))
            {
                Ohuman.hp = 100;
                Ohuman.points = 0;
            }
            
            // Reiniciar room
            room_restart();
        }

        // Volver automáticamente al menú principal al terminar créditos
        if (credits_timer >= credits_auto_return_frames)
        {
            game_won = false;
            current_level = 1;
            credits_timer = 0;
            ui_state = UIState.MAIN_MENU;
            hp = 100;
max_hp = 100;
        }
    }
    else
    {
        credits_timer = 0;
    }
}
