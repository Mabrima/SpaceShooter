Player player;

void setup() {
	size(800, 800);
	player = new Player();
}

void draw() {
	background(30, 10, 30);
	player.move();
	player.playerDraw();
}

// void playerDraw(){

// 	ellipseMode(CENTER);
// 	ellipse(player.position.x, player.position.y, player.size, player.size);

// 	// triangle(player.position.x, player.position.y, 
// 	// 	player.position.x-player.size/2, player.position.y+player.size, 
// 	// 	player.position.x+player.size/2, player.position.y+player.size);
// }