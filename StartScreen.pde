/**
 *  The startscreen is displayed on game startup and
 *  offers the user the option to start the game.
 *
 *  @author 
 *  @since  `date +%d.%m.%Y`
 */
class StartScreen {

	//The images of the background and the buttons.
	PImage startBG;
 	PImage playButton;
  	PImage quitButton;

	/**
	 *  Default constructor. Here we load the the background image.
	 */
	public StartScreen() {
		startBG = loadImage("loading.png");
    	playButton = loadImage("button_big_play.png");
    	quitButton = loadImage("button_big_quit.png");
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
		//Variables for the width, height, x and y positions of the buttons
		int  wButton, hButton, xPlay, xQuit, yButton;
    	wButton = 300;
    	hButton = 150;
    	xPlay = width/4;
    	xQuit = width - 2 * wButton; 
    	yButton = height/2;

    	//Variables for the mouse position
    	int mX = mouseX, mY = mouseY;

    	//If the mouse is over the 'Play' button and the left mouse button is pressed the game will start
    	if (mX > xPlay && mX < xPlay + wButton && mY > yButton && mY < yButton + hButton) {
      		if (mousePressed && mouseButton == LEFT) {
        		startGame();
        		println("Start Game");
      		}
    	}
    
    	//If the mouse is over the 'Quit' button and the left mouse button is pressed the game will be closed
    	if (mX > xQuit && mX < xQuit + wButton && mY > yButton && mY < yButton + hButton) {
      		if (mousePressed && mouseButton == LEFT) {
        		exit();
        		println("Quit Game");
      		}
    	}

    	//Draws the background and the 'Play' and 'Quit' buttons
    	image(startBG, 0, 0);
    	image(playButton, xPlay, yButton, wButton, hButton);
    	image(quitButton, xQuit, yButton, wButton, hButton);
    
    	//Draws the title of the game
    	fill(255);
    	textSize(64);
    	textAlign(CENTER);
    	text("The Great Escape", width/2, height/3);
	}
}
