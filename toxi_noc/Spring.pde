
class Spring {
  VerletSpring2D s;
  
  Particle a;
  Particle b;
  
  Spring(Particle _a, Particle _b, float len, float strength) {
    a = _a;
    b = _b;
    s = new VerletSpring2D(_a.p, _b.p, len, strength);
  }
  
  void display() {
    line(a.p.x, a.p.y, b.p.x, b.p.y);
  }
}
