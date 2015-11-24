/**
 * This class extends the Tile object to draw an animated saw trap. 
 */
class Saw extends Tile {
    
    final float RADIUS = 32; //de grootte van de zaag
    final float TRAVEL = RADIUS * 3; // distance the saw will travel
    PImage sawImg = loadImage("saw.png");

    public float v; // snelheid
    float xOrigin;
    float angle; // het draaien van de image van de zaag en telkens er graden erbij doen


    void init(float x, float y, float width, float height) {
        super.init(x,y,width,height);
        xOrigin = x;
    }

    void oscillate() {
        if (abs(xOrigin-x) >= TRAVEL) v=-v;
        x += v;
    }

    /**
     * Draw the saw rotating on every frame.
     */
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
    }
}