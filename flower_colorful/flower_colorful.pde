static final int W = 480;
static final int H = 360;
  
void setup() {
  size(480, 360);
  windowResize(W, H);
  colorMode(RGB, 1.0);
  background(0.2);
  noStroke();
}

void draw() {
  translate(width / 2, height / 2);
  float radius = min(width, height);
  float dist = map(triangle(75, 0), 0, 1, -0.5 , 0.5) * radius;
  fill(triangle(100, 0), triangle(200, 0), triangle(300, 0));
  //pushMatrix();
  rotate(cycle(360) * TAU);
  translate(dist, 0);
  rect(0, 0, 5, 5);
  //popMatrix();
}

float offset(float period, float by) {
   float new_period = period + by;
   if (new_period >= 1.0) {
     return new_period - 1.0;
   } else {
      return new_period; 
   }
}

float cycle(int period) {
  return float(frameCount % period) / float(period);
}

float triangle(int period, int phase) {
  float saw = (cycle(period) + phase) % period;
  if (saw < 0.5) {
    return saw * 2.0;
  } else {
    return (1.0 - saw) * 2.0;
  }
}
