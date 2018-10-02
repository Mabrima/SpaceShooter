boolean moveUp = false;
boolean moveDown = false;
boolean moveLeft = false;
boolean moveRight = false;
boolean mouseLeft = false;
boolean mouseRight = false;


void keyPressed() {

	switch (key) {
		case 'w': moveUp = true;
			break;
		case 's': moveDown = true;
			break;
		case 'a': moveLeft = true;
			break;
		case 'd': moveRight = true;
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