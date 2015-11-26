/**
 * A Game Tile
 *
 * Default Game Tiles are static and inert and are only tested for collision.
 */
class Saw {
  /** The tiles coordinates. */
  float x, y;
  /** The tiles size. */
  float w, h;
  
  float angle = 0;
  float xOrigin;
  float v;
  float TRAVEL = 64;
  
  final float RADIUS = 32;
  
  
  PImage sawImg = loadImage("saw.png");

  // The init method can be called to set an tile to it's default state
  void init(float newX, float newY, float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;

    x = newX;   
    y = newY;
    
    xOrigin = x;
  }

  void oscillate() {
    
    if (abs(xOrigin-x) >= TRAVEL) v=-v;
    x += v;
     
  }

  // Whenever you want to draw the tile, call this method
  void draw() {
    angle +=0.1; // Increment rotation

    pushMatrix();
    // move the origin to the pivot point
    translate(x, y); 

    // then pivot the grid
    rotate(angle);

    // and draw the image at the origin
    image(sawImg, -RADIUS, -RADIUS);
    popMatrix();
    
    oscillate();
  }

  //Checks if the Saw is underneath the screen
  boolean outOfScreen() {
    if (y > height) {
      return true;
    }
    return false;
  }
}


