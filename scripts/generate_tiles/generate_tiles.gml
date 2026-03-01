function generate_tiles(_grid) {

    var tile_size = 16; // Size of each tile in pixels
    var layer_id = layer_get_id("Instances");

    for (x = 0; x < map_width; x++) {
        for (y = 0; y < map_height; y++) {

            if (_grid[# x, y] == 1) {
                // Create wall - Orocks object
                instance_create_layer(x * tile_size, y * tile_size, layer_id, Ograss);
            } else if (_grid[# x, y] == 2) {
                // Create rock - Orocks object
                instance_create_layer(x * tile_size, y * tile_size, layer_id, Orocks);
            } else {
                // Create grass - Ograss object
                instance_create_layer(x * tile_size, y * tile_size, layer_id, Ofloor);
            }
        }
    }
}