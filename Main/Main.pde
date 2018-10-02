Player player;
EnemyFloater enemy;
EnemyChaser enemy2;
boolean lost = false;
color gameOverColor = color(25, 10, 25);

void setup() {
	size(800, 800);
	player = new Player();
	enemy = new EnemyFloater();
	enemy2 = new EnemyChaser();
}

void draw() {
	//hej testbranch
	if (!lost){
		background(255);
		player.move();
		enemy.move();
		enemy.draw();
		enemy2.chase(player.position);		
		enemy2.move();
		enemy2.draw();
		player.playerDraw();
		lost = circleCollision(player.position, player.size, enemy.position, enemy.size);
	}
	if(lost) {
		background(30, 10, 30);
		gameOverColor = color(200, 10, 20);
	}
	gameOver();
	frame.setTitle(int(frameRate) + " fps");
}

void gameOver() {
	textSize(50);
	fill(gameOverColor);
    text("Game Over", width/3, height/2); 
}