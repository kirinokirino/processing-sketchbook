static final float MIN_BRIGHTNESS = 0.0; //<>//
static final float MAX_BRIGHTNESS = 0.9;

class Particle {
  PVector pos;

  float max_lifetime;
  float lifetime;

  Particle(PVector position, float _max_lifetime) {
    pos = position;
    max_lifetime = _max_lifetime;
    lifetime = max_lifetime;
  }

  void update(float delta) {
    lifetime -= delta;
  }

  void display() {
    final float brightness = map(lifetime / max_lifetime, 0.0, 1.0, MIN_BRIGHTNESS, MAX_BRIGHTNESS);
    final float alpha = brightness;
    stroke(0.4, 0.3, brightness, alpha);
    point(pos.x, pos.y);
    //fill(0.4, 0.3, brightness, alpha);
    //ellipse(pos.x, pos.y, 50, 50);
  }
}
