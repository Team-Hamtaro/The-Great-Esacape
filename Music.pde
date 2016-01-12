class Music {
  //this class controls when music plays
  
  //this boolean is needed to fix loop problem
  boolean dumbMusicFix = true;
  
  void playMusic() {
    if (dumbMusicFix == true) {
      backgroundMusic.loop();
      dumbMusicFix = false;
    }
  }
  
  void draw() {
    switch (gameState) {
      case START_SCREEN:
        pauseSound.pause();
        pauseSound.cue(0);
        
        backgroundMusic.pause();
        backgroundMusic.cue(0);
        
        dumbMusicFix = true;
        break;
      case PLAYING:
        playMusic();
        
        pauseSound.pause();
        pauseSound.cue(0);
        break;
      case GAME_PAUSED:
        pauseSound.play();
        backgroundMusic.pause();
        
        dumbMusicFix = true;
        break;
      case GAME_OVER_LOST: case GAME_OVER_WON: 
        backgroundMusic.pause();
        backgroundMusic.cue(0);
        
        dumbMusicFix = true;
        break;
      default :
        break;
     }
  }
}
