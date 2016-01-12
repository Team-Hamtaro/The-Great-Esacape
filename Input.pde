// Arrays of booleans. One for each key code
boolean [] lastFrameKeysPressed = new boolean[256];
boolean [] keysPressed = new boolean[256];

char input;

// Call this method after each update in order to remember
// which keys were pressed in the last frame
void updateKeys(){
  for (int iKey=0; iKey<keysPressed.length; iKey++)
    lastFrameKeysPressed[iKey] = keysPressed[iKey];
}

// keyPressed is a Processing specific "callback" method
// that gets called when a key is pressed
// Set the boolean at the index of "keyCode" to true 
void keyPressed() {
  keysPressed[keyCode] = true;
}

// keyPressed is a Processing specific "callback" method
// that gets called when a key is released
// Set the boolean at the index of "keyCode" to true
void keyReleased() {
  keysPressed[keyCode] = false;
}

// For player name input, no repetition
void keyTyped() {
    input = key;
}
