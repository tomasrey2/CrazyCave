/// @function spawn_game_objects()
/// @description Genera objetos del juego (minerales, bandera, nivel de agua)

function spawn_game_objects()
{
    // Crear nivel de agua si no existe
    if (!instance_exists(Owater_level))
    {
        instance_create_depth(0, 0, -1000, Owater_level);
    }
    
    // Obtener posición del jugador
    var player = instance_find(Ohuman, 0);
    if (player == noone) return;
    
    var player_x = player.x;
    var player_y = player.y;
    
    // Spawear minerales en posiciones aleatorias (5-10 minerales)
    var mineral_count = irandom_range(5, 10);
    
    for (var i = 0; i < mineral_count; i++)
    {
        var floor_count = instance_number(Ofloor);
        if (floor_count > 0)
        {
            var attempts = 0;
            var spawned = false;
            
            while (!spawned && attempts < 50)
            {
                var random_floor = instance_find(Ofloor, irandom(floor_count - 1));
                
                // Verificar que no esté muy cerca del jugador (al menos 10 bloques)
                var distance = point_distance(random_floor.x, random_floor.y, player_x, player_y);
                
                if (distance > 100) // 10 bloques * 10 pixeles
                {
                    instance_create_depth(random_floor.x, random_floor.y, -100, Omineral);
                    spawned = true;
                }
                attempts++;
            }
        }
    }
    
    // Spawear portal tomando posiciones válidas de Ofloor
    with (Oportal) instance_destroy();
    
    var floor_count = instance_number(Ofloor);
    var portal_spawned = false;
    
    if (floor_count > 0)
    {
        var attempts = 0;
        while (!portal_spawned && attempts < 150)
        {
            var random_floor = instance_find(Ofloor, irandom(floor_count - 1));
            var distance = point_distance(random_floor.x, random_floor.y, player_x, player_y);
            
            // Lejos del jugador y dentro de límites
            if (distance >= 300 && random_floor.x >= 0 && random_floor.x < room_width && random_floor.y >= 0 && random_floor.y < room_height)
            {
                instance_create_depth(random_floor.x, random_floor.y, -100, Oportal);
                portal_spawned = true;
            }
            attempts++;
        }
        
        // Fallback garantizado: cualquier Ofloor válido dentro del mapa
        if (!portal_spawned)
        {
            var fallback_floor = instance_find(Ofloor, irandom(floor_count - 1));
            instance_create_depth(fallback_floor.x, fallback_floor.y, -100, Oportal);
        }
    }
}
