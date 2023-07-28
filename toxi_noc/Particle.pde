class Particle {
  VerletParticle2D p;
  
  boolean selected;
  
  Particle(Vec2D pos) {
    p = new VerletParticle2D(pos); 
    selected = false;
  }
  
  void display() {
    ellipse(p.x, p.y, 16, 16);
  }
  
  float distanceTo(Particle other) {
    return p.distanceTo(other.p);
  }
  
  float distance(PVector other) {
    return PVector.dist(other, new PVector(p.x, p.y)); 
  }
}
