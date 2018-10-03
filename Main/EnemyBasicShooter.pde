public class EnemyBasicShooter extends Enemy {
	float velocityX;
	float velocityY;
	ArrayList<Bullet> enemyBullets = new ArrayList<Bullet>();

	public EnemyBasicShooter() {
		position = new PVector(random(500, 700), random(500, 700));
		velocityX = random(-5, 5);
		velocityY = random(-5, 5);
		size = 30;
		fillColor = (27, 183, 175);
	}

	public void move() {
		position.x += velocityX;
		position.y += velocityY;
	}

	public void draw() {
		ellipseMode(CENTER);
		fill(fillColor);
		ellipse(position.x, position.y, size, size);
	}

	void shoot() {
		if (bulletIntervalTimer > 0) {
			bulletIntervalTimer--;
		}
		else {
			bullet
		}
	}

}