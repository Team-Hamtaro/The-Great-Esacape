   class Effecten {
     
   int lavaBurstCheck = 0;
   ParticleSystem lavaBurst = new ParticleSystem(0, 0);
   
   void init() {
   particleDeclare(); 
   }
   
   void draw() {
    particleUpdate(); 
   }
   
   void particleUpdate() {
     
    lavaBurstCheck += (int)random(10);
    
    if (lavaBurstCheck >= 1000) {
      
      lavaBurst.x0 = (int)random(SCREENX);
      lavaBurst.emit(100);
      lavaBurstCheck = 0;  
  }

    lavaBurst.update();
    lavaBurst.draw();
  }

  void particleDeclare () {
    lavaBurst.spreadFactor=0.4;
    lavaBurst.y0 = SCREENY - 50;
    lavaBurst.minSpeed=3.0;
    lavaBurst.maxSpeed=8.0;
    lavaBurst.startVx=-0.0;
    lavaBurst.startVy=-0.3;
    lavaBurst.birthSize=4.0;
    lavaBurst.deathSize=7.0;
    lavaBurst.gravity=0.01;
    lavaBurst.birthColor=color(191, 9, 9);
    lavaBurst.deathColor=color(205,15,15);
    lavaBurst.blendMode="add";
    lavaBurst.framesToLive=100;
  }
  }
