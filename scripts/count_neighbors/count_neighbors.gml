function count_neighbors(_grid, _x, _y) {
    var wall_count = 0;

    for (var nx = -1; nx <= 1; nx++) {
        for (var ny = -1; ny <= 1; ny++) {

            var check_x = _x + nx;
            var check_y = _y + ny;

            if (nx == 0 && ny == 0) continue;

            if (check_x < 0 || check_y < 0 || check_x >= map_width || check_y >= map_height) {
                wall_count++;
            }
            else if (_grid[# check_x, check_y] == 1) {
                wall_count++;
            }
        }
    }

    return wall_count;
}