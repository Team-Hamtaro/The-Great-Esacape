/**
 * A Game Tile
 *
 * Default Game Tiles are static and inert and are only tested for collision.
 */
class Tile {
  /** The tiles coordinates. */
  float x, y;
  /** The tiles size. */
  float w, h;
  /** Velocity (also direction) */
  float vx, vy;

  // for the left or right check in World
  boolean sideTile;

  PImage tileImg = loadImage("tile0.png");

  // The init method can be called to set an tile to it's default state
  void init(float newX, float newY, float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;

    // the position of the tile is randomly chosen to fit within the window 
    x = newX;   
    y = newY;
  }

  // Whenever you want to update the tile, call this method
  void update() {    
    // A tile doesn't move
  }

  // Whenever you want to draw the tile, call this method
  void draw() {
    image(tileImg, x, y);
  }

  //Checks if the tile is underneath the screen
  boolean outOfScreen() {
    if (y > height) {
      return true;
    }
    return false;
  }
}

class Magma {
  /** The tiles coordinates. */
  float x, y;
  /** The tiles size. */
  float w, h;
  /** Velocity (also direction) */
  float vx, vy;

  // for the left or right check in World

  PImage magmaImg = loadImage("lava_tile.png");

  // The init method can be called to set an tile to it's default state
  void init(float newX, float newY, float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;

    // the position of the tile is randomly chosen to fit within the window 
    x = newX;   
    y = newY;
  }

  // Whenever you want to update the tile, call this method
  void update() {    
    // A tile doesn't move
  }

  // Whenever you want to draw the tile, call this method
  void draw() {
    image(magmaImg, x, y);
  }

  //Checks if the tile is underneath the screen
  boolean outOfScreen() {
    if (y > height) {
      return true;
    }
    return false;
  }
}

class Tiki {
  /** The tiles coordinates. */
  float x, y;
  /** The tiles size. */
  float w, h;
  /** Velocity (also direction) */
  float vx, vy;

  boolean isShot = false;
  float dartsX = x;
  float dartsY = y;
  float dartsXM = 20;

  // for the left or right check in World

  PImage tikiImg = loadImage("tiki_tile.png");
  PImage dartImg = loadImage("tiki_dart.png");

  // The init method can be called to set an tile to it's default state
  void init(float newX, float newY, float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;

    // the position of the tile is randomly chosen to fit within the window 
    x = newX;   
    y = newY;
  }

  void darts() {
    if(isShot) {
    pushMatrix();
    translate(dartsX, dartsY); // Translate the image to the ellipse of the Rock
    image(dartImg, w, h);
    popMatrix();
    rect(dartsX, dartsY, w, h);
    dartsX += dartsXM;
  }
  }
  // Whenever you want to update the tile, call this method
  void update() {    
    // A tile doesn't move
}
  // Whenever you want to draw the tile, call this method
  void draw() {
    image(tikiImg, x, y);
  }

  //Checks if the tile is underneath the screen
  boolean outOfScreen() {
    if (y > height) {
      return true;
    }
    return false;
  }
}

