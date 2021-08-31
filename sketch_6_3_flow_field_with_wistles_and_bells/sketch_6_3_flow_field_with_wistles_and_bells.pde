FlowField field;

ArrayList<Walker> walkers;
boolean first;
void setup() {
  //blendMode(LIGHTEST);
  background(255);
  fullScreen();
  
  
  //size(640, 640);
  field = new FlowField(30);
  field.init(0.15);
  
  walkers = new ArrayList<Walker>();
  for(int i = 0; i < 100; i++) {
    walkers.add(new Walker());
  }
  strokeWeight(7);
}
void mousePressed() {
  field.init(0.15);
}
void draw() {
  stroke(0,0,0,10);
  fill(0,0,0,10);
  rect(0,0,width/2,height);
  
  //stroke(255,255,255,10);
  //fill(255,255,255,10);
  rect(width/2,0,width,height);
  
  //background(255,255,255,20);
  //if (mousePressed) { field.draw(); }
  for(Walker w : walkers) { 
    w.update();
    w.draw();
  
  }
}

class Walker {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float maxVelocity;
  float maxSteeringForce;
  
  color c;
  
  Walker() {
    position = new PVector(random(0, width), random(0,height));//position = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    maxVelocity = random(1,7);
    maxSteeringForce = random(0,1);
    c = color(random(0,80),random(50,150),random(50,150));
    //c = color(random(200,255),random(200,255),random(200,255));
  }
  
  void update() {
    if (mousePressed) {
      applyMouseForce();
    }
    applyRandomForce();
    applySteeringForce();
    
    velocity.add(acceleration);
    velocity.limit(maxVelocity);
    position.add(velocity);
    acceleration.mult(0);
    
    moveIntoView(position);
  }
  
  void applySteeringForce() {
    PVector target = PVector.add(position, field.lookup(position));//new PVector(mouseX, mouseY);
    PVector desired = PVector.sub(target, position);
    
    PVector steering = PVector.sub(desired, velocity);
    steering.setMag(maxSteeringForce);
    applyForce(steering);
  }
  
  void applyRandomForce() {
    applyForce(new PVector(random(2)-1, random(2)-1).mult(0.4));
  }
  
  void applyMouseForce() {
    PVector target = new PVector(mouseX, mouseY);
    PVector desired = PVector.sub(target, position);
    
    PVector steering = PVector.sub(desired, velocity);
    steering.setMag(maxSteeringForce*2);
    applyForce(steering);
  
  }
  
  void draw() {
    stroke(c);
    point(position.x, position.y);//circle(position.x, position.y, 7); 
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

class FlowField {
  
  PVector[][] field;
  int cols, rows;
  int resolution;
  
  FlowField(int r) {
    cols = (width/r)+1;
    rows = (height/r)+1;
    resolution = r;
    field = new PVector[cols][rows];
  }
  
  void init(float step) {
    noiseSeed(int(random(99999999)));
    float xoff = 0;
    for (int col = 0; col < cols; col++) {
      float yoff = 0;
      for (int row = 0; row < rows; row++) {
        float angle = map(noise(xoff, yoff),0,1,0,TAU);
        field[col][row] = PVector.fromAngle(angle).setMag(resolution/2);
        yoff += step;
      }
      xoff += step;
    }
  }
  
  void draw() {
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        
        line(resolution*col, resolution*row, 
        resolution*col+field[col][row].x, resolution*row+field[col][row].y);
      }
    }
  }
  
  PVector lookup(PVector position) {
    int x = int(constrain(position.x, 0, width));
    int y = int(constrain(position.y, 0, height));
    return field[x/resolution][y/resolution];
  }
}
