Player player;
ArrayList<PVector> positions;
ArrayList<Walker> walkers;
void setup() {
  size(640, 360);
  player = new Player();
  positions = new ArrayList<PVector>();
  for (int i = 0; i < 100; i++) {
    positions.add(new PVector(random(0,width), random(0,height)));
  }
  
  walkers = new ArrayList<Walker>();
  for(int i = 0; i < 10; i++) {
    walkers.add(new Walker());
  }
  strokeWeight(3);
  smooth(4);
}

void draw() {
  background(255);
  
  pushMatrix();
  PVector test = player.position.copy().rotate(player.angle);
  translate(width/2 - test.x, height/2 - test.y);
  rotate(player.angle);
  player.update();
  player.draw();
  for (PVector p : positions) {
    point(p.x, p.y);
  }
  
  for(Walker w : walkers) { 
    w.update();
    w.draw();
  }
  popMatrix();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      player.velocity.add(new PVector(0,-0.5));
    } else if (keyCode == DOWN) {
      player.velocity.add(new PVector(0,0.5));
    } else if (keyCode == LEFT) {
      player.angle += 0.15;
    } else if (keyCode == RIGHT) {
      player.angle -= 0.15;
    }
  }
 
}

class Player {
  PVector position;
  PVector velocity;
  float angle;
  
  Player() {
    position = new PVector(width/2, height/2);
    velocity = new PVector();
  }
  
  void update() {
    position.add(velocity.copy().rotate(-angle));
  }
  
  void draw() {
    PVector other = PVector.add(position, velocity.copy().rotate(-angle).setMag(10));
    line(position.x, position.y, other.x, other.y);
  }
}

class Walker {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float maxVelocity = 5;
  float maxSteeringForce = 0.2;
  
  Walker() {
    position = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void update() {
    
    applyRandomForce();
    if (PVector.dist(player.position, position) < 100) {
      applySteeringForce(-10);
    } else {
      applySteeringForce(1);
    }
    
    velocity.add(acceleration);
    velocity.limit(maxVelocity);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void applySteeringForce(float mult) {
    PVector target = player.position;
    PVector desired = PVector.sub(target, position);
    
    PVector steering = PVector.sub(desired, velocity);
    steering.setMag(maxSteeringForce);
    applyForce(steering.mult(mult));
  }
  
  void applyRandomForce() {
    applyForce(new PVector(random(2)-1, random(2)-1));
  }
  
  void draw() {
    circle(position.x, position.y, 3); 
  }
  
  void applyForce(PVector force) { 
    acceleration.add(force);
  }
}
