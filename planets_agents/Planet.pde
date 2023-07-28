import java.util.Optional;

static final double GRAVITATIONAL_CONSTANT = 10.0;

class Planet {
  PVector pos;
  PVector vel;
  PVector acc;

  float mass;

  Optional<PImage> planet_image;
  Optional<Planet> orbits_around;

  Planet(float _mass) {
    pos = new PVector();
    vel = new PVector();
    acc = new PVector();

    mass = _mass;
    orbits_around = Optional.empty();
    planet_image = Optional.empty();
  }

  void apply_force(PVector force) {
    acc.add(force.mult(mass));
  }

  void make_orbit(Planet other) {
    orbits_around = Optional.of(other);
  }

  void set_image(PImage image) {
    planet_image = Optional.of(image);
  }

  void apply_gravity_force() {
    if (orbits_around.isPresent()) {
      Planet other = orbits_around.get();
      final double distance = PVector.sub(pos, other.pos).mag();
      final double force = (GRAVITATIONAL_CONSTANT * mass * other.mass) / (distance * distance);
      PVector direction = PVector.sub(other.pos, pos);
      direction.normalize();
      apply_force(direction.mult((float)force).limit(100));
    }
  }

  void update(float delta) {
    orbits_around.ifPresent(orbits -> pos.add(orbits.vel.copy().mult(delta)));
    apply_gravity_force();
    vel.add(PVector.mult(acc, delta));
    pos.add(PVector.mult(vel, delta));

    acc.set(0.0, 0.0, 0.0);
  }

  void display(float scale) {
    pushMatrix();
    translate(pos.x, pos.y);
    scale(mass * scale);
    ellipse(0, 0, 500, 500);
    planet_image.ifPresent(img -> image(img, 0, 0));
    popMatrix();
  }
}
