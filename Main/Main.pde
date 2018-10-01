Player player;
PVector movement;

void setup() {
	size(800, 800);
	player = new Player();
	movement = new PVector(0,0);
}

void draw() {
	background(30, 10, 30);
	movement.y = getAxisRaw("Vertical");
	movement.x = getAxisRaw("Horizontal");
	movement.normalize();
	player.position.x += movement.x * player.velocity;
	player.position.y += movement.y * player.velocity;
	playerDraw();
}

void playerDraw(){

	ellipseMode(CENTER);
	ellipse(player.position.x, player.position.y, player.size, player.size);

	// triangle(player.position.x, player.position.y, 
	// 	player.position.x-player.size/2, player.position.y+player.size, 
	// 	player.position.x+player.size/2, player.position.y+player.size);
}