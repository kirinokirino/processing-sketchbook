ArrayList<PhysicsObject> objects;
int CLEANUPSIZE = 10000;
void setup() {
  size(640, 360);
  background(255);
  objects = new ArrayList<PhysicsObject>();
}

void mousePressed() {
  objects.add(new PhysicsObject(new PVector(mouseX, mouseY)));
}

void draw() {
  background(255);
  
  for (PhysicsObject obj: objects) {
    obj.update();
    if (cleanUp(obj.position)) obj.position = new PVector();
  }
  
  for (PhysicsObject obj: objects) {
    obj.draw();
  }
}

boolean cleanUp(PVector position) {
  if (position.x >= CLEANUPSIZE) return true;
  if (position.x <= -CLEANUPSIZE) return true;
  if (position.y >= CLEANUPSIZE) return true;
  if (position.y <= -CLEANUPSIZE) return true;
  return false;
}

class PhysicsObject {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  float radius;
  float gravity = 9.80665;
  float airResistance = 0.01;
  
  PhysicsObject(PVector _position) {
    position = _position;
    velocity = new PVector();
    acceleration = new PVector();
    mass = constrain((randomGaussian() * 20 + 100), 50, 150);
    radius = mass / 100.0 * TAU;
  }
  
  void update() {
    applyGravity();
    applyDrag();
    velocity.add(acceleration);
    position.add(velocity);
    
    acceleration = new PVector();
  }
  
  void applyDrag() {
    float drag = velocity.mag();
    drag = -1 * airResistance * drag * drag * radius;
    applyForce(velocity.copy().normalize().mult(drag));
  }
  
  void applyGravity() {
    applyForce(new PVector(0, gravity));
  }
  
  void applyForce(PVector force) {
    acceleration.add(force.div(mass));
  }
  
  void draw() {
    circle(position.x, position.y, radius);
  }
}
