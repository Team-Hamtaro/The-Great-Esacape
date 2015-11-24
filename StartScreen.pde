/**
 *  The startscreen is displayed on game startup and
 *  offers the user the option to start the game.
 *
 *  @author 
 *  @since  `date +%d.%m.%Y`
 */
class StartScreen {

	/**
	 *  The background image
	 */
	PImage startScreenImage;

	/**
	 *  Default constructor. Here load the the background image.
	 */
	public StartScreen(){
		startScreenImage = loadImage("loading.png");
	}
	
	/**
	 *  Check for keypresses and starts the game.
	 */
	void update() {
		if (keysPressed[ENTER] || keysPressed[' ']) {
			println("Start Game");
			startGame();
		}
	}

	/**
	 *  Sets global var @gamestate to playing
	 */
	void startGame() {
		gameState = GameState.PLAYING;
	}

	/**
	 *  Update and draw startscreen.
	 */
	void updateAndDraw() {
		update();

		image(startScreenImage, 0, 0);
		fill(255);
		textSize(64);
		textAlign(CENTER);
		text("The Great Escape", width/2, height/3);
		textSize(24);
		text("Press the 'Space' bar to start", width/2, height/3 + 36);
	}
}