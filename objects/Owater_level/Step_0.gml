/// Subir el nivel de agua gradualmente

// Solo subir agua cuando esté en juego
var ui = instance_find(UI, 0);
if (ui != noone && ui.ui_state == UIState.INGAME) {
    water_level_y -= water_rise_speed;
    
    // No subir más allá del tope
    water_level_y = max(0, water_level_y);
}
