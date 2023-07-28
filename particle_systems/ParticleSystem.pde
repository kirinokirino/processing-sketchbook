static PVector GRAVITY = new PVector(0.0, 0.25);
static float G = 10.0;

PVector repellingForce(PVector repeller_pos, Particle p) {
   PVector direction = PVector.sub(repeller_pos, p.pos);
   float distance = direction.mag() / 30.0;
   distance = constrain(distance, 5, 100);
   direction.normalize();
   float force = -1 * G / (distance * distance);
   direction.mult(force);
   return direction;
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector repeller;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
    repeller = new PVector(width/2, height);
  }

  void addParticle(PVector particle_pos) {
    particles.add(new Particle(particle_pos)) ;
  }

  void update() {
    for (Particle p: particles) {
      p.applyForce(GRAVITY);
      p.applyForce(repellingForce(repeller, p));
      p.update();
    }
  }

  void display() {
    for (Particle p: particles) {
      p.display();
    }
    
    ellipse(repeller.x, repeller.y, 20, 20);
  }
}
