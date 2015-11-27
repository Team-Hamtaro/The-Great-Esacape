// The GameOverScreen class hold all the functionality for displaying game-over information 
class GameOverScreen {
  	int points = 0;
    
    // GameOverScreen can be recycled for win and lose
   PImage gameOverBG;
   PImage playButton;
   PImage backButton;
   String gameOverMessage = "";

   boolean[] selectedButton = {true, false};

    /**
     *  Default constructor. Here we load the the background image.
     */
   public GameOverScreen(){
      gameOverBG = loadImage("loading.png");
      playButton = loadImage("button_big_play.png");
      backButton = loadImage("button_big_back.png");
   }

   // Use this gameover screen for win message 
   void setWon(){
      gameOverMessage = "Congratulations!!";
   }
    
   // Use this gameoverscreen for lose message
   void setLose(){
      gameOverMessage = "Game Over!! Try Again!";
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
          }
        }
      }
    }
    
   // update and draw the gameover screen
   void updateAndDraw() {
      update();

      int wButton, hButton, xPlay, xBack, yButton;
      wButton = 256;
      hButton = 128;
      xPlay = wButton;
      xBack = width - 2 * wButton;
      yButton = height / 3;

      // Draw the background image
      image(gameOverBG, 0, 0);
      
      if (selectedButton[0]) {
        tint(255, 255);
      } else { 
        tint(50, 255); 
      }
      
      image(playButton, xPlay, yButton, wButton, hButton);
      
      if (selectedButton[1]) {
        tint(255, 255);
      } else { 
        tint(100, 255); 
      }
      
      image(backButton, xBack, yButton, wButton, hButton);

      tint(255, 255);
        
      // draw gameover text
      fill(255);
      textSize(32);
      textAlign(CENTER);
      text(gameOverMessage, width/2, 40);
       
      // draw bottom text frame
      textSize(24);
      fill(0, 0, 0, 50);
      rect(0, height/2+90, width, 70);
        
      // draw the bottom text
      noStroke();
      fill(255);
      text("You had " + points + " points", width/2, height/2 + 135);
  	}
}
