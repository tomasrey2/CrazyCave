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
    
    // Spawear bandera en posición aleatoria (mínimo 30 bloques del jugador)
    var floor_count = instance_number(Ofloor);
    if (floor_count > 0)
    {
        var attempts = 0;
        var spawned = false;
        
        while (!spawned && attempts < 100)
        {
            var random_floor = instance_find(Ofloor, irandom(floor_count - 1));
            
            // Verificar que esté a mínimo 30 bloques del jugador
            var distance = point_distance(random_floor.x, random_floor.y, player_x, player_y);
            
            if (distance >= 300) // 30 bloques * 10 pixeles
            {
                instance_create_depth(random_floor.x, random_floor.y, -100, Oportal);
                spawned = true;
            }
            attempts++;
        }
        
        // Si no se pudo spawear lejos, spawear en cualquier Ofloor
        if (!spawned && floor_count > 0)
        {
            var random_floor = instance_find(Ofloor, irandom(floor_count - 1));
            instance_create_depth(random_floor.x, random_floor.y, -100, Oportal);
        }
    }
}
