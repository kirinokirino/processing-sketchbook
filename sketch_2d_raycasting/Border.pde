

class Border {
  PVector a;
  PVector b;
  
  Border(PVector from, PVector to) {
     a = from;
     b = to;
  }
  
  void update() {
    assert true;
  }
  
  void display() {
    line(a.x, a.y, b.x, b.y);
  }
}
