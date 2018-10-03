public class Explosion {
	PVector position;
	PVector direction;
	color enemyColor;
	float velocity = 10;
	float size = 5;
	int lifeTime = 30;

	public Explosion(PVector position, color enemyColor) {
		this.position = position;
		this.enemyColor = enemyColor;
	}

	public void move() {
		position.x += random(-1, 1) * velocity; 
		position.y += random(-1, 1) * velocity; 
		lifeTime--;
	}

	public void draw() {
		fill(enemyColor);
		stroke(enemyColor);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, lifeTime, lifeTime);
	}

	public boolean isAlive() {
		return lifeTime > 0;
	}

}