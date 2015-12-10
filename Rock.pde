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
  
  
  PImage rockImg = loadImage("rock_normal.png");

  // The init method can be called to set an tile to it's default state
  void init(float newX, float newY, float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;

    x = newX;   
    y = newY;
    
  }


  void draw() {

    //Movement of the Rock
    pushMatrix();
    translate(x, y); // Translate the image to the ellipse of the Rock
    image(rockImg, -RADIUS, -RADIUS);
    popMatrix();

    fill(0,0,0,0);
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
        y = -24;
        v = 0.01;
        counter = 0;
      }
    }
  }
}

