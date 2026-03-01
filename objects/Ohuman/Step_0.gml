// Obtener referencia a UI
var ui = instance_find(UI, 0);

// Bloquear movimiento si no estamos en juego
if (ui != noone && ui.ui_state != UIState.INGAME) {
    xvelocity = 0;
    yvelocity = 0;
    exit;
}

// Inicializar velocidades si no existen
if (!variable_instance_exists(self, "velocitywalk")) {
    velocitywalk = 0.8;
}
if (!variable_instance_exists(self, "velocityjump")) {
    velocityjump = 1.5;
}

xvelocity = 0;
yvelocity += 0.05; // gravedad

// ===== EFECTOS ESPECIALES AL TOCAR ITEMS =====

// Si toca agua: volverse más lento y spawnear otra agua
if (instance_place(x, y, Owater)) {
    velocitywalk = 0.4;
    velocityjump = 0.8;
    instance_destroy(Owater);
    
    // Crear nueva Owater en posición random
    var new_x;
    var new_y;
    repeat(100) {
        new_x = irandom_range(50, room_width - 50);
        new_y = irandom_range(50, room_height - 50);
        if (!place_meeting(new_x, new_y, Ograss)) {
            break;
        }
    }
    instance_create_layer(new_x, new_y, "Instances", Owater);
}

// Si toca fuego: volverse más rápido y spawnear otro fuego
if (instance_place(x, y, Ofire)) {
    velocitywalk = 1.3;
    velocityjump = 1.8;
    instance_destroy(Ofire);
    
    // Crear nuevo Ofire en posición random
    var new_x;
    var new_y;
    repeat(100) {
        new_x = irandom_range(50, room_width - 50);
        new_y = irandom_range(50, room_height - 50);
        if (!place_meeting(new_x, new_y, Ograss)) {
            break;
        }
    }
    instance_create_layer(new_x, new_y, "Instances", Ofire);
}

// ===== SALTO =====
if (place_meeting(x, y + 1, Ograss) || place_meeting(x, y + 1, Orocks)) {
    if (keyboard_check_pressed(vk_up)) {
        yvelocity = -velocityjump;
    } else {
        yvelocity = 0;
    }
}

// ===== TRAMPOLINE =====
if (place_meeting(x, y, Otrampoline)) {
    xvelocity = 0.5;
    yvelocity = -2.2;
}

// Poner trampoline si presiona abajo en el suelo
if (place_meeting(x, y + 1, Ograss)) {
    if (keyboard_check(vk_down)) {
        instance_destroy(Otrampoline);
        instance_create_layer(x, y, "Instances", Otrampoline);
    }
}

// ===== PORTAL =====
if (place_meeting(x, y, Oportal)) {
    var next_room = room_next(room);
    if (next_room != -1) {
        room_goto(next_room);
    } else {
        show_message("¡Fin del juego!");
    }
}

// ===== DAÑO POR AGUA (NIVEL DE AGUA RISING) =====
var in_water = place_meeting(x, y, Owater);
var water_level_obj = instance_find(Owater_level, 0);

// Verificar si está debajo del nivel de agua
if (water_level_obj != noone && y >= water_level_obj.water_level_y) {
    in_water = true;
}

if (in_water) {
    if (!variable_instance_exists(self, "water_damage_timer")) {
        water_damage_timer = 0;
    }
    water_damage_timer++;
    if (water_damage_timer >= 30) { // Cada 30 frames (0.5 segundos)
        hp = max(0, hp - 5);
        water_damage_timer = 0;
        if (hp <= 0) {
            room_restart();
        }
    }
} else {
    water_damage_timer = 0;
}

// Reiniciar el juego si se sale de los límites
if (y > room_height) {
    room_restart();
}

// ===== MOVIMIENTO HORIZONTAL =====
if (keyboard_check(vk_right)) {
    xvelocity = velocitywalk;
} else if (keyboard_check(vk_left)) {
    xvelocity = -velocitywalk;
}

// Movimiento y colisión
move_and_collide(xvelocity, yvelocity, Ograss, Orocks);

// ===== CÁMARA =====
var cam = view_camera[0];
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);

var cam_x = x - cam_w / 2;
var cam_y = y - cam_h / 2;

// Limitar cámara a los límites del mapa
cam_x = clamp(cam_x, 0, room_width - cam_w);
cam_y = clamp(cam_y, 0, room_height - cam_h);

camera_set_view_pos(cam, cam_x, cam_y);