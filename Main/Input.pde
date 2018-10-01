boolean moveUp = false;
boolean moveDown = false;
boolean moveLeft = false;
boolean moveRight = false;

void keyPressed() {

	switch (keyCode) {
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

	switch (keyCode) {
		case 'w': moveUp = false;
			break;
		case 's': moveDown = false;
			break;
		case 'a': moveLeft = false;
			break;
		case 'd': moveRight = false;
	}

}