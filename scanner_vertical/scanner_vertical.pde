void setup() {
  size(400, 400);
  background(0);
  noStroke();
  frameRate(10);
}

void draw() {
  blendMode(SUBTRACT);
  fill(255, 4);
  rect(0, 0, 400, 400);
  blendMode(BLEND);
  fill(255);
  int y = frameCount % 110;
  for (int x = 0; x < 100; x++) {
    if (random(1) < 0.07) {
      if (random(1) < 0.01) {
        fill(255, 0, 0);
      } else {
        fill(255);
      }
      rect(x * 4, y * 4, 4, 4);
    }
  }
}
