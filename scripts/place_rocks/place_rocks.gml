function place_rocks(_grid, _rock_chance = 0.08) {
    
    var rock_value = 2;
    
    for (x = 1; x < map_width - 1; x++) {
        for (y = 1; y < map_height - 1; y++) {
            
            // Only place rocks on floor tiles
            if (_grid[# x, y] == 0) {
                
                // Random chance to place a rock
                if (random(1) < _rock_chance) {
                    _grid[# x, y] = rock_value;
                }
            }
        }
    }
}
