Player player;
EnemyFloater enemy;
EnemyCharger enemy2;
EnemyChaser enemy3;
EnemyBasicShooter enemyShooter;
int borderLeniency = 20;
color gameOverColor = color(15, 10, 15);
int spawnTime = 45;
int spawnTimer = 30;
int frames;
int waveAmount = 5;

// for background
int numberOfStars = 200;
int starTimer = 30;
float shineValue;
float[] stars;
ArrayList<SpaceLines> spaceLine = new ArrayList<SpaceLines>();

String gameState; //Menu, Gameplay, GameOver

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
ArrayList<Bullet> enemyBullets = new ArrayList<Bullet>();


void setup() {
	size(1280, 720);
	frames = 0;
	player = new Player();
	gameOverColor = color(200, 10, 20);
	textSize(50);

	gameState = "Gameplay";

	//for background
	stars = new float[numberOfStars];
	starBackground();

	// enemy = new EnemyFloater();
	// enemy2 = new EnemyCharger();
	// enemy3 = new EnemyChaser();
	// enemyShooter = new EnemyBasicShooter();
	// enemies.add(enemyShooter);
	// enemies.add(enemy);
	// enemies.add(enemy2);
	// enemies.add(enemy3);
}

void draw() {

	if (gameState.equals("MainMenu")) {
		
	}

	if (gameState.equals("Gameplay")) {
		updateGame();
		newWave();
	}

	if(gameState.equals("GameOver")) {
		gameOver();
	}

	surface.setTitle(int(frameRate) + " fps");
	frames++;
}

void gameOver() {
	background(30, 10, 30);
	fill(gameOverColor);
    text("You Are Dead!", width/2 - textWidth("You Are Dead!") / 2, height/2); 
    if (frames%120 >= 60) 
			text("Press Space to retry!", width/2 - textWidth("Press Space to retry!")/2, height*2/3);
	if (spacePressed) 
		resetGame();
}

void healthSystem() {
	fill(200 - player.health*4, 10, 0);
	text("You Are Dying!", width/2 - textWidth("You Are Dying!") / 2, height/2); 
}

boolean outOfBorders(PVector position) {
	return (position.x > width  || position.y > height  || position.x < 0  || position.y < 0 );
}

void newWave() {
	float randomSpawn;
	if (frames%600 == 599)
		waveAmount++;
	if (spawnTimer > 0) {
		spawnTimer--;
	} else {
		for (int i = 0; i < waveAmount; ++i) {
			randomSpawn = random(100);
			if (randomSpawn > 85) {
				enemies.add(new EnemyCharger());
			}
			else if (randomSpawn > 70) {
				enemies.add(new EnemyChaser());
			}
			else if (randomSpawn > 50) {
				enemies.add(new EnemyBasicShooter());
			}
			else {
				enemies.add(new EnemyFloater());
			}
		}
		spawnTimer = spawnTime;
	}
}

void addExplosions(Enemy enemy, int numberOfParticles) {
	for (int i = 0; i < numberOfParticles; ++i) {
		explosions.add(new Explosion(enemy.position.copy(), enemy.fillColor));
	}
}

void addExplosions(Player player, int numberOfParticles) {
	for (int i = 0; i < numberOfParticles; ++i) {
		explosions.add(new Explosion(player.position.copy(), player.fillColor));
	}
}

void resetGame() {
	player.health = 45;
	enemies.clear();
	enemyBullets.clear();
	explosions.clear();
	gameState = "Gameplay";
	waveAmount = 5;
}

void updateGame() {
	background(10, 10, 10);
	// background(255);

	stroke(255);
	strokeWeight(1);
	animateBackground();
	updateStars();

	healthSystem();


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
			player.hit();
			addExplosions(player, 3);
			if (!player.isAlive()) {
				gameState = "GameOver";
			}
		}
	}
	for (Bullet bullet : enemyBullets) {
		if (circleCollision(player.position, player.size, bullet.position, bullet.size)){
			player.hit();
			player.hit();

			addExplosions(player, 3);

			if (!player.isAlive()) {
				gameState = "GameOver";
			}
		}
	}

	//removes explosions if they "die"
	for (int i = 0; i < explosions.size(); i++) {
		if (!explosions.get(i).isAlive()) {
			explosions.remove(i);
		}
	}	 
}


void starBackground() {
	for (int i = 0; i < stars.length; i += 2) {
		stars[i] = random(width);
		stars[i+1] = random(height);	
	}
}

void animateBackground() {
	for (int i = 0; i < stars.length; i += 2) {
	shineValue = random(1);
		if (shineValue > 0.9) {
			strokeWeight(2);
			point(stars[i], stars[i+1]);
		}
		else {
			strokeWeight(1);
			point(stars[i], stars[i+1]);
		}
	}
}

void updateStars() {
	if (starTimer > 0) {
		starTimer--;
	}
	else {		
		spaceLine.add(new SpaceLines());
		starTimer = 30;
	}

	for (SpaceLines eachLine : spaceLine) {
		eachLine.move();
		strokeWeight(1);
		eachLine.draw();
	}

	for (int i = 0; i < spaceLine.size(); ++i) {
		if(outOfBorders(spaceLine.get(i).position)) {
			spaceLine.remove(i);
		}
	}
}