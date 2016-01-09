// Class for a single particle
class Particle {
  float x, y, vx, vy, size, particleColor, speed;

  // quad coordinate offset
  float qx0, qy0, qx1, qy1, qx2, qy2, qx3, qy3;

  // Color used to draw the particle
  color drawColor;

  // amount of frames the particle has to live
  int framesToLive;

  // Angular velocity
  float angularVelocity;

  // angle (for quad particles)
  float angle;

  // Constructor
  Particle(float x, float y, int framesToLive) {
    this.x = x; 
    this.y = y;
    this.framesToLive = framesToLive;

    // random angular velocity (left or right)
    angularVelocity = random(-0.1, 0.1);

    // determine coordinate offsets if quad
      qx0 = -random(1.0); 
      qy0 = -random(1.0);
      qx1 = random(1.0); 
      qy1 = -random(1.0);
      qx2 = random(1.0); 
      qy2 = random(1.0);
      qx3 = -random(1.0); 
      qy3 = random(1.0);
  }

  // update position and frames to live
  void update() {
    x += vx * speed;
    y += vy * speed;
    framesToLive--;
  }


  // draw the particle's Pushmatrix and popMatrix will store the data for a short time.
  void draw() {

      angle += angularVelocity;
      pushMatrix();
      translate(x, y);
      pushMatrix();              
      rotate(angle);
      fill(drawColor);
      float ps2 = this.size/2;
      quad(qx0*ps2, qy0*ps2, 
      qx1*ps2, qy1*ps2, 
      qx2*ps2, qy2*ps2, 
      qx3*ps2, qy3*ps2);
      popMatrix();
      popMatrix();
    
  }
}

// Particle system to manage emission of particles
class ParticleSystem {
  ArrayList<Particle> particles;

  // the origin of emission. x1 and y1 are used when emitter is a line 
  float  x0, y0, x1, y1;

  String blendMode = "add";

  // amount of particles to emit
  int emissionRate = 0;

  // amount of frames to emit particles
  int framesToEmit = 0;

  // color at birth and color at death
  color birthColor, deathColor;

  // size at birth and size at death
  float birthSize, deathSize;

  // amount of frames after which the particle is removed
  int framesToLive;

  // direction in which the particles are emitted
  float startVx, startVy;

  // particles are spread slightly randomly
  float spreadFactor;

  // particles have different emission speeds, between minSpeed and maxSpeed
  float minSpeed, maxSpeed;

  // force pulling in y direction
  float gravity;

  // Create new particle system, emitter at (x,y)
  ParticleSystem(float x, float y) {
    this.x0 = x;
    this.y0 = y;  
    particles = new ArrayList<Particle>();
  }


  // add an amount of particles to the particle system
  void emit(int particleAmount) {
    float t, x, y;

    for (int iParticle=0; iParticle<particleAmount; iParticle++) {

        x = x0;
        y = y0;
   

      // spawn an new particle in the system
      Particle particle = new Particle(x, y, framesToLive);
      particle.vx = random(startVx-spreadFactor/2, startVx+spreadFactor/2);
      particle.vy = random(startVy-spreadFactor/2, startVy+spreadFactor/2);
      particle.speed = random(minSpeed, maxSpeed);
      particles.add(particle);
    }
  }

  // creal the particle system
  void reset() {
    particles.clear();
  }

  // update speed, size and color of all particles
  void update() {
    for (int iParticle=0; iParticle<particles.size (); iParticle++) {
      Particle particle = particles.get(iParticle);
      particle.vy += gravity;
      particle.update();
      if (particle.framesToLive == 0)
        particles.remove(particle);
    }
  }

  // draw all particles
  void draw() {

    // only change context once for all particles
    noStroke();
    noSmooth();

    // determine how transparancy is handeled
    if (blendMode == "add")
      blendMode(ADD);
    else
      if (blendMode == "blend")
      blendMode(BLEND);

    for (Particle particle : particles) {
      // determine size by interpolation
      particle.size = lerp(deathSize, birthSize, (float)particle.framesToLive/(float)framesToLive);      
      // determine color by interpolation
      color particleColor = lerpColor(deathColor, birthColor, ((float)particle.framesToLive/(float)framesToLive));

      particle.drawColor = particleColor;
      particle.draw();
    }

    // reset blendmode
    blendMode(BLEND);
  }
}


