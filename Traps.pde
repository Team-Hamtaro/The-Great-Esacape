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
  final float LAVA_BURST_START_Y = 110;

  ParticleSystem sawSpark = new ParticleSystem();
  ParticleSystem lavaBurst = new ParticleSystem();
  
  int countFrames = 0; //Count frames to create a particle the 5th frame

  PImage sawImg = loadImage("saw.png");

  // The init method can be called to set an tile to it's default state
  void init(float newX, float newY, float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;

    x = newX;   
    y = newY;

    xOrigin = x;

    //Declare the particle's
    particleDeclare();
    
  }
  // Movement of the saw the distance of TRAVEL
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
    
    sawSpark.x = x;
    sawSpark.y = y + h;
    if (countFrames == 5){
    sawSpark.emit(1);
    countFrames = 0;
    }
    sawSpark.update();
    sawSpark.draw();
    
    
    lavaBurst.x = x - w + random(w * 2);
    lavaBurst.y = y + h;
    lavaBurst.update();
    lavaBurst.draw();
    
    if (y > SCREENY - LAVA_BURST_START_Y) lavaBurst.emit(5);
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
    sawSpark.framesToLive=15;
    
    lavaBurst.spreadFactor=0.4;
    lavaBurst.y = SCREENY - 50;
    lavaBurst.minSpeed=3.0;
    lavaBurst.maxSpeed=8.0;
    lavaBurst.startVx=-0.0;
    lavaBurst.startVy=-0.3;
    lavaBurst.birthSize=4.0;
    lavaBurst.deathSize=7.0;
    lavaBurst.gravity=0.01;
    lavaBurst.birthColor=color(191, 9, 9);
    lavaBurst.deathColor=color(205, 15, 15);
    lavaBurst.framesToLive=120;
  }
}
/**
 * A Game Tile
 *
 * Default Game Tiles are static and inert and are only tested for collision.
**/
class Rock {
  /** The tiles coordinates. */
  float x, y;
  /** The tiles size. */
  float w, h;

  float v = 0.01; // vertical velocity
  float counter = 0; // for counting to 7 before the next rock falls
  int times = 0; // counts the amount of times the rock fell
  
  final float RADIUS = 32;
  final float LAVA_BURST_START_Y = 140;

  ParticleSystem smallRocks = new ParticleSystem();
  ParticleSystem lavaBurst = new ParticleSystem();
    
  PImage rockImg = loadImage("rock_normal.png");

  // The init method can be called to set an tile to it's default state
  void init(float newX, float newY, float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;

    x = newX;   
    y = newY;

    particleDeclare();
  }


  void draw() {

    particleUpdate();


    //Movement of the Rock
    pushMatrix();
    translate(x, y); // Translate the image to the ellipse of the Rock
    image(rockImg, -RADIUS, -RADIUS);
    popMatrix();

    fill(0, 0, 0, 0);
    ellipse(x, y, RADIUS * 2, RADIUS * 2); // makes an invisible ellipse at the place on the location of the rock

    if ( y >= -16 ) { 
      y += v; //Movement of the Rock on the Y-axis
    }

    if (v < 11) { // Increases the fallingspeed until it hits the speed of 11 pixels per update
      v *= 1.05;
    }

    //If the Rock hits the bottom it gets teleported to the top and gets again a random X position
    if ( y >= height+RADIUS) {

      v = 0.01;
      times ++;
      counter = millis()/1000; // counts the amount of seconds
      if (counter % 7 == 0) { // if the rock is off screen for 7 seconds it will relocate the rock and reset the counter
        x = random(960);
        if( x < RADIUS){
        x = RADIUS*2;
        } else if( x > width - RADIUS){
         x = width-RADIUS*2; 
        }
        y = -h * 6;
        v = 0.01;
        counter = 0;
      }
    }
  }

  void particleUpdate() {
    smallRocks.x = x - w + random(w * 2);
    smallRocks.y = y + h;
    smallRocks.update();
    smallRocks.draw();
    
    if (y < 0 - h*2 && y > -h*6) smallRocks.emit(1);
    
    lavaBurst.x = x - w + random(w * 2);
    lavaBurst.y = y + h;
    lavaBurst.update();
    lavaBurst.draw();
    
    if (y > SCREENY - LAVA_BURST_START_Y) lavaBurst.emit(50);
   
  }

  void particleDeclare () {
    
    smallRocks.minSpeed=3.0;
    smallRocks.maxSpeed=4.0;
    smallRocks.startVx=0;
    smallRocks.startVy=1.0;
    smallRocks.birthSize=10.0;
    smallRocks.deathSize=12.0;
    smallRocks.spreadFactor = 1;
    smallRocks.gravity=0.02;
    smallRocks.birthColor=color(228, 92, 16);
    smallRocks.deathColor=color(300, 100, 32);
    smallRocks.framesToLive=60;
    
    lavaBurst.spreadFactor=0.4;
    lavaBurst.y = SCREENY - 50;
    lavaBurst.minSpeed=3.0;
    lavaBurst.maxSpeed=8.0;
    lavaBurst.startVx=-0.0;
    lavaBurst.startVy=-0.3;
    lavaBurst.birthSize=4.0;
    lavaBurst.deathSize=7.0;
    lavaBurst.gravity=0.01;
    lavaBurst.birthColor=color(191, 9, 9);
    lavaBurst.deathColor=color(205, 15, 15);
    lavaBurst.framesToLive=110;
    
  }
}



