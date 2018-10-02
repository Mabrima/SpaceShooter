public class Bullet {
	PVector position;
	PVector direction;
	color bulletColor;
	float velocity = 10;
	float size = 5;
	public Bullet(PVector position, PVector direction, color bulletColor) {
		this.position = position;
		this.direction = direction;
		this.bulletColor = bulletColor;
	}

	public void move() {
		position.x += direction.x * velocity; 
		position.y += direction.y * velocity; 
	}

	public void draw() {
		fill(bulletColor);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);
	}

}