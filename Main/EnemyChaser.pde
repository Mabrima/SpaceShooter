public class EnemyChaser extends Enemy {
	int normalSpeed = 1, chargeSpeed = 10, chargeTimer = 100, chargeCooldown = 60;
	boolean charge = false;
	PVector target;
	PVector direction;
	PVector previousTarget;


	public EnemyChaser() {
		position = new PVector(350, 700);
		size = 30;
		fillColor = color(10, 90, 20);

		target = new PVector(0,0);
		direction = new PVector(0,0);
		previousTarget = new PVector(0,0);
	}

	public void chase(PVector playerPos) {
		target.set(playerPos);
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

	public void draw() {
		ellipseMode(CENTER);
		fill(fillColor);
		ellipse(position.x, position.y, size, size);	
	}

}

/*
1. Chase player slowly for x seconds
2. Snapshot player position
3. Charge towards snapshotted position
4. When reaching player position, goto step 1
*/