public class EnemyBasicShooter extends EnemyFloater {
	Bullet bullet;
	int reloadTimer = 30;
	int reloadTime = 30;
	PVector target = new PVector(0,0);
	boolean fired = false;

	public EnemyBasicShooter() {
		super(new PVector(random(500, 700), random(500, 700)), 15, color(95,95,0));
		velocityX = random(-5, 5);
		velocityY = random(-5, 5);
	}

	public void findPlayerPosition(PVector playerPos) {
		target.set(playerPos.x - position.x, playerPos.y - position.y);
		target.normalize();
	}

	public void move() {
		position.x += velocityX;
		position.y += velocityY;
		shoot();
	}

	void shoot() {
		if (reloadTimer > 0) {
			reloadTimer--;
			fired = false;
		}
		else {
			bullet = new Bullet(position.copy(), target.copy(), fillColor);
			reloadTimer = reloadTime;
			fired = true;
		}
	}

	Bullet getBullet() {
		return bullet;
	}

}
