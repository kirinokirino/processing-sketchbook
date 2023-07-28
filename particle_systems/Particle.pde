static float MAX_LIFETIME = 400.0;

class Particle {
  PVector starting_pos;
  PVector pos;
  PVector vel;
  PVector acc;
  
  float lifetime;

  Particle(PVector starting_position) {
    starting_pos = starting_position;
    reset();
  }
  
  void reset() {
    pos = starting_pos.copy();
    vel = new PVector();
    acc = new PVector();
    lifetime = 0.0;
  }

  void update() {
    vel.add(acc);
    pos.add(vel);

    acc.set(0.0, 0.0, 0.0);
    lifetime += 1.0;
    if (lifetime >= MAX_LIFETIME) {
      reset();
    }
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void display() {
    ellipse(pos.x, pos.y, 8, 8);
  }
}
