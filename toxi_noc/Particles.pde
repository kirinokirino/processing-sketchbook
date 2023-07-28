

class Particles {
  VerletPhysics2D physics;
  ArrayList<Particle> particles;
  ArrayList<Spring> springs;

  Particles(VerletPhysics2D _physics) {
    physics = _physics;
    particles = new ArrayList<Particle>();
    springs = new ArrayList<Spring>();
  }

  void display() {
    fill(100);
    stroke(0);
    for (Spring spring : springs) {
      spring.display();
    }
    for (Particle p : particles) {
      if (p.selected) {
        fill(255, 140, 140); 
      } else {
        fill(100); 
      }
      p.display();
    }
  }
  
  void update() {
    for (Particle p : particles) {
       for (Particle other : particles) {
          float dist = p.distanceTo(other);
          if (dist >= 0.01 && dist < 30) {
             connectWithSpring(p, other, 0.01);
          }
       }
    }
  }

  Particle addParticle(float x, float y) {
    Particle particle = new Particle(new Vec2D(x, y));
    Optional<Particle> previous_particle = get(particles.size() - 1);
    previous_particle.ifPresent(other -> connectWithSpring(particle, other, random(0.01, 0.1)));
    particles.add(particle);
    physics.addParticle(particle.p);
    return particle;
  }

  void connectWithSpring(Particle a, Particle b, float strength) {
    if (springAlreadyExists(a, b)) {
      return; 
    }
    float len = a.distanceTo(b);
    Spring spring = new Spring(a, b, max(len, 20), strength);
    springs.add(spring);
    physics.addSpring(spring.s);
  }
  
  boolean springAlreadyExists(Particle a, Particle b) {
    for (Spring s: springs) {
      if ((s.a == a || s.b == a) && (s.a == b || s.b == b)) {
        return true;
      }
    }
    return false;
  }

  void lock(Particle particle) {
    particle.p.lock();
  }

  void unlock(Particle particle) {
    particle.p.unlock();
  }

  Optional<Particle> get(int index) {
    if (index >= particles.size() || index < 0) {
      return Optional.empty();
    }
    return Optional.of(particles.get(index));
  }

  Particle closestTo(PVector _pos) {
    assert (particles.size() > 0);
    Vec2D pos = new Vec2D(_pos.x, _pos.y);
    float min_distance = Float.POSITIVE_INFINITY;
    Particle selected_particle = null;
    for (Particle particle : particles) {
      float current_distance = particle.p.distanceTo(pos);
      if (current_distance < min_distance) {
        min_distance = current_distance;
        selected_particle = particle;
      }
    }
    return selected_particle;
  }
}
