class PauseScreen {
  PImage pauseBG;
	PImage resumeButton;
	PImage backButton;

  boolean[] selectedButton = {true, false};
  boolean firstLoad = true;
  
  Lava lava = new Lava();
  
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
      /*
       * If the Left arrow key is pressed a sound will play
       * And the selected button will change, depending on the button which is already selected
       */
      if (keyCode == LEFT) {
        if (selectedButton[1]) {
          cursorSound.play();
          cursorSound.cue(0);
          
          selectedButton[0] = true;
          selectedButton[1] = false;
        }
      }
      /*
       * If the Right arrow key is pressed a sound will play
       * And the selected button will change, depending on the button which is already selected
       */
      if (keyCode == RIGHT) {
        if (selectedButton[0]) {
          cursorSound.play();
          cursorSound.cue(0);
          
          selectedButton[0] = false;
          selectedButton[1] = true;
        }
      }

      //If the enter key or the 'Z' key is pressed
      if (key == ENTER || keysPressed[90]) {
        /*
         * If the 'Resume' button is selected, 
         * The game state will be changed accordingly and the game will start.
         */
        if (selectedButton[0]) {
          gameState = GameState.PLAYING;
        }
        /* 
         * If the 'Back' button is selected, 
         * The game state will be changed accordingly and you will go back to the main menu
         */
        else if (selectedButton[1]) {
          gameState = GameState.START_SCREEN;
          theWorld.reload();
          
          selectedButton[0] = true;
          selectedButton[1] = false;
        }
      }      
    }

    int mX = mouseX, mY = mouseY; //Variables for the x and y position of the mouse

    /*
     * If the position of the mouse cursor is over the "resume" button, it will be selected.
     * If the left mouse button is pressed the game state will be changed to 'PLAYING' 
     * And you will go back in the game
     */
    if (mY >= yButton && mY <= yButton + hButton) {
      if (mX >= xResume && mX <= xResume + wButton) {
        cursor(HAND);
        selectedButton[0] = true;
        selectedButton[1] = false;
        if (mousePressed && mouseButton == LEFT) {
          gameState = GameState.PLAYING;
        }
      /*
       * If the position of the mouse cursor is over the "back to menu" button, it will be selected.
       * If the left mouse button is pressed the game state will be changed to 'START_SCREEN' 
       * And you will go back to the main menu
       */
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

    if(firstLoad){
      effecten.init();
      firstLoad = false; 
    }

    //Draws the background 
    image(pauseBG, 0, 0);
    
    effecten.draw();
    
    //If the resume button is selected it will look normal, if not it will look darker
    //So people can tell which of the buttons is selected
    if (selectedButton[0]) {
      tint(255, 255);
    } else { 
      tint(50, 255); 
    }

    //Draws the resume button
    image(resumeButton, xResume, yButton, wButton, hButton);

    //If the back button is selected it will look normal, if not it will look darker
    //So people can tell which of the buttons is selected
    if (selectedButton[1]) {
      tint(255, 255);
    } else { 
      tint(50, 255); 
    }

    //Draws the back button
  	image(backButton, xBack, yButton, wButton, hButton);

    //Resets tint values
    tint(255, 255);
  
    // Drawing lava at the bottom of the screen
    lava.draw();
    lava.h = height - lava.screenHeight;
    fill(168, 0, 32);
    noStroke();
    rect(-1, lava.h+31, width + 1, lava.h);
    lava.v = 1;
  }
}
