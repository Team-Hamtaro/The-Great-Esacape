// The GameOverScreen class hold all the functionality for displaying game-over information 
class GameOverScreen {
  	int points = 0;
    
    // GameOverScreen can be recycled for win and lose
   PImage gameOverBG;
   PImage playButton;
   PImage backButton;
   String gameOverMessage = "";
    
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
    
   // update and draw the gameover screen
   void updateAndDraw() {
      int wButton, hButton, xPlay, xBack, yButton;
      wButton = 300;
      hButton = 150;
      xPlay = width / 4;
      xBack = width - 2 * wButton;
      yButton = height / 3;
        
      int mX = mouseX, mY = mouseY;
        
      if (mX > xPlay && mX < xPlay + wButton && mY > yButton && mY < yButton + hButton) {
        	if (mousePressed && mouseButton == LEFT) {
         	gameState = GameState.PLAYING;
         }
      }
        
      if (mX > xBack && mX < xBack + wButton && mY > yButton && mY < yButton + hButton) {
         if (mousePressed && mouseButton == LEFT) {
         	gameState = GameState.START_SCREEN;
         }
      }

      // Draw the background image
      image(gameOverBG, 0, 0);
      image(playButton, xPlay, yButton, wButton, hButton);
      image(backButton, xBack, yButton, wButton, hButton);
        
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
