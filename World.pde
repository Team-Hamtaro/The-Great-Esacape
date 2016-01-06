/**
 * The World
 */
class World {
  PImage bglayer1;
  PImage mglayer;

  ArrayList<Tile> tiles = new ArrayList<Tile>();
  ArrayList<Saw> saws = new ArrayList<Saw>();
  ArrayList<Rock> rocks = new ArrayList<Rock>();
  ArrayList<Magma> magmas = new ArrayList<Magma>();
  ArrayList<Tiki> tikis = new ArrayList<Tiki>();  
  Player player;
  Lava lava = new Lava();

  static final int TILE_EMPTY = 0;
  static final int TILE_SOLID = 1;
  static final int TILE_START = 2;
  static final int SAW_STATIC = 3;
  static final int SAW_DYN_X = 4;
  static final int ROCK_DYN = 5;
  static final int TILE_MAGMA = 6;
  static final int TILE_TIKI = 7;
  static final int PLAYER_START = 9;
  static final int GRID_UNIT_SIZE = 32;
  static final float SPEED_INCREASEMENT = 0.05;

  static final int GRID_UNITS_WIDE = 43;
  static final int GRID_UNITS_TALL = 24;
  static final float START_LAVA_SPEED = 1.2;
  static final float MAX_LAVA_SPEED = 1.4;

  final int TOTAL_CHUNKS = 30; //Change to equal the total amount of chunks, excluding 'startChunk'

  int[][] worldGrid = new int[GRID_UNITS_WIDE][GRID_UNITS_TALL];

  float chunkLoadTimer = height;
  int randomChunk = 0; 
  
  ArrayList<int[][]> chunkList = new ArrayList<int[][]>();
  int chunkDiff = 1;

  float cameraY = 0;
  float playerStartY;
  int playerScore = 0;
  int increaseSpeedAtScore = 100;
  float test = 0; // zorgt ervoor dat de score goed werkt.


  /**
   * Default Constructor
   * Sets up the Game Grid.
   */
  public World() {
    mglayer = loadImage("bglayer2.png");
    bglayer1 = loadImage("bglayer1.png");

    reload();
  }
  // Wordt dit stuk wel gebruikt? <<<<<
  /*
  int worldSquareAt(PVector thisPosition) { //return what tile is at a coordinate
   float gridSpotX = thisPosition.x/GRID_UNIT_SIZE;
   float gridSpotY = thisPosition.y/GRID_UNIT_SIZE;
   return worldGrid[int(gridSpotY)][int(gridSpotX)];
   }
   */
  /**
   * Load chunks into the World
   */
  void reload() {  
    saws.removeAll (saws); // Remove al saws
    tiles.removeAll(tiles); // Remove all tiles
    rocks.removeAll (rocks);// Remove all rocks
    magmas.removeAll (magmas);// Remove all magma tiles
    tikis.removeAll (tikis); // Remove all tiki tiles
  
    chunkDiff = 1;
    chunkLoadTimer = height;
    test = 0;

    cameraY = START_LAVA_SPEED; // Lava speed will be slow again at the start of the game.

    // Resets the dead event start position, so it will play again if you die.
    deadEventStart = true;
    aboveTheLavaAgain = false;

    /** Iterate through Columns */
    for (int x = 0; x < GRID_UNITS_WIDE; x++) {
      /** Iterate through Rows */
      // println("Column: %c", x);
      for (int y = 0; y < GRID_UNITS_TALL; y++) {
        // println("Row: %r", y);
        parseTile(startChunk[y][x], x, y);
      }
    }

    playerScore = 0;
    playerStartY =  player.y; // reference value for highscore

    lava.init();
    tiles.add(lava);
  }

  /**
   * Instantiates a Tile object at giver grid location
   * and adds it to the tiles arrayList.
   * @param  int type          The type of tile to create
   * @param  int x             X Position in the World Grid
   * @param  int y             Y Position in the World Grid
   */
  void parseTile(int type, int x, int y) {
    switch (type) {
    case PLAYER_START :
      Player player = new Player();
      player.init(x * GRID_UNIT_SIZE, 
      y * GRID_UNIT_SIZE);
      this.player = player;
      println("Player");
      println("x: " + x + ", y: " + y);

      break;    
    case TILE_SOLID : 
      {
        Tile tile = new Tile();
        tile.init(x * GRID_UNIT_SIZE, 
        y * GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE);
        tiles.add(tile);
        break;
      }
    case SAW_STATIC : 
      {
        Saw saw = new Saw();
        saw.init(x * GRID_UNIT_SIZE, 
        y * GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE);
        saws.add(saw);

        break;
      }
    case SAW_DYN_X : 
      {
        Saw saw = new Saw();
        saw.init(x * GRID_UNIT_SIZE, 
        y * GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE);
        saw.v = 1;
        saws.add(saw);

        break;
      }
       case ROCK_DYN : 
      {
        Rock rock = new Rock();
        rock.init(x * GRID_UNIT_SIZE, 
        y * GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE);
        rocks.add(rock);

        break;
      }
    case TILE_MAGMA :
      {
        Magma magma = new Magma();
        magma.init(x * GRID_UNIT_SIZE, 
        y * GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE);
        magmas.add(magma);
        break;
      }
      case TILE_TIKI :
      {
        Tiki tiki = new Tiki();
        tiki.init(x * GRID_UNIT_SIZE, 
        y * GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE, 
        GRID_UNIT_SIZE);
        tikis.add(tiki);
       break; 
      }
    default :
      break;
    }
  }

  /**
   * Load a new chunk when the current chunk is at the bottom of the screen.
   */
   void loadChunks() {
    cameraY += SPEED_INCREASEMENT; // increase the speed of the object moving down.
    
    int activeChunks = chunkList.size();
    println(chunkList.size());
    randomChunk = (int)random(activeChunks);

    /** Iterate through Columns */
    for (int x = 0; x < GRID_UNITS_WIDE; x++) {
      /** Iterate through Rows */
      for (int y = 0; y < GRID_UNITS_TALL; y++) {
        switch(randomChunk) {
        case 0:
          parseTile(chunkList.get(0)[y][x], x, y-24);
          break;
        case 1:
          parseTile(chunkList.get(1)[y][x], x, y-24);
          break;
        case 2:
          parseTile(chunkList.get(2)[y][x], x, y-24);
          break;
        case 3:
          parseTile(chunkList.get(3)[y][x], x, y-24);
          break;
        case 4:
          parseTile(chunkList.get(4)[y][x], x, y-24);
          break;
        case 5:
          parseTile(chunkList.get(5)[y][x], x, y-24);
          break;
        case 6:
          parseTile(chunkList.get(6)[y][x], x, y-24);
          break;
        case 7:
          parseTile(chunkList.get(7)[y][x], x, y-24);
          break;
        case 8:
          parseTile(chunkList.get(8)[y][x], x, y-24);
          break;
        case 9:
          parseTile(chunkList.get(9)[y][x], x, y-24);
          break;
        case 10:
          parseTile(chunk11[y][x], x, y-24);
          break;
        case 11:
          parseTile(chunk12[y][x], x, y-24);
          break;
        case 12:
          parseTile(chunk13[y][x], x, y-24);
          break;
        case 13:
          parseTile(chunk14[y][x], x, y-24);
          break;
        case 14:
          parseTile(chunk15[y][x], x, y-24);
          break;
        case 15:
          parseTile(chunk16[y][x], x, y-24);
          break;
        case 16:
          parseTile(chunk17[y][x], x, y-24);
          break;
        case 17:
          parseTile(chunk18[y][x], x, y-24);
          break;
        case 18:
          parseTile(chunk19[y][x], x, y-24);
          break;
        case 19:
          parseTile(chunk20[y][x], x, y-24);
          break;
        case 20:
          parseTile(chunk21[y][x], x, y-24);
          break;
        case 21:
          parseTile(chunk22[y][x], x, y-24);
          break;
        case 22:
          parseTile(chunk23[y][x], x, y-24);
          break;
        case 23:
          parseTile(chunk24[y][x], x, y-24);
          break;
        case 24:
          parseTile(chunk25[y][x], x, y-24);
          break;
        case 25:
          parseTile(chunk26[y][x], x, y-24);
          break;
        case 26:
          parseTile(chunk27[y][x], x, y-24);
          break;
        case 27:
          parseTile(chunk28[y][x], x, y-24);
          break;
        case 28:
          parseTile(chunk29[y][x], x, y-24);
          break;
        case 29:
          parseTile(chunk30[y][x], x, y-24);
          break;
        }
      }
    }
  }

  void setScore() {
    int score =  (int)(playerStartY - player.y + test);
    if (score > playerScore) playerScore = score;
  }

  /**
   * Draw the updated world once per frame
   */
  void draw() {
    setScore();

    background(0);
    //image(mglayer, 0, (test * 0.1));
    //image(bglayer1, 0, 0); 

    for (Tile tile : tiles) {
      tile.draw();
      if (lava.max) { 
        tile.y += cameraY;
      }
    }
    for (Saw saw : saws) {
      saw.draw();
      if (lava.max) { 
        saw.y += cameraY;
      }
    }
    for (Rock rock : rocks) {
      rock.draw();
      if (lava.max) { 
        rock.y += cameraY;
      }
    }
    for (Magma magma : magmas) {
      magma.draw();
      if (lava.max) {
        magma.y += cameraY;
      }
    }
    for (Tiki tiki : tikis) {
     tiki.draw();
    if(lava.max) {
     tiki.y += cameraY;
     tiki.dartsY += cameraY;
    } 
    }

    for (int i = 0; i < tiles.size (); i++) {
      if (tiles.get(i).outOfScreen()) {
        tiles.remove(i);
      }
    }

    for (int i = 0; i < saws.size (); i++) {
      if (saws.get(i).outOfScreen()) {
        saws.remove(i);
      }
    }
    
    for (int i = 0; i < rocks.size (); i++) {
      if (rocks.get(i).times > frameRate * 6) {
        rocks.remove(i);
      }
    }

    for (int i = 0; i < magmas.size (); i++) {
      if (magmas.get(i).outOfScreen()) {
        magmas.remove(i);
      }
    }
    
    for (int i = 0; i < tikis.size (); i++){
     if(tikis.get(i).outOfScreen()) {
      tikis.remove(i);
     } 
    }
    
    if (chunkLoadTimer > height) {
      loadChunks(); 
      chunkLoadTimer = 0;
    }

 // collision detection between player and all the saws
    for (Saw saw : saws) {
      boolean sawOverlap = rectBall(player.x, player.y, player.SIZE, player.SIZE, saw.x-16, saw.y-16, saw.RADIUS * 2);
      if (sawOverlap == true) {
        player.alive = false;
        break;
      }
    }
    // colision detection between player and all the rocks
    for (Rock rock : rocks) {
      boolean rockOverlap = rectBall(player.x, player.y, player.SIZE, player.SIZE, rock.x-16, rock.y-16, rock.RADIUS * 2);
      System.out.println(rockOverlap);
      if (rockOverlap == true) {
        player.alive = false;
        break;
      }
    }
    // collision detection between player and all magma tiles
    for (Magma magma : magmas) {
      boolean magmaOverlap = rectRect(player.x, player.y, player.SIZE, player.SIZE, magma.x, magma.y, magma.w, magma.h);
      if (magmaOverlap == true) {
        player.alive = false;
        break;
      }
    }
    
    // if the player is around the same height the tiki totem shoots a dart
    for (Tiki tiki : tikis) {
      if(tiki.isShot == false) {
     if(abs(tiki.y - player.y) < 96 || tiki.isShot ) {
       tiki.isShot = true;
    }
      }
      // movement of the dart and collision detection of the dart and the player
      if( tiki.isShot == true){
       tiki.darts();
       boolean dartOverlap = rectRect(player.x, player.y, player.SIZE, player.SIZE, tiki.dartsX+32, tiki.dartsY, tiki.w, tiki.h);
      System.out.println(dartOverlap);
      if (dartOverlap == true) {
        player.alive = false;
      }
      }
    if(tiki.dartsX < 0) {
     tiki.isShot = false; 
    }
    }
    
    // collision detection between player and all the tiles
    if (player.alive) {
      for (Tile tile : tiles) {
        if (abs(tile.x - player.x) < 50 && abs(tile.y - player.y) < 50) { // only checks is a tile is close to the player
          // Collision detection and response typically happens after all game objects are updated
          // calculate overlap in x direction between player and tile
          float xOverlap = calculate1DOverlap(player.x, tile.x, player.w, tile.w);

          float playeryAndSpeed = player.y  + (player.vy * player.speed);
          // calculate overlap in y direction between player + speed and tile 
          float yOverlap = calculate1DOverlap(playeryAndSpeed, tile.y, player.h, tile.h);


          // used for checking if the block is a sideTile. without this the player will glitch in the ground!
          if (player.y + player.SIZE > tile.y + (tile.h/3) && player.y < tile.y + tile.h - (tile.h/3)) {
            tile.sideTile = true;
          } else {
            tile.sideTile = false;
          }

          // Determine whether there is a collision
          if (abs(xOverlap) > 0 && abs(yOverlap)>0) {
            // Determine wchich overlap is the largest
            if (abs(xOverlap) > abs(yOverlap)) {
              // adjust player y - position based on overlap 
              if (yOverlap < 0) { // block under the player
                player.y += yOverlap + (player.vy * player.speed) ; 
                player.canJump = true; // making able to jump again.
                player.fallingSpeed = 0.01; // set the falling speed to zero.
                player.vy = 0;
              }
              if (yOverlap > 0 + (player.vy * player.speed)) { // block is above the player

                //player.vy = - player.vy; // player vy becomes negative vx when you hit a block above.
                player.y += yOverlap; // player will bounce of.
                player.vy = -player.vy/2;
              }
            } else {     // block is left or right
              player.x += xOverlap; // adjust player x - position based on overlap
              if (tile.sideTile) {
                player.vx = 0; // player vx becomes negative vx when you hit a block left or right
              }
            }
          }
        }
      }
    } else { 
      deadEvent();
      gameOverScreen.points = playerScore;
    }
    player.draw();
    lava.draw();

    if (lava.max) {
      chunkLoadTimer += cameraY;
      player.y += cameraY;
      test += cameraY;
    }

    if (player.y >= lava.h + 32) {
      player.alive = false;
    }

    switch(chunkDiff) {
      case 1:
        chunkList.clear();
        chunkList.add(chunk01);
        chunkList.add(chunk02);
        chunkList.add(chunk03);
        break;
      case 2:
        chunkList.clear();
        chunkList.add(chunk04);
        chunkList.add(chunk05);
        chunkList.add(chunk06);
        break;
      case 3:
        chunkList.clear();
        chunkList.add(chunk07);
        chunkList.add(chunk08);
        chunkList.add(chunk09);
        break;
      default:
        chunkList.clear();
        break;
    }

    if (cameraY >= MAX_LAVA_SPEED) {
      if (chunkDiff < 3) {
        chunkDiff++;
        println("new chunk difficulty " + chunkDiff);
        cameraY = START_LAVA_SPEED;
      }
    }
  }
}

