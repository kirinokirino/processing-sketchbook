ArrayList<PhysicsObject> objects;
ArrayList<Repeller> repellers;
int CLEANUPSIZE = 640;

float AIRRESISTANCE = 0.05;
float REPELLFORCE = 100;

void setup() {
  size(640, 360);
  background(255);
  objects = new ArrayList<PhysicsObject>();
  repellers = new ArrayList<Repeller>();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    objects.add(new PhysicsObject(new PVector(mouseX, mouseY))); 
  } else {
    repellers.add(new Repeller(new PVector(mouseX, mouseY)));
  }
}

void draw() {
  background(255);
  stroke(0);
  fill(0);
  for (PhysicsObject obj: objects) {
    obj.update();
    if (cleanUp(obj.position)) obj.position = new PVector(width/2, 0);
  }
  
  for (PhysicsObject obj: objects) {
    obj.draw();
  }
  stroke(100,0,0);
  fill(255,100,100);
  for (Repeller obj: repellers) {
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
  float airResistance = AIRRESISTANCE;
  
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
    applyRepel();
    applySelfRepel();
    velocity.add(acceleration);
    position.add(velocity);
    
    acceleration = new PVector();
  }
  
  void applySelfRepel() {
    for (PhysicsObject repeller: objects) {
      float distance = position.dist(repeller.position);
      if (distance > 10) {
        PVector direction = position.copy().sub(repeller.position).normalize();
        applyForce(direction.mult(mass*REPELLFORCE/(distance*distance)));
      }
    }
  }
  
  void applyRepel() {
    for (Repeller repeller: repellers) {
      float distance = position.dist(repeller.position);
      PVector direction = position.copy().sub(repeller.position).normalize();
      applyForce(direction.mult(mass*REPELLFORCE/(distance*distance)));
    }
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

class Repeller {
  PVector position;
  
  Repeller(PVector _position) {
    position = _position;
  }
  
  void draw() {
    circle(position.x, position.y, 5);
  }
}
