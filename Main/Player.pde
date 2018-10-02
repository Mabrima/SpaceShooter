public class Player {
	PVector movement;
	PVector position;
	float velocity;
	float size;

	//triangle vectors
	PVector facingDirection, facingLeft, facingRight;
	int shipLength = 20;
	int halfShipWidth = shipLength / 2;
	float frontx, fronty, leftx, lefty, rightx, righty;
	



	public Player () {
		position = new PVector(100, 100);
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

	}

	public void playerDraw(){

		// ellipseMode(CENTER);
		// ellipse(position.x, position.y, size, size);

		//Antons hopkokade rotating triangle
		fill(0,255,0);
		triangle(frontx, fronty, leftx, lefty, rightx, righty);

		// triangle(player.position.x, player.position.y, 
		// 	player.position.x-player.size/2, player.position.y+player.size, 
		// 	player.position.x+player.size/2, player.position.y+player.size);
	}

}