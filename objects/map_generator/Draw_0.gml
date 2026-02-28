for (x = 0; x < map_width; x++) {
    for (y = 0; y < map_height; y++) {

        if (grid[# x, y] == 1) {
            draw_set_color(c_black);
        } else {
            draw_set_color(c_white);
        }

        draw_rectangle(
            x * cell_size,
            y * cell_size,
            (x+1) * cell_size,
            (y+1) * cell_size,
            false
        );
    }
}