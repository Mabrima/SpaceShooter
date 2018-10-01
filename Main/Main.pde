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
