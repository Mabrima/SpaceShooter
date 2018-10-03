public class Enemy {

	PVector position;
	float size;
	color fillColor;

	public Enemy(PVector position, float size, color fillColor) {
		this.position = position;
		this.size = size;
		this.fillColor = fillColor;
	}

	public void draw() {
		ellipseMode(CENTER);
		stroke(fillColor);
		fill(fillColor);
		ellipse(position.x, position.y, size, size);	
	}

	public void move(){
	}

}