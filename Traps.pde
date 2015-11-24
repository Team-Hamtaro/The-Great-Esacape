/**
/**
 * This class extends the Tile object to draw an animated saw trap. 
 *//*
class Saw {
  final float RADIUS = 32; //de grootte van de zaag
  final float TRAVEL = RADIUS * 3; // distance the saw will travel
  PImage sawImg = loadImage("saw.png");

  public float v; // snelheid
  float xOrigin;
  float angle; // het draaien van de image van de zaag en telkens er graden erbij doen

  /** The tiles coordinates. */ 
  //float x, y;
  /** The tiles size. **/
  /*float w, h;


  void init(float newX, float newY, float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;

    // the position of the tile is randomly chosen to fit within the window 
    x = newX;   
    y = newY;
  }

  void oscillate() {
    if (abs(xOrigin-x) >= TRAVEL) v=-v;
    x += v;
  }
*/
  /**
   * Draw the saw rotating on every frame.
   */
   /*
  void draw() {
    //println("x: x, y: %y",x, y);

    angle +=2; // Increment rotation

    pushMatrix();
    // move the origin to the pivot point
    translate(x, y); 

    // then pivot the grid
    rotate(angle);

    // and draw the image at the origin
    image(sawImg, -RADIUS, -RADIUS);
    popMatrix();

    oscillate();
  }*/
//} 
