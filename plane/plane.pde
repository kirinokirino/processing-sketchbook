PImage plane;

PVector pos, vel;

void setup() {
  size(480, 360);
  imageMode(CENTER);
  plane = loadImage("plane.png");
  pos = new PVector(100, 100);
  vel = new PVector(10, -10);
}

void draw() {
  background(120, 170, 255);
  pos.add(vel);
  translate(width/2, height/2);
  scale(0.02);
  translate(pos.x, pos.y);
  rotate(vel.heading() + PI);
  image(plane, 0, 0);
  vel.add(new PVector(random(1) - 0.5, random(1) - 0.5));

  if (pos.x > width * 25) { pos.x = - width * 25; }
  else if (pos.x < - width * 25) { pos.x = width * 25; }
  if (pos.y > height * 25) { pos.y = - height * 25; }
  else if (pos.y < - height * 25) { pos.y = height * 25; }
}
