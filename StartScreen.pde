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
        creditsButton = loadImage("button_big_credits.png"); 

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
            /*
             * If the Left arrow key is pressed a sound will play
             * And the selected button will change, depending on the button which is already selected
             */
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
            /*
             * If the Right arrow key is pressed a sound will play
             * And the selected button will change, depending on the button which is already selected
             */
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

            //If the enter key or the 'Z' key is pressed
            if (key == ENTER && timer > 60 || keysPressed[90] && timer > 60) {
                /*
                 * If the 'Play' button is selected, 
                 * The game state will be changed accordingly and the game will start.
                 */
                if (selectedButton[0]) {
                    timer = 0;
                    startGame();
                /*
                 * If the 'Credits' button is selected, 
                 * The game state will be changed accordingly and the game will start.
                 */
                } else if (selectedButton[1]) {
                    timer = 0;
                    gameState = GameState.CREDITS;
                /*
                 * If the 'Quit' button is selected, 
                 * The game will close.
                 */
                } else if (selectedButton[2]) {
                    exit();
                }
            }
        } else if (!keyPressed) { keyIsPressed = false; } //No key is pressed
    

        int mX = mouseX, mY = mouseY;   //Variables for the x and y position of the mouse

        if (mY >= yButton && mY <= yButton + hButton) {
            /*
             * If the position of the mouse cursor is over the "play" button, it will be selected.
             * If the left mouse button is pressed the game state will be changed to 'PLAYING' 
             * And you will be able to play the game
             */
            if (mX >= xPlay && mX <= xPlay + wButton) {
                cursor(HAND);
                selectedButton[0] = true;
                selectedButton[1] = false;
                selectedButton[2] = false;
                if (mousePressed && mouseButton == LEFT) {
                    startGame();
                }
            /*
             * If the position of the mouse cursor is over the "credits" button, it will be selected.
             * If the left mouse button is pressed the game state will be changed to 'CREDITS' 
             * And you will be able to see the credits
             */
            } else if (mX >= xCredits && mX <= xCredits + wButton) {
                cursor(HAND);
                selectedButton[0] = false;
                selectedButton[1] = true;
                selectedButton[2] = false;
                if (mousePressed && mouseButton == LEFT) {
                    gameState = GameState.CREDITS;
                }
            /*
             * Als de muis positie op de quit button is, wordt deze geselecteerd
             * En als de linkermuisknop ingedrukt wordt sluit de game af.
             */
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

        //Draws the background 
        image(startBG, 0, 0);

        effecten.draw();
        
        //If the play button is selected it will look normal, if not it will look darker
        //So people can tell which of the buttons is selected
        if (selectedButton[0]) {
            tint(255, 255);
        } else { 
            tint(50, 255); 
        }

        //Draws the play button
        image(playButton, xPlay, yButton, wButton, hButton);

        //If the credits button is selected it will look normal, if not it will look darker
        //So people can tell which of the buttons is selected
        if (selectedButton[1]) {
            tint(255, 255);
        } else { 
            tint(50, 255); 
        }

        //Draws the credits button
        image(creditsButton, xCredits, yButton, wButton, hButton);

        //If the quit button is selected it will look normal, if not it will look darker
        //So people can tell which of the buttons is selected
        if (selectedButton[2]) {
            tint(255, 255);
        } else {
            tint(50, 255);
        }

        //Draws the quit button
        image(quitButton, xQuit, yButton, wButton, hButton);

        //Resets the tint values
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
