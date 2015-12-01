/**
 * The World
 */
class World {

  ArrayList<Tile> tiles = new ArrayList<Tile>();
  ArrayList<Saw> saws = new ArrayList<Saw>();
  Player player;
  Lava lava = new Lava();

  static final int TILE_EMPTY = 0;
  static final int TILE_SOLID = 1;
  static final int TILE_START = 2;
  static final int SAW_STATIC = 3;
  static final int SAW_DYN_X = 4;
  static final int PLAYER_START = 9;
  static final int GRID_UNIT_SIZE = 32;

  static final int GRID_UNITS_WIDE = 43;
  static final int GRID_UNITS_TALL = 24;
  static final float START_LAVA_SPEED = 1.6;

  final int TOTAL_CHUNKS = 10; //Change to equal the total amount of chunks, excluding 'startChunk'

  int[][] worldGrid = new int[GRID_UNITS_WIDE][GRID_UNITS_TALL];

  float loadNewChunk = height;
  int randomChunk = 0; 

  float cameraY = 0;
  float playerStartY;
  int playerScore = 0;


  /**
   * Default Constructor
   * Sets up the Game Grid.
   */
  public World() {
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
    loadNewChunk = height;

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
        println("Saw");
        println("x: " + x + ", y: " + y);

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
        println("Saw");
        println("x: " + x + ", y: " + y);

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
    randomChunk = (int)random(TOTAL_CHUNKS);
    //println("Loaded: chunk" + (randomChunk+1));

    /** Iterate through Columns */
    for (int x = 0; x < GRID_UNITS_WIDE; x++) {
      /** Iterate through Rows */
      for (int y = 0; y < GRID_UNITS_TALL; y++) {
        switch(randomChunk) {
        case 0:
          parseTile(chunk01[y][x], x, y-24);
          break;
        case 1:
          parseTile(chunk02[y][x], x, y-24);
          break;
        case 2:
          parseTile(chunk03[y][x], x, y-24);
          break;
        case 3:
          parseTile(chunk04[y][x], x, y-24);
          break;
        case 4:
          parseTile(chunk05[y][x], x, y-24);
          break;
        case 5:
          parseTile(chunk06[y][x], x, y-24);
          break;
        case 6:
          parseTile(chunk07[y][x], x, y-24);
          break;
        case 7:
          parseTile(chunk08[y][x], x, y-24);
          break;
        case 8:
          parseTile(chunk09[y][x], x, y-24);
          break;
        }
      }
    }
  }

  void setScore(){
    int score =  (int)(playerStartY - player.y + cameraY);
    if (score > playerScore) playerScore = score;
    println(playerScore);
  }

  /**
   * Draw the updated world once per frame
   */
  void draw() {

    setScore();

    background(0); 
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

    if (loadNewChunk > height) {
      loadChunks(); 
      loadNewChunk = 0;
    }

    // collision detection between player and all the saws
    for (Saw saw : saws) {
      boolean sawOverlap = rectBall(player.x, player.y, player.SIZE, player.SIZE, saw.x, saw.y, saw.RADIUS * 2);
      System.out.println(sawOverlap);
      if (sawOverlap == true) {
        player.alive = false;
        break;
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
              }
            } else {     // block is left or right
              player.x += xOverlap; // adjust player x - position based on overlap
              if (tile.sideTile) {
                player.vx = -player.vx; // player vx becomes negative vx when you hit a block left or right
              }
            }
          }
        }
      }
    }  else { 
    deadEvent();
    gameOverScreen.points = playerScore;
    }
    player.draw();
    lava.draw();

    if (lava.max) {
      loadNewChunk += cameraY;
      player.y += cameraY;
    }

    if (player.y >= lava.h + 32) {
      player.alive = false;
    }
  }
}

