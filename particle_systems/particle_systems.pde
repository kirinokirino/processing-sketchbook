ParticleSystem ps;

void setup() {
  size(480, 360);
  ps = new ParticleSystem();
}

void draw() {
  background(50);
  ps.update();

  ps.display();
}

void mousePressed() {
  ps.addParticle(new PVector(mouseX, mouseY)); 
}
