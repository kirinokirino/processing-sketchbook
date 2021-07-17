Walker w;

void setup() {
  w = new Walker();
}

void draw() {
  background(255);
  w.update();
  w.display();
}

class Walker {
  float x;
  float y;
  
  Walker() {
    x = width / 2;
    y = height / 2;
  }
  
  void update() {
    x = x + random(2) - 1;
    y = y + random(2) - 1;
  }
  
  void display() {
    circle(x, y, 2);
  }
}
