class PauseScreen {
  PImage pauseBG;
	PImage resumeButton;
	PImage backButton;

  boolean[] selectedButton = {true, false};

  //The variables for the width, height, x and y positions of the buttons
  int wButton, hButton, xResume, xBack, yButton;
      
	//Initializes the images for the pause menu.
  public PauseScreen() {
    pauseBG = loadImage("loading.png");
    resumeButton = loadImage("button_big_resume.png");
    backButton = loadImage("button_big_back.png");

    wButton = 256;
    hButton = 128;
    xResume = wButton;
    xBack = width - 2 * wButton;
    yButton = height/2;
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

      if (key == ENTER || keysPressed[90]) {
        if (selectedButton[0]) {
          gameState = GameState.PLAYING;
        }
        else if (selectedButton[1]) {
          gameState = GameState.START_SCREEN;
          theWorld.reload();
        }
      }      
    }

    int mX = mouseX, mY = mouseY;
    if (mY >= yButton && mY <= yButton + hButton) {
      if (mX >= xResume && mX <= xResume + wButton) {
        cursor(HAND);
        selectedButton[0] = true;
        selectedButton[1] = false;
        if (mousePressed && mouseButton == LEFT) {
          gameState = GameState.PLAYING;
        }
      } else if (mX >= xBack && mX <= xBack + wButton) {
        cursor(HAND);
        selectedButton[0] = false;
        selectedButton[1] = true;
        if (mousePressed && mouseButton == LEFT) {
          theWorld.reload();  
          gameState = GameState.START_SCREEN;
        }
      } else {
        cursor(ARROW);
      }
    } else {
      cursor(ARROW); 
    }
  }

  void updateAndDraw() {
    update();

    //Draws the background 
    image(pauseBG, 0, 0);

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
