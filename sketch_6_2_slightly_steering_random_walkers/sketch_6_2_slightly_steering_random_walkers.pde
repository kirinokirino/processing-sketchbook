/*
<kirinokirino> 1. find lamp image, add some yellow particles and make circles into tiny black dots
<kirinokirino> 2. add a subtle wind force
<kirinokirino> 3. make a synthesizer that plays some drone depending how close dots are to the center, 
maybe cut the number of dots so its not overwhelming
<kirinokirino> maybe the opposite, the further the dot is the louder its tone
*/

ArrayList<Walker> walkers;

import processing.sound.*;

void setup() {
  size(640, 640);
  walkers = new ArrayList<Walker>();
  for(int i = 0; i < 10; i++) {
    walkers.add(new Walker());
  }
}

void draw() {
  background(255);
  
  for(Walker w : walkers) { 
    w.update();
    w.draw();
  }
}

class Walker {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float maxVelocity = 4;
  float maxSteeringForce = 0.1;
  
  Walker() {
    position = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void update() {
    
    applyRandomForce();
    applySteeringForce();
    
    velocity.add(acceleration);
    velocity.limit(maxVelocity);
    position.add(velocity);
    acceleration.mult(0);
    
    moveIntoView(position);
  }
  
  void applySteeringForce() {
    PVector target = new PVector(mouseX, mouseY);
    PVector desired = PVector.sub(target, position);
    
    PVector steering = PVector.sub(desired, velocity);
    steering.setMag(maxSteeringForce);
    applyForce(steering);
  }
  
  void applyRandomForce() {
    applyForce(new PVector(random(2)-1, random(2)-1));
  }
  
  void draw() {
    circle(position.x, position.y, 7); 
  }
  
  void applyForce(PVector force) { 
    acceleration.add(force);
  }
}

void moveIntoView(PVector position) {
  if (position.x > width) position.x = position.x - width;
  else if (position.x < 0) position.x = position.x + width;
  if (position.y > height) position.y = position.y - height;
  else if (position.y < 0) position.y = position.y + height;
}
