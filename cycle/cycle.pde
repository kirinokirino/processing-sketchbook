static final int FRAME_RATE = 60; 

void setup() {
  size(500, 500);
  background(220);
  colorMode(HSB);
  stroke(100);
  strokeWeight(2);
  frameRate(FRAME_RATE);
}

void draw() {
  fill(200);
  pushMatrix();
  translate(width/2, height/2);
  ellipse(0, 0, width, height); 
  
  final int lines = 300;
  for (int i = 0; i <= lines; i+=1) {
    fill(map((float)i, 0, lines, 0, 255), 255, 255);
    pushMatrix();
    rotate(((float)i / (float)lines) * TAU);
    double bpm = (double)i + 10;
    float cycle_pos = map((float)beat(bpm), 0.0, 4.0, -width/2, width/2);
    ellipse(cycle_pos, 0, 5, 5);
    popMatrix();
  }
  popMatrix();
}

double beat(double bpm) {
  final double current_second = (double)frameCount / FRAME_RATE;
  final double beats_per_second = bpm / 60.0;
  return (current_second * beats_per_second) % 4.0;
}
