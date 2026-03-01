/// @function regenerate_map()
/// @description Regenera el mapa sin reiniciar la sala

function regenerate_map()
{
    // Limpieza de instances anteriores de tiles
    with (Ofloor) instance_destroy();
    with (Ograss) instance_destroy();
    with (Owater) instance_destroy();
    with (Orocks) instance_destroy();
    with (Ofire) instance_destroy();
    with (Omineral) instance_destroy();
with (Oportal) instance_destroy();
    
    // Limpiar grid anterior si existe
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
                gen.grid[# x, y] = 1; // borde pared
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
