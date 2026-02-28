function smooth_map(_grid) {

    var new_grid = ds_grid_create(map_width, map_height);

    for (x = 0; x < map_width; x++) {
        for (y = 0; y < map_height; y++) {

            var neighbors = count_neighbors(_grid, x, y);

            if (neighbors > 4) {
                new_grid[# x, y] = 1;
            }
            else if (neighbors < 4) {
                new_grid[# x, y] = 0;
            }
            else {
                new_grid[# x, y] = _grid[# x, y];
            }
        }
    }

    ds_grid_copy(_grid, new_grid);
    ds_grid_destroy(new_grid);
}