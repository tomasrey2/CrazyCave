/// Colisión con jugador

var player = instance_find(Ohuman, 0);
if (player != noone && place_meeting(x, y, Ohuman)) {
    player.points += points_value;
    instance_destroy();
}
