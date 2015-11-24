/**
 *  Player Class
 *
 */
 class Player extends Tile {

	float speed = 5;
	final int SIZE = 30;
	final float DAMPING = 0.3;


	// // The init method can be called to set a player to it's default state
	// void init(float newX, float newY, float newWidth, float newHeight) {
	//   w = newWidth;
	//   h = newHeight;
	//   x = newX;   
	//   y = newY;
	void init(float x, float y) {
		super.init(x,y,SIZE,SIZE);
		fillColor = color(255, 0, 0);
	}



	// The update method is called whenever we want to calculate the new position of a player
	// based on the keyboard input
	void update() {
		vx *= DAMPING; // our object will move a bit slower every frame
		vy *= DAMPING;

		// Velocity is changed when arrow keys are pressed 
		if (keysPressed[LEFT]) vx = -1;
		if (keysPressed[RIGHT]) vx = 1;
		if (keysPressed[UP]) vy = -5;
		if (keysPressed[DOWN]) vy = 1;

		// Update our position using the velocity
		x += vx * speed;
		y += vy * speed;

		// Disable bouncing on the edges of the screen
		// We have a camera now so we don't need it
		//    x = constrain(x, 0, width-w);
		//    y = constrain(y, 0, height-h);
		   
		vy += 2;   
	}

	//Call the draw method to draw the player
	void draw() {

		update();

		fill(fillColor);

	    // our player is a triangle   
	    triangle(x, y+h, 
	    x+w/2, y, 
	    x+w, y+h);
	}
}

