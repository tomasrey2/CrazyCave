/// Colisión con jugador para pasar al siguiente nivel

var player = instance_find(Ohuman, 0);
if (player != noone && place_meeting(x, y, Ohuman)) {
    var ui = instance_find(UI, 0);
    if (ui != noone) {
        ui.current_level++;
        
        // Si completó todos los niveles, victoria
        if (ui.current_level > ui.max_levels) {
            ui.game_won = true;
            // No cambiar estado, mantener en INGAME para mostrar pantalla de victoria
        } else {
            // Generar siguiente nivel con el mismo fill_rate
            // Guardar posición y puntos del jugador
            var player_points = player.points;
            var player_hp = player.hp;
            
            // Destruir objetos del nivel actual
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
            if (gen != noone) {
                // Nueva seed pero mismo fill_percent
                random_set_seed(irandom(99999));
                
                // Limpiar grid anterior
                if (ds_exists(gen.grid, ds_type_grid)) {
                    ds_grid_destroy(gen.grid);
                }
                
                // Crear nuevo grid
                gen.grid = ds_grid_create(gen.map_width, gen.map_height);
                
                // Inicializar con ruido
                for (x = 0; x < gen.map_width; x++) {
                    for (y = 0; y < gen.map_height; y++) {
                        if (x == 0 || y == 0 || x == gen.map_width - 1 || y == gen.map_height - 1) {
                            gen.grid[# x, y] = 1;
                        } else {
                            gen.grid[# x, y] = (random(1) < gen.fill_percent);
                        }
                    }
                }
                
                // Suavizar mapa
                with (gen) {
                    repeat(iterations) {
                        smooth_map(grid);
                    }
                }
                
                // Conectar regiones
                with (gen) {
                    var regions = get_regions(grid);
                    if (array_length(regions) > 1) {
                        connect_regions(grid, regions);
                    }
                }
                
                // Colocar rocas y generar tiles
                with (gen) {
                    place_rocks(grid, 0.02);
                    generate_tiles(grid);
                }
                
                // Reposicionar al jugador en un Ofloor válido
                var new_player = instance_find(Ohuman, 0);
                if (new_player != noone) {
                    var floor_count = instance_number(Ofloor);
                    if (floor_count > 0) {
                        // Buscar un Ofloor que no tenga Ograss encima
                        var found_valid = false;
                        var attempts = 0;
                        
                        while (!found_valid && attempts < 100) {
                            var random_floor = instance_find(Ofloor, irandom(floor_count - 1));
                            
                            // Verificar que no haya Ograss en la misma posición o encima
                            var has_grass_here = place_meeting(random_floor.x, random_floor.y, Ograss);
                            var has_grass_above = place_meeting(random_floor.x, random_floor.y - 16, Ograss);
                            
                            if (!has_grass_here && !has_grass_above) {
                                new_player.x = random_floor.x;
                                new_player.y = random_floor.y;
                                new_player.xvelocity = 0;
                                new_player.yvelocity = 0;
                                found_valid = true;
                            }
                            attempts++;
                        }
                        
                        // Si no encontró posición válida, usar cualquier Ofloor
                        if (!found_valid) {
                            var random_floor = instance_find(Ofloor, 0);
                            new_player.x = random_floor.x;
                            new_player.y = random_floor.y;
                            new_player.xvelocity = 0;
                            new_player.yvelocity = 0;
                        }
                    }
                    
                    // Restaurar puntos y vida del jugador
                    new_player.points = player_points;
                    new_player.hp = player_hp;
                }
                
                // Spawear objetos del juego
                spawn_game_objects();
            }
        }
    }
}
