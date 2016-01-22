class Lava extends Tile {
  
  float v,			//De snelheid waarmee de lava over de x-as beweegt
  		x,			//De x-positie van de lava
  		h, 			//De hoogte van de lava
  		speed,	 	//De snelheid waarmee de lava omhoog gaat, voordat het level naar beneden beweegt
  		maxHeight;	//De maximale hoogte van de lava voordat het level naar beneden beweegt
  
  boolean max; 	//Returns true als de maximale hoogte van de lava is bereikt
  color c;		//De kleur van de lava
  
  PImage lavaImg = loadImage("lava_plat.png");	//laad de lavasprite in

  int screenHeight = 70;
  
  /*
   * Initialiseert alle variabelen
   */
  void init() {
    h = height;  
    maxHeight = height / 1.1;
    speed = 0.5;
    v = 1; 
    x = 0;
    
    super.init(0, h, width, h);

    max = false;   
    c = color(168, 0, 32);
  }

  /*
   * Tekent de lava en laat het 'animeren' door de x-positie steeds naar links op te schuiven
   * en zodra het buiten het scherm is aan de rechterkant de plaatsen
   */
  void draw() {
    checkHeight();
  
    fill(c);
    noStroke();
    rect(-1, h+31, width + 1, h+31);

    for (int i = 0; i < 44; i ++) {
      image(lavaImg, x + i*32, h);
    }
    
    x -= v;
    if (x < -31) {
      x += 32;
    }
  }


  /*
   * Kijkt of de hoogte al het maximale punt heeft bereikt, zo niet stijgt de lava
   */
  void checkHeight() {
    if (h > maxHeight) {
      h -= speed;
      max = false;
    } else { 
      max = true;
    }
  }  
}
