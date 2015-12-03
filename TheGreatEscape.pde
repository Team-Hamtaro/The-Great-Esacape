/*
 * The Great Escape
 * Fasten Your Seatbelts - 2015
 * @author IG104 - Groep 2 - Team Hamtaro
 * @date 21-10-2015
 */

import ddf.minim.*;

Minim minim;
AudioPlayer backgroundMusic;
AudioPlayer jumpSound;
AudioPlayer deadSound;
AudioPlayer hitSound;

/** Viewport */
static final int SCREENX = 1376;
static final int SCREENY = 768;
final color DEFAULT_BACKGROUND = color(120, 120, 120);


/** @type {Number} Camera coordinates. */
float cameraX = 0, cameraY = 0;

GameOverScreen gameOverScreen;
PauseScreen pauseScreen;
StartScreen startScreen;
World theWorld;
GameState gameState;

PFont font;

/**
 *  Setup the Viewport and main classes.
 */
void setup() {
  minim = new Minim(this);
  // this loads mysong.wav from the data folder
  backgroundMusic = minim.loadFile("cave.mp3");
  jumpSound = minim.loadFile("Jump.wav");
  deadSound = minim.loadFile("dying.wav");
  hitSound = minim.loadFile("hit.wav");
  
  backgroundMusic.loop();
  
  size(1376, 768);
  // surface.setResizable(true);
  background(DEFAULT_BACKGROUND);
  frameRate(60); 

  startScreen = new StartScreen();
  pauseScreen = new PauseScreen();
  gameOverScreen = new GameOverScreen();
  theWorld = new World();

  gameState = GameState.START_SCREEN;

  font = loadFont("Mayan.vlw");
  textFont(font);
}


/**
 * This function is automatically called once per frame
 * by the Processing environment.
 */
void draw() {
  // Determine what level or screen to update and draw, based on the game state
  switch (gameState) {
  case START_SCREEN: 
    startScreen.updateAndDraw();
    break;
  case PLAYING: 
    theWorld.draw();
    if (keyPressed) {
      if (key == 'p' || key == 'P') {
        gameState = GameState.GAME_PAUSED;
      }
    }
    break;
  case GAME_PAUSED:
    pauseScreen.updateAndDraw();
    break;
  case GAME_OVER_LOST:
    gameOverScreen.setLose(); 
    gameOverScreen.updateAndDraw(); 
    break;
  case GAME_OVER_WON: 
    gameOverScreen.setWon();  
    gameOverScreen.updateAndDraw(); 
    break;
  default :
    break;
  }

  /** Update the Key state buffer */
  updateKeys();
}
