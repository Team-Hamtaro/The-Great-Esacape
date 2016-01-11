class Credits {
	
	float programmersHeight = 1.43;
	float graphicsSoundHeight = 1.8;
	float projectLeadHeight = 2.5;
	int offset = 40;

	boolean musicSet = false;

	void update() {
		if (!musicSet) {
			backgroundMusic.close();
			backgroundMusic = minim.loadFile("Rhinoceros.mp3");
			backgroundMusic.loop();
			musicSet = true;
		}
	}

	void draw() {
		update();

		background(0);

		fill(255, 200, 100);
    	textAlign(CENTER);
    	textSize(56);
    	text("Credits", width/2, height/6);
    	textSize(72);
    	text("Team Hamtaro", width/2, height/3.6);
    	textSize(40);
    	//text()
    	text("Project Lead:", width/2, height/projectLeadHeight);
    	text("Graphics & Sound:", width/2, height/graphicsSoundHeight);
    	text("Programmers:", width/2, height/programmersHeight);
    	textSize(30);
  	 	text("Rik Langeveld", width/2, height/projectLeadHeight + offset);	
  	 	text("Chris Toonen", width/2, height/graphicsSoundHeight + offset);
    	text("Aleksej Horvat", width/2, height/programmersHeight + offset);
    	text("Kay van der Lans", width/2, height/programmersHeight + offset*2);
    	text("Patrick Tibboel", width/2, height/programmersHeight + offset*3);
    	text("Rik Langeveld", width/2, height/programmersHeight + offset*4);
	
    	if (keyPressed) {
    		backgroundMusic.close();
    		backgroundMusic = minim.loadFile("cave.mp3");
    		backgroundMusic.loop();
    		musicSet = false;
    		gameState = GameState.START_SCREEN;
    	}
	}
}