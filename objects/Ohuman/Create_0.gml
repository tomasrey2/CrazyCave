contador = 0;
xvelocity = 0;
yvelocity = 0;
velocitywalk = 1;

// Salud
hp = 100;
max_hp = 100;

// Puntos
points = 0;
water_damage_timer = 0;

// Initialize at a random Ofloor object position (NOT Ograss)
var floor_count = instance_number(Ofloor);

if (floor_count > 0) {
    // Buscar un Ofloor que no tenga Ograss encima o en la misma posición
    var found_valid = false;
    var attempts = 0;
    
    while (!found_valid && attempts < 100) {
        var random_index = irandom(floor_count - 1);
        var random_floor = instance_find(Ofloor, random_index);
        
        // Verificar que no haya Ograss en la misma posición o encima
        var has_grass_here = place_meeting(random_floor.x, random_floor.y, Ograss);
        var has_grass_above = place_meeting(random_floor.x, random_floor.y - 16, Ograss);
        
        if (!has_grass_here && !has_grass_above) {
            x = random_floor.x;
            y = random_floor.y;
            found_valid = true;
        }
        attempts++;
    }
    
    // Si no encontró posición válida, usar cualquier Ofloor
    if (!found_valid) {
        var random_floor = instance_find(Ofloor, 0);
        x = random_floor.x;
        y = random_floor.y;
    }
} else {
    // Fallback si no hay Ofloor
    x = room_width / 2;
    y = room_height / 2;
}
