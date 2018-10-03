public class EnemyFloater extends Enemy {
	float velocityX;
	float velocityY;


	public EnemyFloater() {
		super(new PVector(random(0, width), random(0, height)), 15, color(230, 250, 0));
		velocityX = random(-5, 5);
		velocityY = random(-5, 5);
	}

	private EnemyFloater(PVector position, float size, color fillColor) {
		super(position, size, fillColor);
	}

	public void move() {
		position.x += velocityX;
		position.y += velocityY;
	}

	public void draw() {
		ellipseMode(CENTER);
		fill(fillColor);
		ellipse(position.x, position.y, size, size);	
	}

}