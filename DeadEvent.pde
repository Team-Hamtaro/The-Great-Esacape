boolean deadEventStart = true;
boolean aboveTheLavaAgain = false;
final float DEAD_EVENT_VY = -0.15;
final float DEAD_EVENT_END = -60;

public void deadEvent() {
  // activate's only the first frame when the player is game over.
  if (deadEventStart == true) {
    theWorld.cameraY = 0;
    theWorld.player.fallingSpeed = 0;
    theWorld.player.vy = 0;
    theWorld.player.vy -= theWorld.player.JUMP;
    deadEventStart = false;
    
    deadSound.play(); //play the dead sound
    deadSound.cue(0); //sets the sound to 0 (time)
  }
  
  // Check if player is above the lava again. 
  if (theWorld.player.y < theWorld.lava.h + 32 && !(aboveTheLavaAgain)) aboveTheLavaAgain = true;
  
  // Check is player is under the lava again.
  if (theWorld.player.y >= theWorld.lava.h + 32 && aboveTheLavaAgain) {
    gameState = GameState.GAME_OVER_LOST;
    theWorld.reload();  
  }
}

