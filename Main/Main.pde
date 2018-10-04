Player player;
int borderLeniency = 20;
color gameOverColor = color(15, 10, 15);
int spawnTime = 45;
int spawnTimer = 30;
int frames = 0;
int score = 0;
int killScore = 0;
int waveAmount = 5;

//Menu shit
int[] startButton = {232, 162, 265, 125};
int[] quitButton = {232, 362, 265, 125};

// for background
int numberOfStars = 200;
int starTimer = 30;
float shineValue;
float[] stars;
ArrayList<SpaceLines> spaceLine = new ArrayList<SpaceLines>();

String gameState; //Menu, Gameplay, GameOver

ArrayList<Bullet> playerBullets;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
ArrayList<Bullet> enemyBullets = new ArrayList<Bullet>();


void setup() {
	size(1280, 720);
	player = new Player();
	playerBullets = player.getBullets();
	gameOverColor = color(200, 10, 20);
	textSize(50);
	textAlign(CENTER);
	rectMode(CENTER);

	gameState = "MainMenu";

	//for background
	stars = new float[numberOfStars];
	starBackground();
}

void draw() {

	if (gameState.equals("MainMenu")) {
		backgroundGroup();
		menuFunctions();
		checkBoxes();
	}

	if (gameState.equals("Gameplay")) {
		backgroundGroup();
		scoreDraw();
		updateGame();
		newWave();
		score = killScore + frames/60; 
		frames++;
	}

	if(gameState.equals("GameOver")) {
		backgroundGroup();
		gameOver();
	}

	surface.setTitle(int(frameRate) + " fps");
	
}

void scoreDraw() {
	textAlign(LEFT);
	textSize(20);
	fill(255);
	text("Score: " + score, 20, 30);
}

void gameOver() {
	fill(gameOverColor);
	textSize(50);
	textAlign(CENTER);
    text("You Are Dead!", width/2, height/2); 
    text("Score: " + score, width/2, height/3);
    if (frames%120 >= 60) 
			text("Press Space to retry!", width/2, height*2/3);
	if (spacePressed) 
		resetGame();
}

void healthSystem() {
	textAlign(CENTER);
	fill(200 - player.health*4, 10, 0);
	text("You Are Dying!", width/2, height/2); 
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
			if (randomSpawn > 95) {
				enemies.add(new EnemyCharger());
			}
			else if (randomSpawn > 80) {
				enemies.add(new EnemyChaser());
			}
			else if (randomSpawn > 55) {
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
	player.getBullets().clear();
	frames = 0;
	gameState = "Gameplay";
	waveAmount = 5;
	killScore = 0;
}

void updateGame() {

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

	//checks playerBullets towards enemies and kills them if they hit and adds explosions to that area // now also adds score!
	for (int i = 0; i < playerBullets.size(); i++) { //checks if playerBullets hit enemies and kills them
		for (int j = 0; j < enemies.size(); j++) {
			if (i != playerBullets.size() && circleCollision(playerBullets.get(i).position, playerBullets.get(i).size, enemies.get(j).position, enemies.get(j).size)){
				addExplosions(enemies.get(j), (int) random(2,5));
				if (enemies.get(j) instanceof EnemyFloater && !(enemies.get(j) instanceof EnemyBasicShooter)) {
					killScore += 5;
				} else {
					killScore++;
				}
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

void backgroundGroup() {
	background(10, 10, 10);
	stroke(255);
	strokeWeight(1);
	animateBackground();
	updateStars();
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
		starTimer = 30 - (((waveAmount-4) * 5));
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

//in MainMeny j < amountOfmenyButtons
void checkBoxes() {
	for (int i = 0; i < playerBullets.size(); i++) { //checks if playerBullets hit enemies and kills them
		if (boxAndCircleCollision(playerBullets.get(i).position, playerBullets.get(i).size, startButton)){
			gameState = "Gameplay";
		}

		if (boxAndCircleCollision(playerBullets.get(i).position, playerBullets.get(i).size, quitButton)){
			exit();
		}

	} 
}

void menuFunctions() {

	player.move();
	player.playerDraw();

   // int[] startButton = {100, 100, 200, 100};
   // int[] quitButton = {100, 300, 200, 100};  
  	
  	textSize(50);
  	stroke(0);
   	fill(255);
	rect(startButton[0], startButton[1], startButton[2], startButton[3]);
	fill(128);
	text("Play", startButton[0],
		 startButton[1] + ((textAscent()) * 0.33));

	fill(255);
	rect(quitButton[0], quitButton[1], quitButton[2], quitButton[3]);
	fill(128);
	text("Quit", quitButton[0],
		 quitButton[1] + ((textAscent()) * 0.33));

	//Instructions
	textSize(20);
	textAlign(CENTER);
	text("Welcome to SpaceyShooty, this is a game about shooty, in space(y)." + '\n' +
	"You will be attacked on all sides, by other stuff, sometimes they shoot, too." + '\n' +
	"The goal is to stay alive as long as possible and give them aliens what for!" + '\n' +
	"Here is a free tip. The yellow floaters are worth five times as many points" + '\n' +
	" " + '\n' +
	"This is you"  + '\n' +
	"	|"  + '\n' +
	"	V" + '\n' +
	" " + '\n' +
 	" " + '\n' +
	"Fly around the screen with WASD, use the mouse to aim." + '\n' +
	"Click 'Play' to begin.", 850, 120);

	//Credits
	textSize(20);
	textAlign(CENTER);
	text("Av Robin Arkblad" + '\n' + "och Anton Lindkvist", 230, 600);
}
