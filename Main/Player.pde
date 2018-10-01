public class Player {
	PVector movement;
	PVector position;
	float velocity;
	float size;
	
	// float facingDirection;


	public Player () {
		position = new PVector(100, 100);
		velocity = 2;
		size = 20;
		movement = new PVector(0,0);
	}

	public void move () {
	movement.y = getAxisRaw("Vertical");
	movement.x = getAxisRaw("Horizontal");
	movement.normalize();
	player.position.x += movement.x * player.velocity;
	player.position.y += movement.y * player.velocity;
	}

	public void playerDraw(){

	ellipseMode(CENTER);
	ellipse(player.position.x, player.position.y, player.size, player.size);

	// triangle(player.position.x, player.position.y, 
	// 	player.position.x-player.size/2, player.position.y+player.size, 
	// 	player.position.x+player.size/2, player.position.y+player.size);
	}

}