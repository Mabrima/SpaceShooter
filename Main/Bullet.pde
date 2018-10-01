public class Bullet {
	PVector position;
	PVector direction;
	float velocity = 5;
	float size = 5;
	public Bullet(PVector position, PVector direction) {
		this.position = position;
		this.direction = direction;
	}

	public void moves() {
		position.x += cos(direction.x) * velocity;
		position.y += sin(direction.y) * velocity;
	}

	public void draw() {
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);
	}

}