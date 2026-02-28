xvelocity = 0;
yvelocity += 0.05; // gravedad

if (instance_place(x, y, Owater)) 
{	velocitywalk = 0.2
	velocityjump = 0.8
		
}


		




if (instance_place(x, y, Ofire)) 
{	 velocitywalk = 2
	velocityjump = 2
	
	
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



if (place_meeting(x, y, Otrampoline)) 
{
	xvelocity = 0.5
	yvelocity = -2.2
	
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