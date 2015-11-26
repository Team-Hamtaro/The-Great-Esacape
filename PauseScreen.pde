class PauseScreen {
  	PImage pauseBG;
  	PImage resumeButton;
  	PImage backButton;

  	//Initializes the images for the pause menu.
  	public PauseScreen() {
    	pauseBG = loadImage("loading.png");
    	resumeButton = loadImage("button_big_resume.png");
    	backButton = loadImage("button_big_back.png");
  	}

  	//Pauses the game
  	void pauseGame() {
    	gameState = GameState.GAME_PAUSED;
  	}

  	//Unpauses the game
  	void unpauseGame() {
    	gameState = GameState.PLAYING;
  	}

  	void updateAndDraw() {
    	//Draws the background 
    	image(pauseBG, 0, 0);

    	//The variables for the width, height, x and y positions of the buttons
    	int wButton, hButton, xButton, yResume, yBack;
    	wButton = 300;
    	hButton = 150;
    	xButton = width / 2 - wButton / 2;
    	yResume = height / 3 - hButton / 2;
    	yBack = (height / 3) * 2 - hButton / 2;

    	//Draws the 'Resume' and the 'Back to Menu' button.
    	image(resumeButton, xButton, yResume, wButton, hButton);
    	image(backButton, xButton, yBack, wButton, hButton);


    	//Variables for the mouse position.
    	int mX = mouseX, mY = mouseY;

    	/*
     	 * If the position of the mouse is over the 'Resume' button, 
     	 * the game will be resumed if the left mouse button is pressed
     	 */
    	if (mX > xButton && mX < xButton + wButton && mY > yResume && mY < yResume + hButton) {
      	if (mousePressed) {
        		if (mouseButton == LEFT) {
          		unpauseGame();
        		}
      	}
    	}

    	/*
     	 * If the position of the mouse is over the 'Back To Menu' button, 
     	 * the player will return to the main menu if the left mouse button is pressed
     	 */
    	if (mX > xButton && mX < xButton + wButton && mY > yBack && mY < yBack + hButton) {
      	if (mousePressed) {
        		if (mouseButton == LEFT) {
          		gameState = GameState.START_SCREEN;
        		}
      	}
    	}
  	}
}