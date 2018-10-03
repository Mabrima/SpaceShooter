public class EnemyChaser extends Enemy {
	float speed;
	PVector target;
	PVector direction;


	public EnemyChaser() {
		super(new PVector(350, 700), 30, color(10, 150, 20));

		speed = 3;
		target = new PVector(0, 0);
		direction = new PVector(0, 0);
	}

	private EnemyChaser(PVector position, float size, color fillColor) {
		super(position, size, fillColor);

		target = new PVector(0, 0);
		direction = new PVector(0, 0);
	}

	public void move() {
		direction.set(target.x - position.x, target.y - position.y);
		direction.normalize();
		position.x += direction.x * speed;
		position.y += direction.y * speed;
	}

	public void findPlayerPosition(PVector playerPos) {
		target.set(playerPos);
	}

}