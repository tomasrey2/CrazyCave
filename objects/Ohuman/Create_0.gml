xvelocity = 0;
yvelocity = 0;
velocitywalk = 1;

// Initialize at a random Ofloor object position
var grass_count = instance_number(Ofloor);

if (grass_count > 0) {
    var random_index = irandom(grass_count - 1);
    var random_grass = instance_find(Ofloor, random_index);
    x = random_grass.x;
    y = random_grass.y;
}
