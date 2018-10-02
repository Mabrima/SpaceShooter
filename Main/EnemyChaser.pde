public class EnemyChaser extends Enemy {
	int speed, chargeSpeed;
	int chargeTimer = 0;
	int reloadTimer = 100;
	PVector target;
	PVector direction;
	PVector previousTarget;


	public EnemyChaser() {
		position = new PVector(350, 700);
		speed = 2;
		chargeSpeed = 3;
		size = 30;
		fillColor = color(10, 90, 20);
		target = new PVector();
		direction = new PVector();
		previousTarget = new PVector();
	}

	public void move() {
		if (chargeTimer >= 30) {
			chargeTimer--;
			speed = 2;
			direction.set(target.x - position.x, target.y - position.y);
			direction.normalize();
			position.x += direction.x * speed;
			position.y += direction.y * speed;	
		}
		else if (chargeTimer < 30 && chargeTimer > 0) {
			chargeTimer--;
			speed = 10;
			direction.set(previousTarget.x - position.x, previousTarget.y - position.y);
			direction.normalize();
			position.x += direction.x * speed;
			position.y += direction.y * speed;
		}
		else if (chargeTimer == 0) {
			chargeTimer = reloadTimer;
			previousTarget.set(target);
		}
		println(chargeTimer);
	}

	public void draw() {
		ellipseMode(CENTER);
		fill(fillColor);
		ellipse(position.x, position.y, size, size);	
	}

	public void chase(PVector playerPos) {
		target.set(playerPos);

	}

}