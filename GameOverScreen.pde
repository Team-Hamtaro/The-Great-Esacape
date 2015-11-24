// The GameOverScreen class hold all the functionality for displaying game-over information 
class GameOverScreen {
    int points = 0;
    
    // GameOverScreen can be recycled for win and lose
    PImage currentImage;
    String gameOverMessage = "";
    
    // Init loads the images
    void init(){
        currentImage = loadImage("loading.png");
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
        // If space is pressed, go to the start screen
        if (keysPressed[ENTER] || keysPressed[' ']) gameState = GameState.START_SCREEN;
    }

    // update and draw the gameover screen
    void updateAndDraw() {
                
        update();

        // Draw the background image
        image(currentImage, 0, 0);
        
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
        text("You had " + points + " points", width/2, height/2 + 120);
        text("-=Press Space=-", width/2, height/2 + 140);
    }
}