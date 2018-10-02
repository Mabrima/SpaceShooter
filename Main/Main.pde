Player player;
EnemyFloater enemy;
boolean lost = false;

void setup() {
	size(800, 800);
	player = new Player();
	enemy = new EnemyFloater();
}

void draw() {
	//hej testbranch
	if (!lost){
		background(255);
		player.move();
		enemy.move();
		enemy.draw();
		player.playerDraw();
		lost = circleCollision(player.position, player.size, enemy.position, enemy.size);
	}
	gameOver();
	if(lost) {
		
	}
	
}

void gameOver() {
	textSize(50);
    text("Game Over", width/3, height/2); 
    fill(200, 50, 50);
}