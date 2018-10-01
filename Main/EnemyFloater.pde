public class EnemyFloater extends Enemy{
	float velocityX;
	float velocityY;


	public EnemyFloater () {
		position = new PVector(700, 700);
		velocityX = random(-5, 5);
		velocityY = random(-5, 5);
		size = 15;
		fillColor = color(60, 10, 0);
	}

	public void move() {
		position.x += velocityX;
		position.y += velocityY;
	}

}