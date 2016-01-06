/**
 * A Game Tile
 *
 * Default Game Tiles are static and inert and are only tested for collision.
 */
class Rock {
  /** The tiles coordinates. */
  float x, y;
  /** The tiles size. */
  float w, h;

  float v = 0.01;
  float counter = 0; // for counting to 7 before the next rock falls
  int times = 0; // counts the amount of times the rock fell
  final float RADIUS = 32;

  ParticleSystem smallRocks = new ParticleSystem(0, 0);
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

    if ( y >= 16 ) { 
      y += v; //Movement of the Rock on the Y-axis
    }

    if (v < 15) { // makes it not fall any faster than 15 per frame
      v *= 1.05;
    }

    //If the Rock hits the bottom it gets teleported to the top and gets again a random X position
    if ( y >= height+RADIUS) {

      v = 0.01;
      times ++;
      counter = millis()/1000; // counts the amount of seconds
      if (counter % 7 == 0) { // if the rock is off screen for 7 seconds it will relocate the rock and reset the counter
        x = random(960);
        y = -h * 6;
        v = 0.01;
        counter = 0;
      }
    }
  }

  void particleUpdate() {
    smallRocks.x0 = x - w + random(w * 2);
    smallRocks.y0 = y + h;
    smallRocks.update();
    smallRocks.draw();
    
    if (y < 0 - h*2 && y > -h*6) {
      smallRocks.emit(1);
    }
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
    smallRocks.blendMode="add";
    smallRocks.framesToLive=60;
    
  }
}
