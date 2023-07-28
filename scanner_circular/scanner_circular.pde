void setup() {
  size(400, 400);
  background(0);
  noStroke();
  frameRate(10);
}

void draw() {
  blendMode(SUBTRACT);
  fill(255, 2);
  rect(0, 0, 400, 400);
  blendMode(BLEND);
  fill(255);
  translate(width/2, height/2);
  float sin = sin(float(frameCount)/40);
  float cos = cos(float(frameCount)/40);
  float c = PI / 100.0;
  for (int x = 0; x < 100; x++) {
    float dist = (float)map(x, 0, 100, -200, 200);
    translate((dist * sin) * c, (dist * cos) * c);
    if (random(1) < 0.07) {
      if (random(1) < 0.01) {
        fill(255, 0, 0);
      } else {
        fill(255);
      }
      ellipse(0, 0, 4, 4);
    }
  }
}
