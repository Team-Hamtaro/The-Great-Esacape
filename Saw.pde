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
  
  ParticleSystem sawSpark = new ParticleSystem(0, 0);
  int countFrames = 0; //Count frames to create a particle the 5th frame
  
  PImage sawImg = loadImage("saw.png");

  // The init method can be called to set an tile to it's default state
  void init(float newX, float newY, float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;

    x = newX;   
    y = newY;
    
    xOrigin = x;
    
    particleDeclare();
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
    particleUpdate();
  }

  //Checks if the Saw is underneath the screen
  boolean outOfScreen() {
    if (y > height) {
      return true;
    }
    return false;
  }  
  
    void particleUpdate() {
    countFrames +=1;
    
    sawSpark.x0 = x;
    sawSpark.y0 = y + h;
    if (countFrames == 5){
    sawSpark.emit(1);
    countFrames = 0;
    }
    sawSpark.update();
    sawSpark.draw();
  }

  void particleDeclare () {
    sawSpark.minSpeed=1.0;
    sawSpark.maxSpeed=2.0;
    sawSpark.startVx=-3.0;
    sawSpark.startVy=-0.5;
    sawSpark.birthSize=4.0;
    sawSpark.deathSize=8.0;
    sawSpark.gravity=0.08;
    sawSpark.birthColor=color(191, 9, 9);
    sawSpark.deathColor=color(205,15,15);
    sawSpark.blendMode="add";
    sawSpark.framesToLive=15;
  }
}


