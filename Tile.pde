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

	/** @type {color} The default color */
	color fillColor = color(255, 255, 255);
	
	// The init method can be called to set an tile to it's default state
	void init(float newX, float newY, float newWidth, float newHeight) {
		w = newWidth;
		h = newHeight;
		
		// the position of the tile is randomly chosen to fit within the window 
		x = newX;   
		y = newY;
		
	}
	
	// Whenever you want to update the tile, call this method
	void update(){    
		// A tile doesn't move
	}
	
	// Whenever you want to draw the tile, call this method
	void draw(){
		// fillColor = color(x/32%2*255, x/32%3*255, 122);
		fill(fillColor);
		rect(x, y, w, h);
	}
	
	
}