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
  
  PImage tileImg = loadImage("tile.png");

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
}
