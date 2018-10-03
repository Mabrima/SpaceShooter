Player player;
EnemyFloater enemy;
EnemyCharger enemy2;
EnemyChaser enemy3;
EnemyBasicShooter enemyShooter;
int borderLeniency = 20;
boolean lost = false;
color gameOverColor = color(15, 10, 15);
int spawnTime = 120;
int spawnTimer = 120;

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
ArrayList<Bullet> enemyBullets = new ArrayList<Bullet>();


void setup() {
	size(800, 800);
	player = new Player();
	enemy = new EnemyFloater();
	enemy2 = new EnemyCharger();
	enemy3 = new EnemyChaser();
	enemyShooter = new EnemyBasicShooter();

	enemies.add(enemyShooter);
	enemies.add(enemy);
	enemies.add(enemy2);
	enemies.add(enemy3);
}

void draw() {
	if (!lost){
		// background(10, 10, 10);
		background(255);
		gameOver();


		//movement and draw phase
		player.move();
		player.playerDraw();

		//checks all enemies. If they are chasers then give player position to them
		for (Enemy currentEnemy : enemies) {
			if (currentEnemy instanceof EnemyChaser){
				EnemyChaser chaser = (EnemyChaser) currentEnemy;
				chaser.findPlayerPosition(player.position);
			} else if (currentEnemy instanceof EnemyBasicShooter) {
				EnemyBasicShooter shooter = (EnemyBasicShooter) currentEnemy;
				shooter.findPlayerPosition(player.position);
			}
		}

		//movement for enemies and explosions
		for (Enemy currentEnemy : enemies) {
			currentEnemy.move();
			currentEnemy.draw();
		}
		for (Explosion currentExplosion : explosions) {
			currentExplosion.move();
			currentExplosion.draw();
		}

		//goes through all enemies, if they are shooters then check if they want to shoot and add a bullet when they do
		for (Enemy currentEnemy : enemies) {
			if (currentEnemy instanceof EnemyBasicShooter){
				EnemyBasicShooter shooter = (EnemyBasicShooter) currentEnemy;
				if (shooter.fired) {
					enemyBullets.add(shooter.getBullet());
				}
			}
		}

		//move bullets
		for (Bullet bullet : enemyBullets) {
			bullet.move();
			bullet.draw();
		}
		


		//Colision/borders phase

		//checks playerBullets towards enemies and kills them if they hit and adds explosions to that area
		ArrayList<Bullet> playerBullets = player.getBullets();
		for (int i = 0; i < playerBullets.size(); i++) { //checks if playerBullets hit enemies and kills them
			for (int j = 0; j < enemies.size(); j++) {
				if (i != playerBullets.size() && circleCollision(playerBullets.get(i).position, playerBullets.get(i).size, enemies.get(j).position, enemies.get(j).size)){
					addExplosions(enemies.get(j), (int) random(2,5));
					enemies.remove(j);
					playerBullets.remove(i);
				}
			}
		} 

		//checks enemies, enemybullets and playerBullets position and kills them if they are not inside the field
		for (int i = 0; i < enemyBullets.size(); i++) {
			if (outOfBorders(enemyBullets.get(i).position)) {
				enemyBullets.remove(i);
				i--;
			}
		}
		for (int i = 0; i < playerBullets.size(); ++i) { 
			if (outOfBorders(playerBullets.get(i).position)) {
				playerBullets.remove(i);
				i--;
			}
		}
		for (int i = 0; i < enemies.size(); ++i) { 
			if (outOfBorders(enemies.get(i).position)) {
				enemies.remove(i);
			}
		}	


		//Checks enemies and enemy bullets towards the player and cause a loss state if it hits them
		for (Enemy currentEnemy : enemies) {
			if (circleCollision(player.position, player.size, currentEnemy.position, currentEnemy.size)){
				lost = true;
			}
		}
		for (Bullet bullet : enemyBullets) {
			if (circleCollision(player.position, player.size, bullet.position, bullet.size)){
				lost = true;
			}
		}

		//removes explosions if they "die"
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
		enemies.add(new EnemyBasicShooter());
		enemies.add(new EnemyChaser());
		enemies.add(new EnemyCharger());
		spawnTimer = spawnTime;
	}
}

void addExplosions(Enemy enemy, int numberOfParticles) {
	for (int i = 0; i < numberOfParticles; ++i) {
		explosions.add(new Explosion(enemy.position.copy(), enemy.fillColor));
	}
}