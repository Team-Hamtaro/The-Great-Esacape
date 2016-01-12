class Credits {
  float x = width / 2;
  float y = 600;
  float z = -200;
  int offset = 40;
  int test = 1;
  int color1, color2, color3, color4, color5, color6;
  int framesUntilEffectChanges = 20;
  int timer = 0;
  boolean isInitialized = false;

  ParticleSystem stars = new ParticleSystem(0, 0);
 
   

  void update() {
    timer ++;

    if (!isInitialized) {
      y = 600; 
      z = -200;
      
      particleDeclare ();
      backgroundMusic.close();
      backgroundMusic = minim.loadFile("Rhinoceros.mp3");
      backgroundMusic.loop();

      isInitialized = true;
    }
  }

  void draw() {
    update();

    background(0);
    particleUpdate();
    rotateX(PI/4);

    fill(255, 200, 100);
    
    textAlign(CENTER);

    textSize(30);
    text("A long time ago,", x, y, z);
    text("In a Galaxy far far away...", x, y + offset, z);
    text("6 Hamsters started programming...", x, y + 2 * offset, z);
    text("Sadly, 2 Died...", x, y + 3 * offset, z);
    text("After a lot of mourning,", x, y + 4 * offset, z);

    textSize(48);
    text("Team Hamtaro", x, y + 6 * offset, z);

    textSize(30);
    text("made...", x, y + 7 * offset, z);

    textSize(40);
    text("The Great Escape!", x, y + 8 * offset, z);


    textSize(48);
    text("Credits", x, y + 12 * offset, z);

    textSize(40);
    text("Project Lead:", x, y + 14 * offset, z);
    text("Graphics & Sound:", x, y + 17 * offset, z);
    text("Programmers:", x, y + 20 * offset, z);
    text("Catering:", x, y + 26 * offset, z);
    text("Voice Acting:", x, y + 30 * offset, z);
    text("Playtesters:", x, y + 33 * offset, z);
    text("Production Babies:", x, y + 42 * offset, z);
    text("Special Thanks:", x, y + 48 * offset, z);

    textSize(28);
    text("Rik Langeveld", x, y + 15 * offset, z);	
    text("Chris Toonen", x, y + 18 * offset, z);
    text("Aleksej Horvat", x, y + 21 * offset, z);
    text("Kay van der Lans", x, y + 22 * offset, z);
    text("Patrick Tibboel", x, y + 23 * offset, z);
    text("Rik Langeveld", x, y + 24 * offset, z);
    text("Mark Rutte", x, y + 27 * offset, z);
    text("Barack Obama", x, y + 28 * offset, z);
    text("Morgan Freeman", x, y + 31 * offset, z);
    text("Anne van Winzum", x, y + 34 * offset, z);
    text("Koen Langeveld", x, y + 35 * offset, z);
    text("Mark Ravensbergen", x, y + 36 * offset, z);
    text("Dieles van Rossum", x, y + 37 * offset, z);
    text("Jelmer Wiegel", x, y + 38 * offset, z);
    text("Roel van der Lans", x, y + 39 * offset, z);
    text("Justin van der Lans", x, y + 40 * offset, z);
    text("Reggie Schildmeijer", x, y + 43 * offset, z);
    text("Stip", x, y + 44 * offset, z);
    text("Mr. Bauer", x, y + 45 * offset, z);
    text("Alexander Mulder", x, y + 46 * offset, z);
    text("Die vrouw van de slager die me altijd plakjes worst gaf. \n Dankjewel, ik vond ze echt heel lekker!", x, y + 49 * offset, z);
    text("Irene Overtoom", x, y + 51 * offset, z);
    text("Familie's van alle hamsters", x, y + 52 * offset, z);
    text("Remy Kooring", x, y + 53 * offset, z);
    text("Sunderdota", x, y + 54 * offset, z);
    text("Luna Chenango Cordelia", x, y + 55 * offset, z);
    text("Will Verdrag", x, y + 56 * offset, z);
    text("Kinder chocolade", x, y + 57 * offset, z);
    text("Koffie", x, y + 58 * offset, z);
    text("Zonder jullie hadden we dit nooit gekunt!", x, y + 59 * offset, z);

    y--;

    if (keyPressed && timer > 60) {
      backgroundMusic.close();
      backgroundMusic = minim.loadFile("cave.mp3");
      backgroundMusic.loop();

      isInitialized = false;
      timer = 0;

      gameState = GameState.START_SCREEN;
    }
  }
      void particleUpdate() {
      
      framesUntilEffectChanges++;
      stars.x0 = random(SCREENX);
      stars.y0 = random(SCREENY);
       if (framesUntilEffectChanges >= 15) {
      color1 = (int)random(255);
      color2 = (int)random(255);
      color3 = (int)random(255);
      color4 = (int)random(255);
      color5 = (int)random(255);
      color6 = (int)random(255);
      stars.birthColor=color(color1, color2, color3);
      stars.deathColor=color(color4, color5, color6);
      stars.birthSize=(int)random(50);
      stars.deathSize=(int)random(50);
      framesUntilEffectChanges = 0;
      }
      stars.minSpeed = (int)random(2);
      stars.maxSpeed = (int)random(3);

      stars.spreadFactor=(int)random(3);
      stars.startVx=((int)random(4))-2;
      stars.startVy=((int)random(4))-2;
      stars.gravity=(int)random(1);
      stars.emit(3);
      stars.update();
      stars.draw();
    }

    void particleDeclare () {
      stars.minSpeed=1.0;
      stars.maxSpeed=5.0;
      stars.startVx=0.0;
      stars.startVy=-0.0;
      stars.birthSize=9.0;
      stars.deathSize=13.0;
      stars.spreadFactor=0;
      stars.gravity=0.00;
      stars.birthColor=color(color1, color2, color3);
      stars.deathColor=color(color4, color5, color6);
      stars.blendMode="add";
      stars.framesToLive=100;
    }
}

