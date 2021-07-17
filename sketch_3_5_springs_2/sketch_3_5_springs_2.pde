ArrayList<PhysicsObject> objects;
float AIRRESISTANCE = 0.05;

void setup() {
  size(640, 360);
  background(255);
  objects = new ArrayList<PhysicsObject>();
  //noStroke();
}

PVector lastMouse;
void mousePressed() {
  if (mouseButton == LEFT) {
    if (lastMouse != null) {
      if (objects.size() == 0) { 
        objects.add(new PhysicsObject(new PVector(mouseX, mouseY), lastMouse));
      } else {
        PhysicsObject obj = new PhysicsObject(new PVector(mouseX, mouseY));
        PhysicsObject prev = objects.get(objects.size()-1);
        Spring spring = new Spring(obj, prev);
        obj.connectSpring(spring);
        prev.connectSpring(spring);
        objects.add(obj);
      }
    }
    else { lastMouse = new PVector(mouseX, mouseY); }
  } else {
    PVector mouse = new PVector(mouseX, mouseY);
    PhysicsObject nearest = nearestObject(mouse);
    nearest.connectSpring(new Spring(mouse, nearest));
  }
}

PhysicsObject nearestObject(PVector position) {
  float closest = 99999999;
  PhysicsObject selected = null;
  for (PhysicsObject obj: objects) {
    if(closest > obj.position.dist(position)) {
      closest = obj.position.dist(position);
      selected = obj;
    }
  }
  return selected;
}

void draw() {
  background(255);
  stroke(0);
  fill(0);
  for (PhysicsObject obj: objects) {
    obj.update();
  }
  
  for (PhysicsObject obj: objects) {
    obj.draw();
  }
  //stroke(100,0,0);
  fill(255,100,100);
}

class PhysicsObject {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  float radius;
  float gravity = 9.80665;
  float airResistance = AIRRESISTANCE;
  
  ArrayList<Spring> springs;
  
  PhysicsObject(PVector _position) {
    position = _position;
    velocity = new PVector();
    acceleration = new PVector();
    mass = constrain((randomGaussian() * 20 + 100), 50, 150);
    radius = mass / 100.0 * TAU;
    
    springs = new ArrayList<Spring>();
  }
  
  PhysicsObject(PVector _position, PVector springAnchor) {
    position = _position;
    velocity = new PVector();
    acceleration = new PVector();
    mass = constrain((randomGaussian() * 20 + 100), 50, 150);
    radius = mass / 100.0 * TAU;
    
    springs = new ArrayList<Spring>();
    springs.add(new Spring(springAnchor, this));
  }
  
  void connectSpring(Spring spring) {
    springs.add(spring);
  }
  
  void update() {
    for(Spring spring: springs) {
      spring.update();
      applyForce(spring.force);
    }
    
    applyGravity();
    applyDrag();
    velocity.add(acceleration);
    position.add(velocity); //<>//
    
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
    
    for(Spring spring: springs) {
      spring.draw();
    }
  }
}

class Spring {
  PVector anchor;
  PhysicsObject connectionA;
  PhysicsObject connectionB;
  
  float restLength;
  float strength;
  PVector force;
  
  Spring(PVector _anchor, PhysicsObject connectTo) {
    anchor = _anchor;
    connectionA = connectTo;
    restLength = anchor.dist(connectionA.position);
    strength = 5;
  }
  
  Spring(PhysicsObject connectFrom, PhysicsObject connectTo) {
    connectionB = connectFrom;
    connectionA = connectTo;
    restLength = connectionB.position.dist(connectionA.position);
    strength = 0.2;
  }
  
  void update() {
    if (anchor != null) {
      PVector dir = connectionA.position.copy().sub(anchor).normalize();
      float magnitude = strength * (restLength-anchor.dist(connectionA.position));
      force = dir.setMag(magnitude);
    } else {
      PVector dir = connectionA.position.copy().sub(connectionB.position).normalize();
      float magnitude = strength * (restLength-connectionB.position.dist(connectionA.position));
      force = dir.setMag(magnitude);
    }
    
    /*
    PVector spring = anchor.copy().sub(connection.position);
    spring.setMag(strength*(restLength/spring.mag()));
    force = spring; */ //<>//
  }
  
  void draw() {
    if (anchor != null) {
    line(anchor.x, anchor.y, connectionA.position.x, connectionA.position.y); 
    } else {
      line(connectionB.position.x, connectionB.position.y, connectionA.position.x, connectionA.position.y); 
    }
  }
}
