
class ParticleSystem {
  ArrayList<Particle> particles;
  float max_lifetime;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
    max_lifetime = 10.0;
  }

  void add(PVector pos) {
    particles.add(new Particle(pos, max_lifetime));
  }

  void set_lifetime(float _max_lifetime) {
    max_lifetime = _max_lifetime;
  }

  void update(float delta) {
    for (Particle p : particles) {
      p.update(delta);
    }
    particles.removeIf(particle -> particle.lifetime <= 0.0);
  }

  void display() {
    pushMatrix();
    for (Particle p : particles) {
      p.display();
    }
    popMatrix();
  }
}
