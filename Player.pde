/**
 *  Player Class
 */
class Player extends Tile {

  float vxLastFrame;
  float fallingSpeed = 0.01;
  float speed = 5;
  boolean canJump = true; // can only jump is canJump == true
  boolean alive = true; // boolean that is true while the player is alive.
  boolean jumpKeyReleased = true; // checks if you released the jump key before you can jum again.
  
  ParticleSystem shoeSmoke = new ParticleSystem(0, 0);

  final int SIZE = 30;
  final float DAMPING_X = 0.8;
  final float DAMPING_Y = 0.9;
  final float JUMP = 5;
  final float MAXSPEED = 2.3;
  final float SPEED_INCREASE = 0.35;
  final float EXTRA_SPEED_FOR_SHOE_SMOKE = 0.3; // var to give the shoe particle's some extra speed.


  // Load player sprites
  PImage playerIdle = loadImage("player_idle_1.png");
  PImage playerIdleMirror = loadImage("player_idle_1_mirror.png");
  PImage playerWalking = loadImage("player_walking_1.png");
  PImage playerWalkingMirror = loadImage("player_walking_1_mirror.png");
  PImage playerJumping = loadImage("player_jump_1.png");
  PImage playerJumpingMirror = loadImage("player_jump_1_mirror.png");
  PImage playerFalling = loadImage("player_jump_2.png");
  PImage playerFallingMirror = loadImage("player_jump_2_mirror.png");
  PImage playerHit = loadImage("player_hit.png");
  PImage playerHitMirror = loadImage("player_hit_mirror.png");

  // Initialize the particle system
  // These settings are generated with the particle editor


  /**
   * The init method can be called to set a player to it's default state
   * @param  float x             x-position
   * @param  float y             y-position
   */
  void init(float x, float y) {
    super.init(x, y, SIZE, SIZE);
    particleDeclaration();
  }

  // The update method is called whenever we want to calculate the new position of a player
  // based on the keyboard input
  void update() {    
    vxLastFrame = vx; 
    vx *= DAMPING_X; // our object will move a bit slower every frame
    vy *= DAMPING_Y;

    // Velocity is changed when arrow keys are pressed 
    if (abs(vx) < MAXSPEED) {
      if (keysPressed[LEFT] || keysPressed[65]) {
        vx -= SPEED_INCREASE;
      } 
      if (keysPressed[RIGHT] || keysPressed[68]) {
        vx += SPEED_INCREASE;
      }
    }

    // vy is increased when the up key is pressed and canJump is true
    if ((keysPressed[UP] || keysPressed[88]) && canJump && jumpKeyReleased) {
      jumpKeyReleased = false; // will be true if you release the jump key. So you cant just keep pushing the jump key.
      vy -= JUMP; 
      jumpSound.play(); // play the jump sound
      jumpSound.cue(0); // sets the sound to 0 (time)
      canJump = false; // the player can no longer jump
    } else if (!(keysPressed[UP] || keysPressed[88])) {
      jumpKeyReleased = true;
    }

    // Update our position using the velocity
    x += vx * speed;
    y += vy * speed;

    // increased the falling speed and ajust the vy on the falling speed
    vy += fallingSpeed;
    fallingSpeed += 0.01;

    // when the player is falling he can't jump
    if (fallingSpeed > 0.03) canJump = false;

    // Update the image of the player on the speed
    updatePlayerImage ();
    updateParticles ();
  }

  /**
   * Called to draw the player
   */
  void draw() {
    update();
  }

  /*This function update's al particle effects*/
  void updateParticles () {
    if ((((vxLastFrame > 0) && (vx < 0)) ||((vxLastFrame < 0))
      && (vx > 0)) && canJump) {
      // if it did, emit 10 particles
      shoeSmoke.startVx = -vx; // and give them velocity based on the player velocity

      /* some extra speed for the particle's */
      if (vxLastFrame > 0) shoeSmoke.startVx += EXTRA_SPEED_FOR_SHOE_SMOKE;
      else shoeSmoke.startVx -= EXTRA_SPEED_FOR_SHOE_SMOKE;

      shoeSmoke.y0 += cameraY; // The particle's need to move down just like the rest of the world
      shoeSmoke.emit(10); // create's 10 particle's
    }

    shoeSmoke.update();

    // determine the screen coordinates of the particle system
    shoeSmoke.x0 = x+w/2;
    shoeSmoke.y0 = y+h;

    // draw the particle system
    shoeSmoke.draw();
  }

  /*This functie will update the image on the player every frame */
  void updatePlayerImage() {
    if (alive) {
      if (vx > 0.3 && canJump && (frameCount % 10) < 5) image(playerWalking, x, y);
      else if (vx > 0.3 && canJump || vx < 0.3 && !(vx < 0) && canJump) image(playerIdle, x, y);
      else if (vx < -0.3 && canJump && (frameCount % 10) < 5) image(playerWalkingMirror, x, y);
      else if (vx < -0.3 && canJump || vx > -0.3 && !(vx > 0) && canJump) image(playerIdleMirror, x, y);
      else if (vy < 0 && vx > 0 && !(canJump)) image(playerJumping, x, y);
      else if (vy < 0 && vx < 0 && !(canJump)) image(playerJumpingMirror, x, y);
      else if (vy > 0 && vx > 0 && !(canJump)) image(playerFalling, x, y);
      else if (vy > 0 && vx < 0 && !(canJump)) image(playerFallingMirror, x, y);
      else image(playerIdle, x, y);
    } else {
      if (vx > 0) image(playerHit, x, y);
      else image(playerHitMirror, x, y);
    }
  }
    void  particleDeclaration () {
    shoeSmoke.spreadFactor=0.3;
    shoeSmoke.minSpeed=1.0;
    shoeSmoke.maxSpeed=7.0;
    shoeSmoke.startVx=0.0;
    shoeSmoke.startVy=0.0;
    shoeSmoke.birthSize=1.0;
    shoeSmoke.deathSize=5.0;
    shoeSmoke.gravity=-0.01;
    shoeSmoke.birthColor=color(205, 133, 63);
    shoeSmoke.deathColor=color(139, 69, 19);
    shoeSmoke.blendMode="add";
    shoeSmoke.framesToLive=20;
   }
}

