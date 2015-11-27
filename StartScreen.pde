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

    boolean[] selectedButton = {true, false};

    int timer = 0;

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

    void update() {
        timer++;
      if (keyPressed) {
        if (keyCode == LEFT) {
          if (selectedButton[1]) {
            selectedButton[0] = true;
            selectedButton[1] = false;
          }
        }

        if (keyCode == RIGHT) {
          if (selectedButton[0]) {
            selectedButton[0] = false;
            selectedButton[1] = true;
          }
        }

        if (timer > 10) {
        if (key == ENTER) {
          if (selectedButton[0]) {
            startGame();
            timer = 0;
          }
          else if (selectedButton[1]) {
            exit();
          }
        }
    }
      }
    }

	/**
	 *  Update and draw startscreen.
	 */
	void updateAndDraw() {
        update();

		//Variables for the width, height, x and y positions of the buttons
		int  wButton, hButton, xPlay, xQuit, yButton;
    	wButton = 256;
    	hButton = 128;
    	xPlay = wButton;
    	xQuit = width - 2 * wButton; 
    	yButton = height/2;

    	//Draws the background and the 'Play' and 'Quit' buttons
    	image(startBG, 0, 0);
    	
        if (selectedButton[0]) {
            tint(255, 255);
        } else { 
            tint(50, 255); 
        }

        image(playButton, xPlay, yButton, wButton, hButton);

        if (selectedButton[1]) {
            tint(255, 255);
        } else { 
            tint(50, 255); 
        }

        image(quitButton, xQuit, yButton, wButton, hButton);

        tint(255, 255);
    
    	//Draws the title of the game
    	fill(255);
    	textSize(64);
    	textAlign(CENTER);
    	text("The Great Escape", width/2, height/3);
	}
}
