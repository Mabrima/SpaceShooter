public class EnemyCharger extends EnemyChaser {
	int normalSpeed = 1, chargeSpeed = 10, chargeTimer = 100, chargeCooldown = 30;
	boolean charge = false;
	PVector previousTarget;

	public EnemyCharger() {
		super(new PVector(350, 700), 30, color(10, 90, 20));

		previousTarget = new PVector(0,0);
	}

	public void move() {
		if (charge) {
			direction.set(previousTarget.x - position.x, previousTarget.y - position.y);
			direction.normalize();
			position.x += direction.x * chargeSpeed;
			position.y += direction.y * chargeSpeed;
			if (dist(position.x, position.y, previousTarget.x, previousTarget.y) < 5) {
				charge = false;
				chargeTimer = chargeCooldown;
			}
		}
		else {
			direction.set(target.x - position.x, target.y - position.y);
			direction.normalize();
			position.x += direction.x * normalSpeed;
			position.y += direction.y * normalSpeed;
			chargeTimer--;
			if (chargeTimer == 0) {
				previousTarget.set(target);
				charge = true;
			}
		}
	}
}
