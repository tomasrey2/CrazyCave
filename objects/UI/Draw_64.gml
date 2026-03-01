draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);



if (ui_state == UIState.MAIN_MENU)
{
    draw_text(400, 150, "CrazyCave");

    draw_buttonUI(400, 275, "JUGAR");
    draw_buttonUI(400, 345, "CONFIGURACION");
    draw_buttonUI(400, 415, "SALIR");
	
	if (ui_state == UIState.MAP_SELECT)
{
    draw_text(400, 200, "Presiona R para cambiar mapa");
    draw_text(400, 240, "Seed actual: " + string(selected_map_seed));
    draw_text(400, 280, "Presiona ENTER para jugar");
}

if (ui_state == UIState.SETTINGS)
{
    draw_text(400, 150, "CONFIGURACION");

    draw_text(400, 220, "Tamaño mapa: " + string(map_width));
    draw_text(400, 260, "Fill percent: " + string(fill_percent));
    draw_text(400, 300, "F = Pantalla Completa");
    draw_text(400, 340, "ESC = Volver");
}

if (ui_state == UIState.INGAME)
{
    var hp_percent = player.hp / player.max_hp;

    draw_set_color(c_red);
    draw_rectangle(20, 20, 220, 50, false);

    draw_set_color(c_green);
    draw_rectangle(20, 20, 20 + 200 * hp_percent, 50, false);

    draw_set_color(c_white);
    draw_text(120, 35, "HP");
}
}
