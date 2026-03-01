/// Dibujar el nivel de agua

draw_set_alpha(water_alpha);
draw_set_color(water_color);
draw_rectangle(0, water_level_y, room_width, room_height, false);
draw_set_alpha(1);
draw_set_color(c_white);
