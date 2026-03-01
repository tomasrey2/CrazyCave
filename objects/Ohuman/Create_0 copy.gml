xvelocity = 0;
yvelocity = 0;
velocitywalk = 1;

// Salud
hp = 100;
max_hp = 100;

// Puntos
points = 0;
water_damage_timer = 0;

// Fuerza de salto según dificultad
var ui = instance_find(UI, 0);
if (ui != noone) {
    switch(ui.difficulty_selected) {
        case 0: // Fácil
            velocityjump = 1.5;
            break;
        case 1: // Normal (+45%)
            velocityjump = 1.5 * 3;
            break;
        case 2: // Difícil (+55%)
            velocityjump = 1.5 * 1.55;
            break;
        default:
            velocityjump = 1.5;
    }
} else {
    velocityjump = 1.5; // Valor por defecto
}

// Spawn del humano con lógica de intentos aleatorios
var spawned_human = false;
var spawn_x;
var spawn_y;

repeat(100) {
    spawn_x = irandom_range(50, room_width - 50);
    spawn_y = irandom_range(50, room_height - 50);
    
    // Debe estar sobre Ofloor y no dentro de Ograss/Orocks
    var on_floor = place_meeting(spawn_x, spawn_y, Ofloor);
    var blocked_grass = place_meeting(spawn_x, spawn_y, Ograss);
    var blocked_rocks = place_meeting(spawn_x, spawn_y, Orocks);
    
    if (on_floor && !blocked_grass && !blocked_rocks) {
        x = spawn_x;
        y = spawn_y;
        spawned_human = true;
        break;
    }
}

// Fallback seguro
if (!spawned_human) {
    var floor_count = instance_number(Ofloor);
    if (floor_count > 0) {
        var random_floor = instance_find(Ofloor, irandom(floor_count - 1));
        x = random_floor.x;
        y = random_floor.y;
    } else {
        x = room_width / 2;
        y = room_height / 2;
    }
}
