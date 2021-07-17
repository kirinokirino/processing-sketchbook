
Walker w;

void setup() {
  size(640, 360);
  w = new Walker();
}

void draw() {
  background(255);
  w.update();
  w.draw();
}

class Walker {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  Walker() {
    position = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void update() {
    acceleration = PVector.random2D();
    velocity.add(acceleration);
    velocity.limit(5);
    position.add(velocity);
    acceleration.mult(0);
    
    moveIntoView(position);
  }
  
  void draw() {
    circle(position.x, position.y, 7); 
  }
}

void moveIntoView(PVector position) {
  if (position.x > width) position.x = position.x - width;
  else if (position.x < 0) position.x = position.x + width;
  if (position.y > height) position.y = position.y - height;
  else if (position.y < 0) position.y = position.y + height;
}
