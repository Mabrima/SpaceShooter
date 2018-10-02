Player player;
EnemyFloater enemy;
EnemyChaser enemy2;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
boolean lost = false;
color gameOverColor = color(25, 10, 25);

void setup() {
	size(800, 800);
	player = new Player();
	enemy = new EnemyFloater();
	enemy2 = new EnemyChaser();
	enemies.add(enemy);
	enemies.add(enemy2);
}

void draw() {
	//hej testbranch
	if (!lost){
		background(10, 10, 10);
		gameOver();

		player.move();
		enemy2.chase(player.position);

		for (Enemy currentEnemy : enemies) {
			currentEnemy.move();
			currentEnemy.draw();
		}

		player.playerDraw();

		ArrayList<Bullet> bullets = player.getBullets();
		for (int i = 0; i < bullets.size(); i++) {
			for (int j = 0; j < enemies.size(); j++) {
				if (circleCollision(bullets.get(i).position, bullets.get(i).size, enemies.get(j).position, enemies.get(j).size)){
					enemies.remove(j);
					bullets.remove(i);
				}
			}
		} 

		for (Enemy currentEnemy : enemies) {
			if (circleCollision(player.position, player.size, currentEnemy.position, currentEnemy.size)){
				lost = true;
			}
		}
		 
	}
	if(lost) {
		background(30, 10, 30);
		gameOverColor = color(200, 10, 20);
		gameOver();
	}
	surface.setTitle(int(frameRate) + " fps");
}

void gameOver() {
	textSize(50);
	fill(gameOverColor);
    text("Game Over", width/3, height/2); 
}