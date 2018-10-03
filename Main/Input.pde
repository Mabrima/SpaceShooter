boolean moveUp = false;
boolean moveDown = false;
boolean moveLeft = false;
boolean moveRight = false;
boolean mouseLeft = false;
boolean mouseRight = false;
boolean spacePressed = false;


void keyPressed() {

	switch (key) {
		case 'w': moveUp = true;
			break;
		case 's': moveDown = true;
			break;
		case 'a': moveLeft = true;
			break;
		case 'd': moveRight = true;
			break;
		case 'W': moveUp = true;
			break;
		case 'S': moveDown = true;
			break;
		case 'A': moveLeft = true;
			break;
		case 'D': moveRight = true;
			break;
		case 32: spacePressed = true;
			break;
	}

}

void keyReleased() {

	switch (key) {
		case 'w': moveUp = false;
			break;
		case 's': moveDown = false;
			break;
		case 'a': moveLeft = false;
			break;
		case 'd': moveRight = false;
			break;
		case 'W': moveUp = false;
			break;
		case 'S': moveDown = false;
			break;
		case 'A': moveLeft = false;
			break;
		case 'D': moveRight = false;
			break;
		case 32: spacePressed = false;
			break;	
	}


}

float getAxisRaw(String axis) {

	if (axis == "Horizontal") {
		if (moveRight && moveLeft)
			return 0;
		if (moveLeft)
			return -1;
		if (moveRight)
			return 1;
	}

	if (axis == "Vertical") {
		if (moveUp && moveDown)
			return 0;
		if (moveUp)
			return -1;
		if (moveDown)
			return 1;
	}

return 0;

}

boolean getMouseLeftClick() {
	return mouseLeft;
}

void mousePressed() {
	switch (mouseButton) {
		case LEFT: mouseLeft = true;
			break;
		case RIGHT: mouseRight = true;
			break;
	}
}

void mouseReleased() {
	switch (mouseButton) {
		case LEFT: mouseLeft = false;
			break;
		case RIGHT:  mouseRight = false;
			break;
	}
}