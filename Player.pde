/**
 *  Player Class
 *
 */
class Player extends Tile {
  
  float fallingSpeed = 0.01;
  float speed = 5;
  boolean canJump = true;
  boolean alive = true;
  final int SIZE = 30;
  final float DAMPING_X = 0.9;
  final float DAMPING_Y = 0.9;
  final float JUMP = 5;
  final float MAXSPEED = 3;
  

    PImage playerIdle = loadImage("player_idle_1.png");
    PImage playerIdleMirror = loadImage("player_idle_1_mirror.png");
    PImage playerWalking = loadImage("player_walking_1.png");
    PImage playerWalkingMirror = loadImage("player_walking_1_mirror.png");
    PImage playerJumping = loadImage("player_jump_1.png");
    PImage playerJumpingMirror = loadImage("player_jump_1_mirror.png");
    PImage playerFalling = loadImage("player_jump_2.png");
    PImage playerFallingMirror = loadImage("player_jump_2_mirror.png");


  // // The init method can be called to set a player to it's default state
  // void init(float newX, float newY, float newWidth, float newHeight) {
  //   w = newWidth;
  //   h = newHeight;
  //   x = newX;   
  //   y = newY;
  void init(float x, float y) {
    super.init(x, y, SIZE, SIZE);
  }


  // The update method is called whenever we want to calculate the new position of a player
  // based on the keyboard input
  void update() {
    vx *= DAMPING_X; // our object will move a bit slower every frame
    vy *= DAMPING_Y;

    // Velocity is changed when arrow keys are pressed 
    if (abs(vx) < MAXSPEED) {
      if (keysPressed[LEFT] || keysPressed[65]) {
        vx -= 0.15;
      } 
      if (keysPressed[RIGHT] || keysPressed[68]) {
        vx += 0.15;
      }
    } 

    // vy is increased when the up key is pressed and canJump is true
    if ((keysPressed[UP] || keysPressed[87])&& canJump) {
      vy -= JUMP; 
      jumpSound.play(); //play the jump sound
      jumpSound.cue(0); //sets the sound to 0 (time)
      canJump = false; // can no longer jump
    };

    // Update our position using the velocity
    x += vx * speed;
    y += vy * speed;

    // increased the falling speed and ajust the vy on the falling speed
    
    vy += fallingSpeed;
    fallingSpeed += 0.01;
 
    
    // when the player is falling he cant jump
    if (fallingSpeed > 0.03) canJump = false;

      // Update the image of the player on the speed
    if (vx > 0.3 && canJump && (frameCount % 10) < 5) image(playerWalking, x, y);
    else if (vx > 0.3 && canJump || vx < 0.3 && !(vx < 0) && canJump) image(playerIdle, x, y);
    else if (vx < -0.3 && canJump && (frameCount % 10) < 5) image(playerWalkingMirror, x, y);
    else if (vx < -0.3 && canJump || vx > -0.3 && !(vx > 0) && canJump) image(playerIdleMirror, x, y);
    else if (vy < 0 && vx > 0 && !(canJump)) image(playerJumping, x, y);
    else if (vy < 0 && vx < 0 && !(canJump)) image(playerJumpingMirror, x, y);
    else if (vy > 0 && vx > 0 && !(canJump)) image(playerFalling, x, y);
    else if (vy > 0 && vx < 0 && !(canJump)) image(playerFallingMirror, x, y);
    //else if (vx > 0.3 && canJump) image(playerWalking, x, y);
    //else if (vx < -0.3 && canJump) image(playerWalkingMirror, x, y);
    //else if (vx < 0.3 && !(vx < 0) && canJump) image(playerIdle, x, y);
    //else if (vx > -0.3 && !(vx > 0) && canJump) image(playerIdleMirror, x, y);
    else image(playerIdle, x, y);
  }
  //Call the draw method to draw the player
  void draw() {
    update();
  }
}



