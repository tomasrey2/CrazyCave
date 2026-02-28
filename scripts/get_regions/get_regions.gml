function get_regions(_grid) {

    var visited = ds_grid_create(map_width, map_height);
    ds_grid_clear(visited, 0);

    var regions = [];

    for (x = 0; x < map_width; x++) {
        for (y = 0; y < map_height; y++) {

            if (_grid[# x, y] == 0 && visited[# x, y] == 0) {

                var region = [];
                var stack = [[x, y]];
                visited[# x, y] = 1;

                while (array_length(stack) > 0) {

                    var cell = stack[array_length(stack)-1];
                    array_resize(stack, array_length(stack)-1);

                    var cx = cell[0];
                    var cy = cell[1];

                    array_push(region, [cx, cy]);

                    var dirs = [[1,0],[-1,0],[0,1],[0,-1]];

                    for (var d = 0; d < 4; d++) {

                        var nx = cx + dirs[d][0];
                        var ny = cy + dirs[d][1];

                        if (nx >= 0 && ny >= 0 &&
                            nx < map_width && ny < map_height) {

                            if (_grid[# nx, ny] == 0 &&
                                visited[# nx, ny] == 0) {

                                visited[# nx, ny] = 1;
                                array_push(stack, [nx, ny]);
                            }
                        }
                    }
                }

                array_push(regions, region);
            }
        }
    }

    ds_grid_destroy(visited);
    return regions;
}
