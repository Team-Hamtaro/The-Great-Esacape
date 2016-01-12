// The GameOverScreen class hold all the functionality for displaying game-over information 
class GameOverScreen {
  int points = 0;
  LeaderBoard leaderBoard;
    
  // GameOverScreen can be recycled for win and lose
  PImage gameOverBG;
  PImage playButton;
  PImage backButton;
  String gameOverMessage = "";

  boolean[] selectedButton = {true, false};

  Lava lava = new Lava();
  
  int wButton, hButton, xPlay, xBack, yButton;
  ArrayList<HighScore> scores;
  String playerName = "";
  boolean takeingInput = true;

  /**
   *  Default constructor.
   */
  public GameOverScreen(){
    gameOverBG = loadImage("loading.png");
    playButton = loadImage("button_big_again.png");
    backButton = loadImage("button_big_back.png");
    leaderBoard = new LeaderBoard();
    scores = leaderBoard.score_list;
    setLose();
  
    wButton = 256;
    hButton = 128;
    xPlay = wButton;
    xBack = width - 2 * wButton;
    yButton = height / 3;
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
    handleInput();
  }
    
  // update and draw the gameover screen
  void updateAndDraw() {
    update();

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

    drawLava();
    drawMessage();
    drawScore();
    drawScoreList();
  }

  void drawLava() {
    tint(255, 255);
         
    // Drawing lava at the bottom of the screen
    lava.draw();
    lava.h = height - lava.screenHeight;
    fill(168, 0, 32);
    noStroke();
    rect(-1, lava.h+31, width + 1, lava.h);
    lava.v = 1;
  }

  /**
   * Draw the screen heading
   */
  void drawMessage() {
    fill(255);
    textSize(64);
    textAlign(CENTER);
    text(gameOverMessage, width/2, 140);
  }

  /**
   * Draw the Player's score
   */
  void drawScore() {
    // draw bottom text frame
    textSize(36);
    fill(0, 0, 0, 50);
    rect(0, height/2+40, width, height/2);
    String scoreMessage = "You had " + points + " points !";
    // draw the bottom text
    noStroke();
    fill(255);

    if (leaderBoard.isNewHighScore(points)) {
      scoreMessage += " Type your name! ";
      takeingInput = true;
      gameOverMessage = "Congratulations! New HighScore!";
      if (playerName != "") {
        scoreMessage = playerName;
      }
      getUsername();
    }
    textAlign(CENTER);
    text(scoreMessage, width/2, height/2 + 35);

  }

  void getUsername() {
      if (!(input == '\u0000')) {
        if (key == BACKSPACE) {
          playerName = playerName.substring(0, playerName.length()-1);
        } else {
          playerName += key;
        }
        input = '\u0000';
      }
  }

  void saveScore() {
    leaderBoard.add(playerName,points);
    leaderBoard.writeScoreFile();
    playerName = "";
    points = 0;
  }

  void drawScoreList() {
    textAlign(CENTER);
    textSize(24);
    for (int i=0 ; i < scores.size() ; i++ ) {
      text((i+1) +". " +
        scores.get(i).name + " " +
        scores.get(i).score, width/2 - 70, height/2 + i*26+100);
    }
  }

  void handleInput() {
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
        theWorld.reload();
        setLose(); 
        saveScore();
        if (selectedButton[0]) {
          gameState = GameState.PLAYING;
        }
        else if (selectedButton[1]) {
          gameState = GameState.START_SCREEN;
        }
      }
    }

    int mX = mouseX, mY = mouseY;
    if (mY >= yButton && mY <= yButton + hButton) {
      if (mX >= xPlay && mX <= xPlay + wButton) {
        cursor(HAND);
        selectedButton[0] = true;
        selectedButton[1] = false;
        if (mousePressed && mouseButton == LEFT) {
          theWorld.reload();  
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
}
