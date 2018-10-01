public class Player {
	PVector movement;
	PVector position;
	float velocity;
	float size;
	
	// float facingDirection;


	public Player () {
		position = new PVector(100, 100);
		velocity = 5;
		size = 20;
		movement = new PVector(0,0);
	}

	public void move () {
		movement.y = getAxisRaw("Vertical");
		movement.x = getAxisRaw("Horizontal");
		movement.normalize();
		position.x += movement.x * velocity;
		position.y += movement.y * velocity;
	}

	public void playerDraw(){

		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);

		// triangle(player.position.x, player.position.y, 
		// 	player.position.x-player.size/2, player.position.y+player.size, 
		// 	player.position.x+player.size/2, player.position.y+player.size);
	}

}