public class EnemyFloater extends Enemy{
	float velocityX;
	float velocityY;


	public EnemyFloater () {
		position = new PVector(700, 700);
		velocityX = -3;
		velocityY = -2;
		size = 15;
		fillColor = color(60, 10, 0);
	}

	public void move() {
		position.x += velocityX;
		position.y += velocityY;
	}

	public void draw(){
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);
		fill(fillColor);
	}

}