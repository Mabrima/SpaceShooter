Player player;
EnemyFloater enemy;
EnemyCharger enemy2;
EnemyChaser enemy3;
int borderLeniency = 20;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
boolean lost = false;
color gameOverColor = color(15, 10, 15);
int spawnTime = 60;
int spawnTimer = 60;

void setup() {
	size(800, 800);
	player = new Player();
	enemy = new EnemyFloater();
	enemy2 = new EnemyCharger();
	enemy3 = new EnemyChaser();
	enemies.add(enemy);
	enemies.add(new EnemyFloater());
	enemies.add(enemy2);
	enemies.add(enemy3);
}

void draw() {
	//hej testbranch
	if (!lost){
		// background(10, 10, 10);
		background(255);
		gameOver();

		player.move();
		enemy2.findPlayerPosition(player.position);
		enemy3.findPlayerPosition(player.position);

		for (Enemy currentEnemy : enemies) {
			currentEnemy.move();
			currentEnemy.draw();
		}

		player.playerDraw();

		for (Explosion currentExplosion : explosions) {
			currentExplosion.move();
			currentExplosion.draw();
		}

		ArrayList<Bullet> bullets = player.getBullets();
		for (int i = 0; i < bullets.size(); i++) { //checks if player bullets hit enemies and kills them
			for (int j = 0; j < enemies.size(); j++) {
				if (i != bullets.size() && circleCollision(bullets.get(i).position, bullets.get(i).size, enemies.get(j).position, enemies.get(j).size)){
					addExplosions(enemies.get(j), (int) random(2,5));
					enemies.remove(j);
					bullets.remove(i);
				}
			}
		} 

		for (int i = 0; i < bullets.size(); ++i) { //kills bullets if they are outside the field
			if (outOfBorders(bullets.get(i).position)) {
				bullets.remove(i);
				i--;
			}
		}

		for (int i = 0; i < enemies.size(); ++i) { //kills enemies if they are outside the field
			if (outOfBorders(enemies.get(i).position)) {
				enemies.remove(i);
			}
		}	

		for (Enemy currentEnemy : enemies) {
			if (circleCollision(player.position, player.size, currentEnemy.position, currentEnemy.size)){
				lost = true;
			}
		}

		for (int i = 0; i < explosions.size(); i++) {
			if (!explosions.get(i).isAlive()) {
				explosions.remove(i);
			}
		}	 
	}
	if(lost) {
		background(30, 10, 30);
		gameOverColor = color(200, 10, 20);
		gameOver();
	}
	surface.setTitle(int(frameRate) + " fps");
	newWave();
}

void gameOver() {
	textSize(50);
	fill(gameOverColor);
    text("Game Over", width/3, height/2); 
}

boolean outOfBorders(PVector position) {
	return (position.x > width  || position.y > height  || position.x < 0  || position.y < 0 );
}

void newWave() {
	if (spawnTimer > 0) {
		spawnTimer--;
	} else {
		enemies.add(new EnemyFloater());
		spawnTimer = spawnTime;
	}
}

void addExplosions(Enemy enemy, int numberOfParticles) {
	for (int i = 0; i < numberOfParticles; ++i) {
		explosions.add(new Explosion(enemy.position.copy(), enemy.fillColor));
	}
}