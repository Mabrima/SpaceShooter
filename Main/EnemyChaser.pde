public class EnemyChaser extends Enemy {
	float speed;
	PVector target;
	PVector direction;


	public EnemyChaser() {
		position = new PVector(350, 700);
		speed = 3;
		size = 30;
		fillColor = color(10, 150, 20);
		target = new PVector();
		direction = new PVector();
	}

	public void move() {
		direction.set(target.x - position.x, target.y - position.y);
		direction.normalize();
		position.x += direction.x * speed;
		position.y += direction.y * speed;
	}

	public void draw() {
		ellipseMode(CENTER);
		fill(fillColor);
		ellipse(position.x, position.y, size, size);	
	}

	public void findPlayerPosition(PVector playerPos) {
		target.set(playerPos);
	}

}