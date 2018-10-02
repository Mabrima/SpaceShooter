public class Bullet {
	PVector position;
	PVector direction;
	float velocity = 5;
	float size = 5;
	public Bullet(PVector position, PVector direction) {
		this.position = position;
		this.direction = direction;
	}

	public void move() {
		position.x += direction.x * velocity; 
		position.y += direction.y * velocity; 
	}

	public void draw() {
		fill(255);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);
	}

}