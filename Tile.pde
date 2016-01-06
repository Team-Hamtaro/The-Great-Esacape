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
  
  ParticleSystem magmaFire = new ParticleSystem(0, 0);

  // The init method can be called to set an tile to it's default state
  void init(float newX, float newY, float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;

    // the position of the tile is randomly chosen to fit within the window 
    x = newX;   
    y = newY;

    //Declare the particle's
    particleDeclare();
  }

  // Whenever you want to update the tile, call this method
  void update() {    
    particleUpdate();
    // A tile doesn't move
  }

  // Whenever you want to draw the tile, call this method
  void draw() {
    image(magmaImg, x, y);
    update();
  }

  //Checks if the tile is underneath the screen
  boolean outOfScreen() {
    if (y > height) {
      return true;
    }
    return false;
  }
  void particleUpdate() {

    magmaFire.x0 = x + random(w);
    magmaFire.y0 = y + h;
    magmaFire.emit(2);
    magmaFire.update();
    magmaFire.draw();
  }

  void particleDeclare () {
    magmaFire.minSpeed=0.0;
    magmaFire.maxSpeed=1.0;
    magmaFire.startVx=0.0;
    magmaFire.startVy=-1;
    magmaFire.birthSize=6.0;
    magmaFire.deathSize=10.0;
    magmaFire.spreadFactor=0;
    magmaFire.gravity=0.08;
    magmaFire.birthColor=color(228, 34, 23);
    magmaFire.deathColor=color(158, 0, 0);
    magmaFire.blendMode="add";
    magmaFire.framesToLive=20;
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
  float dartsXM = 15;


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
    dartsX = newX;
    dartsY = newY;
  }

  void darts() {
    if(isShot) {
    pushMatrix();
    translate(dartsX, dartsY-32); // Translate the image to rect of the dart
    image(dartImg, w, h);
    popMatrix();
    dartsX -= dartsXM;
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

