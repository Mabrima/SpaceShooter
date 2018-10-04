public class Player {
	PVector movement;
	PVector position;
	float velocity;
	float size;
	int reloadTime = 10;
	int reloadTimer = 0;
	int borderLeniency = 20;
	color bulletColor = color(255);
	color fillColor = color(200, 100, 20);
	int health = 45;

	ArrayList<Bullet> bullets = new ArrayList<Bullet>();

	//triangle vectors
	PVector facingDirection, facingLeft, facingRight;
	int shipLength = 10;
	int halfShipWidth = shipLength / 2;
	float frontx, fronty, leftx, lefty, rightx, righty;
	



	public Player () {
		position = new PVector(850, 330);
		velocity = 5;
		size = 20;
		movement = new PVector(0,0);

		facingDirection = new PVector(0,0);
		facingLeft = new PVector(0,0);
		facingRight = new PVector(0,0);
	}

	public void move () {
		movement.y = getAxisRaw("Vertical");
		movement.x = getAxisRaw("Horizontal");
		movement.normalize();
		position.x += movement.x * velocity;
		position.y += movement.y * velocity;

		// screenWarp();
		screenWall();
		
		//tri-nan-gle
		facingDirection.set(mouseX - position.x, mouseY - position.y);
		facingDirection.normalize();
		facingLeft.set(facingDirection.y, -facingDirection.x);
		facingLeft.normalize();
		facingRight.set(-facingDirection.y, facingDirection.x);
		facingRight.normalize();

		frontx = position.x + facingDirection.x * shipLength;
		fronty = position.y + facingDirection.y * shipLength;
		leftx  = position.x + facingLeft.x * halfShipWidth;
		lefty  = position.y + facingLeft.y * halfShipWidth;
		rightx = position.x + facingRight.x * halfShipWidth;
		righty = position.y + facingRight.y * halfShipWidth;

		shoot();

	}

	public void playerDraw(){

		fill(fillColor);
		stroke(fillColor);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);

		//Antons hopkokade rotating triangle
		fill(0,255,0);
		triangle(frontx, fronty, leftx, lefty, rightx, righty);

		for (int i = 0; i < bullets.size(); i++) {
			bullets.get(i).move();
			bullets.get(i).draw();
		}
	}

	void screenWarp() {
		if (position.x > width) {
			position.x = size/2;
		} else if (position.x < 0) {
			position.x = width - size/2;
		} else if (position.y > height) {
			position.y = size/2;
		} else if (position.y < 0) {
			position.y = height - size/2;
		}
	}

	void screenWall() {
		if (position.x > width) {
			position.x = width;
		} else if (position.x < 0) {
			position.x = 0;
		} else if (position.y > height) {
			position.y = height;
		} else if (position.y < 0) {
			position.y = 0;
		}
	}

	void shoot(){
		if (reloadTimer > 0) {
			reloadTimer--;
		}
		else if (getMouseLeftClick()) {
			bullets.add(new Bullet(position.copy(), facingDirection.copy(), bulletColor, 10, 10));
			reloadTimer = reloadTime;
		}
	}

	ArrayList<Bullet> getBullets() {
		return bullets;
	}

	void hit(){
		health--;
	}

	int getHealth() {
		return health;
	}

	boolean isAlive(){
		return health > 0;
	} 

}