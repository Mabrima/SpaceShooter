public class Bullet {
	PVector position;
	PVector direction;
	color bulletColor;
	float velocity;
	float size;
	
	public Bullet(PVector position,
				  PVector direction,
				  color bulletColor,
				  float bulletVelocity,
				  float bulletSize) {
		this.position = position;
		this.direction = direction;
		this.bulletColor = bulletColor;
		this.velocity = bulletVelocity;
		this.size = bulletSize;
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