function generate_tiles(_grid) {

    var tilemap_id = layer_tilemap_get_id("Tiles_mapa");

    for (x = 0; x < map_width; x++) {
        for (y = 0; y < map_height; y++) {

            var tile_index;

            if (_grid[# x, y] == 1) {
                tile_index = 49; // tile pared
            } else {
                tile_index = 5; // tile piso
            }

            tilemap_set(tilemap_id, tile_index, x, y);
        }
    }
}