class World {

    ArrayList<Tile> tiles = new ArrayList<Tile>();
    Player player;

    int chunkDiff = 10; // set the difficulty
    int chunkRand = int(random(3)+1); // load a random chunk
    int chunkName = chunkDiff + chunkRand;
    
    static final int TILE_EMPTY = 0;
    static final int TILE_SOLID = 1;
    static final int TILE_START = 2;
    static final int SAW_STATIC = 3;
    static final int SAW_DYN_X = 4;
    static final int PLAYER_START = 9;
    
    static final int GRID_UNIT_SIZE = 32;
    
    static final int GRID_UNITS_WIDE = 43;
    static final int GRID_UNITS_TALL = 24;
    
    int[][] worldGrid = new int[GRID_UNITS_WIDE][GRID_UNITS_TALL];
    /**
     * Column of Rows
     * @type {Array}
     */
    int[][] curChunk = {    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,0,0,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                            {1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                            {1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                            {1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                            {1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                            };

    /**
     * Default Constructor
     * Sets up the Game Grid.
     */
    public World() {
        reload();
    }
                                            
    int worldSquareAt(PVector thisPosition) { //return what tile is at a coordinate
        float gridSpotX = thisPosition.x/GRID_UNIT_SIZE;
        float gridSpotY = thisPosition.y/GRID_UNIT_SIZE;
        return worldGrid[int(gridSpotY)][int(gridSpotX)];
    }
    
    /**
     * Load chunks into the World
     */
    void reload() {
        /** Iterate through Columns */
        for(int x = 0; x < GRID_UNITS_WIDE; x++) {
            /** Iterate through Rows */
            // println("Column: %c", x);
            for(int y = 0; y < GRID_UNITS_TALL; y++) {
                // println("Row: %r", y);
                parseTile(curChunk[y][x],x,y);
            }
        }
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
            case TILE_SOLID : {
                Tile tile = new Tile();
                tile.init(x * GRID_UNIT_SIZE,
                            y * GRID_UNIT_SIZE,
                            GRID_UNIT_SIZE,
                            GRID_UNIT_SIZE);
                tiles.add(tile);
                break;
            }
            case SAW_STATIC : {
                Saw saw = new Saw();
                saw.init(x * GRID_UNIT_SIZE,
                            y * GRID_UNIT_SIZE,
                            GRID_UNIT_SIZE,
                            GRID_UNIT_SIZE);
                tiles.add(saw);
                println("Saw");
                println("x: " + x + ", y: " + y);

                break;
            }
            case SAW_DYN_X : {
                Saw saw = new Saw();
                saw.init(x * GRID_UNIT_SIZE,
                            y * GRID_UNIT_SIZE,
                            GRID_UNIT_SIZE,
                            GRID_UNIT_SIZE);
                saw.v = 1;

                tiles.add(saw);
                println("Saw");
                println("x: " + x + ", y: " + y);

                break;
            }
            default :
                break;
        }
    }

    /**
     * Draw the updated world once per frame
     */
    void draw() {

        background(0);
        for (Tile tile : tiles) {
            tile.draw();
        }
        player.draw();

        // collision detection between player and all the tiles
        for (Tile tile : tiles) {
            // Collision detection and response typically happens after all game objects are updated
            // calculate overlap in x direction between player and tile
            float xOverlap = calculate1DOverlap(player.x, tile.x, player.w, tile.w);
            // calculate overlap in y direction between player and tile
            float yOverlap = calculate1DOverlap(player.y, tile.y, player.h, tile.h);

            // Determine whether there is a collision
            if (abs(xOverlap) > 0 && abs(yOverlap)>0)
            // Determine wchich overlap is the largest
            if (abs(xOverlap) > abs(yOverlap)) {
                player.y += yOverlap; // adjust player y - position based on overlap         
            } else {        
                player.x += xOverlap; // adjust player x - position based on overlap
            }
        }
    }
}

// Calculates the overlap of two objects in 1 dimension
// Provide the (x or y) coordinates of object0 (x0) and object1 (x1) and
// dimensions d0 and d1 (width or height) 
// returns 0 if no overlap 
float calculate1DOverlap(float p0, float p1, float d0, float d1) {
    float dl = p0+d0-p1, dr = p1+d1-p0;  
    return (dr<0 || dl<0) ? 0 : (dr >= dl) ? -dl : dr;
}