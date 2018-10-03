public class EnemyBasicShooter extends EnemyFloater {
	ArrayList<Bullet> bullets = new ArrayList<Bullet>();
	int reloadTimer = 0;
	int reloadTime = 30;
	PVector target = new PVector(0,0);

	public EnemyBasicShooter() {
		super(new PVector(random(500, 700), random(500, 700)), 15, color(95,95,0));
	}

	public void findPlayerPosition(PVector playerPos) {
		target.set(playerPos);
	}

	void shoot() {
		if (reloadTimer > 0) {
			reloadTimer--;
		}
		else {
			bullets.add(new Bullet(position.copy(), target.normalize(), fillColor));
			reloadTimer = reloadTime;
		}
	}

	ArrayList<Bullet> getBullets() {
		return bullets;
	}

}
