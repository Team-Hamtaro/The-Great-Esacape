class PauseScreen {
  	PImage pauseBG;
  	PImage resumeButton;
  	PImage backButton;

    boolean[] selectedButton = {true, false};

  	//Initializes the images for the pause menu.
  	public PauseScreen() {
    	pauseBG = loadImage("loading.png");
    	resumeButton = loadImage("button_big_resume.png");
    	backButton = loadImage("button_big_back.png");
  	}

    void update() {
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

        if (key == ENTER) {
          if (selectedButton[0]) {
            gameState = GameState.PLAYING;
          }
          else if (selectedButton[1]) {
            gameState = GameState.START_SCREEN;
            theWorld.reload();
          }
        }
      }
    }

  	void updateAndDraw() {
      update();

    	//Draws the background 
    	image(pauseBG, 0, 0);

    	//The variables for the width, height, x and y positions of the buttons
    	int wButton, hButton, xResume, xBack, yButton;
      wButton = 300;
      hButton = 150;
      xResume = width / 4;
      xBack = width - 2 * wButton;
      yButton = height / 2 - hButton / 2;

      if (selectedButton[0]) {
        tint(255, 255);
      } else { 
        tint(50, 255); 
      }

    	image(resumeButton, xResume, yButton, wButton, hButton);

      if (selectedButton[1]) {
        tint(255, 255);
      } else { 
        tint(50, 255); 
      }

    	image(backButton, xBack, yButton, wButton, hButton);

      tint(255, 255);
  }
}