/// CREATE EVENT

// Configuración
map_width = 89;
map_height = 50;

fill_percent = 0.45;
iterations = 5;

cell_size = 10;

// Crear grid lógico
grid = ds_grid_create(map_width, map_height);

// Inicializar ruido
for (x = 0; x < map_width; x++) {
    for (y = 0; y < map_height; y++) {

        if (x == 0 || y == 0 || 
            x == map_width-1 || y == map_height-1) {

            grid[# x, y] = 1; // borde pared
        } 
        else {
            grid[# x, y] = (random(1) < fill_percent);
        }
    }
}

repeat(iterations) {
    smooth_map(grid);
}

var regions = get_regions(grid);

if (array_length(regions) > 1) {
    connect_regions(grid, regions);
}

// Colocar rocas aleatorias en el suelo
place_rocks(grid, 0.02);

// Generar tiles visuales
generate_tiles(grid);