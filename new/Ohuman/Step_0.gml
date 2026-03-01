xvelocity = 0;
yvelocity += 0.05; // gravedad
// si toca el agua volverse mas lento y spawnear otra agua
if (instance_place(x, y, Owater)) 
{	velocitywalk = 0.4
	velocityjump = 0.8
	instance_destroy(Owater)
	   // crear Ofire en posición random
	   var new_x;
	   var new_y;
	   repeat(100)
	   {
		new_x = irandom_range(50,room_width-50);
		new_y = irandom_range(50,room_height-50);
		if(!place_meeting(new_x, new_y, Ograss))
		{	break;
			}			
	   }	
    instance_create_layer(new_x, new_y, "Instances",Owater);		
}


// si toca el fuego volverse mas rapido y spawnear otro fuego
if (instance_place(x, y, Ofire)) 
{   velocitywalk = 1.3
	velocityjump = 1.8
		instance_destroy(Ofire);
		
	var new_x;
	var new_y;
	repeat(100)
	   {
		new_x = irandom_range(50,room_width-50);
		new_y = irandom_range(50,room_height-50);
		if(!place_meeting(new_x, new_y, Ograss))
		{	break;
			}			
	   }	
    instance_create_layer(new_x, new_y, "Instances",Ofire);		
}	

// Saltar solo si está en el suelo
if (place_meeting(x, y + 1, Ograss)) {
    if (keyboard_check_pressed(vk_up)) {
        yvelocity = -velocityjump;
		 
    }
	else {
		 yvelocity = 0
		
	}
}
// reinicar el juego si se sale de los limites
if (y> room_height)
{
	room_restart()		
	
}	
// las fisicas con el trampoline
if (place_meeting(x, y, Otrampoline)) 
{
	xvelocity = 0.5
	yvelocity = -2.2
	
}

//revisar si esta en el piso y poner el trampoline
if (place_meeting(x, y + 1, Ograss))
{

	if(keyboard_check(vk_down))
	{  
		instance_destroy(Otrampoline)
		instance_create_layer(x, y, "Instances",Otrampoline);
	}
	
}


//pasar a la siguiente room si toca el portal
if (place_meeting(x, y, Oportal))
{
    var next_room = room_next(room);
    
    if (next_room != -1)
    {
        room_goto(next_room);
    }
    else
    {
        show_message("¡Fin del juego!");
    }
}




// Movimiento horizontal
if (keyboard_check(vk_right)) {
    xvelocity = velocitywalk;
}
else if (keyboard_check(vk_left)) {
    xvelocity = -velocitywalk;
}

move_and_collide(xvelocity, yvelocity, Ograss)

// Movimiento y colisión
move_and_collide(xvelocity, yvelocity, Ograss);