class Effecten {

  int lavaBurstCheck = 0;

  ParticleSystem lavaBurst = new ParticleSystem(0, 0);
  ParticleSystem walkDust = new ParticleSystem(0, 0);
  ParticleSystem shoeSmoke = new ParticleSystem(0, 0);
  ParticleSystem deadEffect = new ParticleSystem(0, 0);
  ParticleSystem jumpEffect = new ParticleSystem(0, 0);

  void init() {
    particleDeclare();
  }

  void draw() {
    particleUpdate();
  }

  void particleUpdate() {

    switch(theWorld.chunkDiff) {
    case 1:
      walkDust.birthColor=color(68, 40, 188);
      walkDust.deathColor=color(152, 120, 248);

      shoeSmoke.birthColor=color(68, 40, 188);
      shoeSmoke.deathColor=color(152, 120, 248);

      jumpEffect.birthColor=color(68, 40, 188);
      jumpEffect.deathColor=color(152, 120, 248);

      break;
    case 2:
      walkDust.birthColor=color(149, 0, 133);
      walkDust.deathColor=color(248, 87, 153);

      shoeSmoke.birthColor=color(149, 0, 133);
      shoeSmoke.deathColor=color(248, 87, 153);

      jumpEffect.birthColor=color(149, 0, 133);
      jumpEffect.deathColor=color(248, 87, 153);
      break;
    case 3:
      walkDust.birthColor=color(137, 12, 0);
      walkDust.deathColor=color(229, 92, 7);

      shoeSmoke.birthColor=color(137, 12, 0);
      shoeSmoke.deathColor=color(229, 92, 7);

      jumpEffect.birthColor=color(137, 12, 0);
      jumpEffect.deathColor=color(229, 92, 7);

      break;
    default:
      break;
    }

    lavaBurstCheck += (int)random(10);

    if (lavaBurstCheck >= 1000) {

      lavaBurst.x0 = (int)random(SCREENX);
      lavaBurst.emit(100);
      lavaBurstCheck = 0;
    }

    lavaBurst.update();
    shoeSmoke.update();
    deadEffect.update();
    jumpEffect.update();
    walkDust.update();

    // draw the particle effects
    shoeSmoke.draw();
    deadEffect.draw();
    jumpEffect.draw();
    walkDust.draw();
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
    lavaBurst.deathColor=color(205, 15, 15);
    lavaBurst.blendMode="add";
    lavaBurst.framesToLive=100;

    walkDust.spreadFactor=0.4;
    walkDust.y0 = SCREENY - 50;
    walkDust.minSpeed=2.0;
    walkDust.maxSpeed=3.0;
    walkDust.startVx=-0.0;
    walkDust.startVy=-0.5;
    walkDust.birthSize=3.0;
    walkDust.deathSize=1.0;
    walkDust.gravity=0.05;
    walkDust.birthColor=color(191, 9, 9);
    walkDust.deathColor=color(205, 15, 15);
    walkDust.blendMode="add";
    walkDust.framesToLive=20;

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

    deadEffect.spreadFactor=1;
    deadEffect.minSpeed=1.0;
    deadEffect.maxSpeed=7.0;
    deadEffect.startVx=0.0;
    deadEffect.startVy=0.0;
    deadEffect.birthSize=10.0;
    deadEffect.deathSize=1.0;
    deadEffect.gravity=-0.00;
    deadEffect.birthColor=color(222, 60, 63);
    deadEffect.deathColor=color(139, 30, 19);
    deadEffect.blendMode="add";
    deadEffect.framesToLive=140;

    jumpEffect.spreadFactor=0.4;
    jumpEffect.minSpeed=3.0;
    jumpEffect.maxSpeed=7.0;
    jumpEffect.startVx=0.0;
    jumpEffect.startVy=-0.02;
    jumpEffect.birthSize=5.0;
    jumpEffect.deathSize=2.0;
    jumpEffect.gravity= 0.02;
    jumpEffect.birthColor=color(200, 60, 160);
    jumpEffect.deathColor=color(138, 30, 138);
    jumpEffect.blendMode="add";
    jumpEffect.framesToLive=30;
  }
}

