/**
 *  The startscreen is displayed on game startup and
 *  offers the user the option to start the game.
 *
 *  @author 
 *  @since  `date +%d.%m.%Y`
 */
class StartScreen {

    //The images of the background and the buttons.
    PImage startBG;
    PImage playButton;
    PImage quitButton;
    PImage creditsButton;

    boolean[] selectedButton = {true, false, false};
    boolean keyIsPressed = false;
    boolean firstLoad = true;

    Lava lava = new Lava();

    int timer = 0;
    
    //Variables for the width, height, x and y positions of the buttons
    int wButton, hButton, xPlay, xQuit, xCredits, yButton;

    /**
     *  Default constructor. Here we load the the background image.
     */
    public StartScreen() {

        startBG = loadImage("loading.png");
        playButton = loadImage("button_big_play.png");
        quitButton = loadImage("button_big_quit.png");
        creditsButton = loadImage("button_big_credits.png");  //PLACEHOLDER IMAGE

        wButton = 256;
        hButton = 128;
        xPlay = wButton;
        xQuit = width - 2 * wButton; 
        xCredits = width / 2 - wButton / 2;
        yButton = height/2;
    }

    /**
     *  Sets global var @gamestate to playing
     */
    void startGame() {
        gameState = GameState.PLAYING;
    }

    void update() {
        timer++;

        if (!keyIsPressed) {
            if (keysPressed[37]) {
                if (selectedButton[1]) {
                    cursorSound.play();
                    cursorSound.cue(0);
                    
                    selectedButton[0] = true;
                    selectedButton[1] = false;
                    selectedButton[2] = false;
                } else if (selectedButton[2]) {
                    cursorSound.play();
                    cursorSound.cue(0);
                    
                    selectedButton[0] = false;
                    selectedButton[1] = true;
                    selectedButton[2] = false;
                }
                keyIsPressed = true;
            } else if (keysPressed[39]) {
                if (selectedButton[0]) {
                    cursorSound.play();
                    cursorSound.cue(0);
                    
                    selectedButton[0] = false;
                    selectedButton[1] = true;
                    selectedButton[2] = false;
                } else if (selectedButton[1]) {
                    cursorSound.play();
                    cursorSound.cue(0);
                    
                    selectedButton[0] = false;
                    selectedButton[1] = false;
                    selectedButton[2] = true;
                }
                keyIsPressed = true;
            }

            if (key == ENTER && timer > 60 || keysPressed[90] && timer > 60) {
                if (selectedButton[0]) {
                    timer = 0;
                    startGame();
                } else if (selectedButton[1]) {
                    timer = 0;
                    gameState = GameState.CREDITS;
                } else if (selectedButton[2]) {
                    exit();
                }
            }
        } else if (!keyPressed) { keyIsPressed = false; }
    

        int mX = mouseX, mY = mouseY;
        if (mY >= yButton && mY <= yButton + hButton) {
            if (mX >= xPlay && mX <= xPlay + wButton) {
                cursor(HAND);
                selectedButton[0] = true;
                selectedButton[1] = false;
                selectedButton[2] = false;
                if (mousePressed && mouseButton == LEFT) {
                    startGame();
                }
            } else if (mX >= xCredits && mX <= xCredits + wButton) {
                cursor(HAND);
                selectedButton[0] = false;
                selectedButton[1] = true;
                selectedButton[2] = false;
                if (mousePressed && mouseButton == LEFT) {
                    gameState = GameState.CREDITS;
                }
            } else if (mX >= xQuit && mX <= xQuit + wButton) {
                cursor(HAND);
                selectedButton[0] = false;
                selectedButton[1] = false;
                selectedButton[2] = true;
                if (mousePressed && mouseButton == LEFT) {
                    exit();
                }
            } else {
                cursor(ARROW);
            }
        } else {
            cursor(ARROW); 
        }
    }

    /**
     *  Update and draw startscreen.
     */
    void updateAndDraw() {
        /* Load in the effects */  
        if (firstLoad) {  
            effecten.init();  
            firstLoad = false;   
        }  
      
        update();

        //Draws the background and the 'Play' and 'Quit' buttons
        image(startBG, 0, 0);

        effecten.draw();
        
        if (selectedButton[0]) {
            tint(255, 255);
        } else { 
            tint(50, 255); 
        }

        image(playButton, xPlay, yButton, wButton, hButton);

        if (selectedButton[1]) {
            tint(255, 255);
        } else { 
            tint(50, 255); 
        }

        image(creditsButton, xCredits, yButton, wButton, hButton);

        if (selectedButton[2]) {
            tint(255, 255);
        } else {
            tint(50, 255);
        }

        image(quitButton, xQuit, yButton, wButton, hButton);

        tint(255, 255);

        //Draws lava at the bottom of the screen
        lava.draw();
        lava.h = height - lava.screenHeight;
        fill(168, 0, 32);
        noStroke();
        rect(-1, lava.h + 31, width + 1, lava.h);
        lava.v = 1;
    
        //Draws the title of the game
        fill(255);
        textSize(64);
        textAlign(CENTER);
        text("The Great Escape", width/2, height/3);
    }
}
