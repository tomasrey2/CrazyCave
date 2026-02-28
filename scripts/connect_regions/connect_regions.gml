function connect_regions(_grid, regions) {

    if (array_length(regions) <= 1) {
        return;
    }

    var main_index = 0;
    var main_size = array_length(regions[0]);

    for (var r = 1; r < array_length(regions); r++) {
        var region_size = array_length(regions[r]);
        if (region_size > main_size) {
            main_size = region_size;
            main_index = r;
        }
    }

    if (main_index != 0) {
        var temp = regions[0];
        regions[0] = regions[main_index];
        regions[main_index] = temp;
    }

    var main_region = regions[0];

    for (var i = 1; i < array_length(regions); i++) {

        var region = regions[i];

        var best_distance = 30;
        var best_a = undefined;
        var best_b = undefined;

        for (var a = 0; a < array_length(main_region); a++) {
            for (var b = 0; b < array_length(region); b++) {

                var ax = main_region[a][0];
                var ay = main_region[a][1];
                var bx = region[b][0];
                var by = region[b][1];

                var dist = point_distance(ax, ay, bx, by);

                if (dist < best_distance) {
                    best_distance = dist;
                    best_a = [ax, ay];
                    best_b = [bx, by];
                }
            }
        }

        if (!is_undefined(best_a) && !is_undefined(best_b)) {
            carve_tunnel(_grid, best_a[0], best_a[1], best_b[0], best_b[1]);
        }

        for (var k = 0; k < array_length(region); k++) {
            array_push(main_region, region[k]);
        }
    }
}

function carve_tunnel(_grid, x1, y1, x2, y2) {

    x = x1;
    y = y1;
    var max_steps = map_width * map_height * 2;
    var steps = 0;

    while ((x != x2 || y != y2) && steps < max_steps) {

        var dx = x2 - x;
        var dy = y2 - y;

        var move_x = 0;
        var move_y = 0;

        if (abs(dx) > abs(dy)) {
            move_x = sign(dx);
        } else if (abs(dy) > abs(dx)) {
            move_y = sign(dy);
        } else {
            if (irandom(1) == 0) {
                move_x = sign(dx);
            } else {
                move_y = sign(dy);
            }
        }

        if (irandom(99) < 30) {
            if (irandom(1) == 0) {
                move_x = choose(-1, 1);
                move_y = 0;
            } else {
                move_x = 0;
                move_y = choose(-1, 1);
            }
        }

        var next_x = clamp(x + move_x, 1, map_width - 2);
        var next_y = clamp(y + move_y, 1, map_height - 2);

        if (next_x == x && next_y == y) {
            if (x != x2) {
                next_x = clamp(x + sign(dx), 1, map_width - 2);
            }
            if (y != y2) {
                next_y = clamp(y + sign(dy), 1, map_height - 2);
            }
        }

        x = next_x;
        y = next_y;

        carve_circle(_grid, x, y, irandom_range(1, 2));
        steps++;
    }

    carve_circle(_grid, x2, y2, 2);
}

function carve_circle(_grid, cx, cy, radius) {

    for (var dx = -radius; dx <= radius; dx++) {
        for (var dy = -radius; dy <= radius; dy++) {

            if (dx * dx + dy * dy <= radius * radius) {
                x = cx + dx;
                y = cy + dy;

                if (x > 0 && y > 0 && x < map_width - 1 && y < map_height - 1) {
                    _grid[# x, y] = 0;
                }
            }
        }
    }
}