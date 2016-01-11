class Lava extends Tile {
  
  float v, x, h, speed, maxHeight; //Starting height, maximum height and speed of the lava
  boolean max; //Checkt of maximum is bereikt
  color c; //LATER EEN IMAGE VAN MAKEN. -> Kleur van de lava
  PImage lavaImg = loadImage("lava_plat.png");
  int screenHeight = 70;
  
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

  //TEKENT DE LAVA.
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


  // CHECKT OF DE HOOGTE VAN DE LAVA DE MAXIMALE HOOGTE HEEFT BEREIKT.
  void checkHeight() {
    if (h > maxHeight) {
      h -= speed;
      max = false;
    } else { 
      max = true;
    }
  }  
}
