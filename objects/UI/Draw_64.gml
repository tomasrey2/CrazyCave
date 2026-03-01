draw_set_font(GordoGrande);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();
var center_x = gui_width / 2;
var center_y = gui_height / 2;

if (ui_state == UIState.MAIN_MENU)
{
    // Fondo oscuro transparente
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_width, gui_height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    // Título grande
    draw_text_transformed(center_x, center_y - 200, "CrazyCave", 2, 2, 0);
    
    // Mensaje de victoria si completó todos los niveles
    if (game_won) {
        draw_set_color(c_yellow);
        draw_text(center_x, center_y - 100, "FELICIDADES! COMPLETASTE TODOS LOS NIVELES!");
        draw_set_color(c_white);
        game_won = false;
    }

    draw_text(center_x, center_y - 50, "JUGAR");
    draw_text(center_x, center_y + 20, "CONFIGURACION");
    draw_text(center_x, center_y + 90, "SALIR");
}

if (ui_state == UIState.MAP_SELECT)
{
    // Fondo oscuro transparente
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_width, gui_height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    draw_text(center_x, center_y - 150, "Presiona R para cambiar mapa");
    draw_text(center_x, center_y - 120, "Seed actual: " + string(selected_map_seed));
    
    // Instrucciones del juego
    draw_set_color(c_yellow);
    draw_text(center_x, center_y - 50, "El fuego te da puntos");
    draw_text(center_x, center_y - 20, "El agua te quita vida");
    draw_text(center_x, center_y + 10, "Pasalo lo mas rapido posible!");
    draw_set_color(c_white);
    
    draw_text(center_x, center_y + 80, "Presiona ENTER para jugar");
}

if (ui_state == UIState.SETTINGS)
{
    // Fondo oscuro transparente
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_width, gui_height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    draw_text(center_x, center_y - 150, "CONFIGURACION");

    // Dificultad
    draw_text(center_x, center_y - 50, "DIFICULTAD:");
    
    var diff_y = center_y + 20;
    for (var i = 0; i < 3; i++)
    {
        if (i == difficulty_selected)
            draw_set_color(c_yellow);
        else
            draw_set_color(c_white);
        
        draw_text(center_x - 100 + i * 100, diff_y, difficulty_names[i]);
    }
    
    draw_set_color(c_white);
    draw_text(center_x, center_y + 120, "Flechas < > para seleccionar");
    draw_text(center_x, center_y + 160, "ESC = Volver");
}

if (ui_state == UIState.INGAME)
{
    // Verificar que el objeto player existe y tiene variables de salud
    var player_inst = instance_find(Ohuman, 0);
    
    if (player_inst != noone && variable_instance_exists(player_inst, "hp") && variable_instance_exists(player_inst, "max_hp"))
    {
        var hp_percent = player_inst.hp / player_inst.max_hp;

        draw_set_color(c_red);
        draw_rectangle(20, 20, 220, 50, false);

        draw_set_color(c_green);
        draw_rectangle(20, 20, 20 + 200 * hp_percent, 50, false);

        draw_set_color(c_white);
        draw_text(120, 35, "HP");
        
        // Mostrar puntos
        draw_set_halign(fa_left);
        draw_text(20, 70, "Puntos: " + string(player_inst.points));
        draw_set_halign(fa_center);
    }
    
    // Minimapa (proporción horizontal como el mapa real: 89x50)
    var minimap_x = display_get_gui_width() - 170;
    var minimap_y = 20;
    var minimap_width = 150;
    var minimap_height = 85;
    
    // Fondo del minimapa
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(minimap_x, minimap_y, minimap_x + minimap_width, minimap_y + minimap_height, false);
    
    // Dibujar bloques de Ograss en el minimapa
    draw_set_alpha(0.6);
    with (Ograss) {
        var grass_minimap_x = minimap_x + (x / room_width) * minimap_width;
        var grass_minimap_y = minimap_y + (y / room_height) * minimap_height;
        draw_set_color(c_green);
        draw_rectangle(grass_minimap_x, grass_minimap_y, grass_minimap_x + 2, grass_minimap_y + 2, false);
    }
    
    // Nivel de agua en el minimapa
    var water_level_obj = instance_find(Owater_level, 0);
    if (water_level_obj != noone) {
        var water_percent = water_level_obj.water_level_y / room_height;
        var water_y = minimap_y + (minimap_height * water_percent);
        
        draw_set_alpha(0.5);
        draw_set_color(c_blue);
        draw_rectangle(minimap_x, water_y, minimap_x + minimap_width, minimap_y + minimap_height, false);
    }
    
    // Posición del jugador en el minimapa
    if (player_inst != noone) {
        var player_minimap_x = minimap_x + (player_inst.x / room_width) * minimap_width;
        var player_minimap_y = minimap_y + (player_inst.y / room_height) * minimap_height;
        
        draw_set_alpha(1);
        draw_set_color(c_yellow);
        draw_circle(player_minimap_x, player_minimap_y, 3, false);
    }
    
    // Portal en el minimapa (azul claro)
    var bandera_inst = instance_find(Oportal, 0);
    if (bandera_inst != noone) {
        var bandera_minimap_x = minimap_x + (bandera_inst.x / room_width) * minimap_width;
        var bandera_minimap_y = minimap_y + (bandera_inst.y / room_height) * minimap_height;
        
        draw_set_alpha(1);
        draw_set_color(c_aqua);
        draw_circle(bandera_minimap_x, bandera_minimap_y, 3, false);
    }
    
    // Borde del minimapa
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(minimap_x, minimap_y, minimap_x + minimap_width, minimap_y + minimap_height, true);
    
    // Mostrar nivel actual
    draw_set_halign(fa_left);
    draw_text(20, 100, "Nivel: " + string(current_level) + "/" + string(max_levels));
    draw_set_halign(fa_center);
}

// Pantalla de victoria
if (ui_state == UIState.INGAME && game_won) {
    // Dibujar sprite Final en toda la pantalla
    draw_sprite_stretched(Final, 0, 0, 0, display_get_gui_width(), display_get_gui_height());
    
    // Texto
    draw_set_color(c_white);
    draw_text(display_get_gui_width() / 2, display_get_gui_height() - 100, "Presiona ENTER para jugar de nuevo");
}
