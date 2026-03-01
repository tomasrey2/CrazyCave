/// Nivel de agua que sube gradualmente

// Encontrar el bloque más bajo del mapa
var lowest_y = 0;
with (Ograss) {
    if (y > lowest_y) {
        lowest_y = y;
    }
}
with (Ofloor) {
    if (y > lowest_y) {
        lowest_y = y;
    }
}

// Si no hay bloques, usar room_height
if (lowest_y == 0) {
    lowest_y = room_height;
} else {
    lowest_y += 16; // Agregar altura de un tile para empezar justo debajo
}

water_level_y = lowest_y; // Comienza desde el bloque más bajo
water_rise_speed = 0.05; // Velocidad a la que sube
water_color = c_blue;
water_alpha = 0.5;
