float xmin = -10;
float xmax = 10;
float ymin = -10;
float ymax = 10;

float rangex = xmax - xmin;
float rangey = ymax - ymin;

float xscale, yscale;

void setup() {
  size(600, 600);
  noFill();
  xscale = width / rangex;
  yscale = -height / rangey;
}

void draw() {
  background(255);
  translate(width/2, height/2);
  grid();

  float step = 0.1;
  beginShape();
  for (float x = xmin; x <= xmax; x+= step) {
    float y = fn2(x);
    plot(x, y);
  }
  endShape();
  stroke(255, 0, 0);
  float x = guess(-10, 10);
  point(x, fn2(x));
  x = guess(0, 3);
  point(x, fn2(x));
}

float avg(float a, float b) {
  return (a+b) / 2.0;
}

float guess(float lower, float upper) {
  float midpoint = avg(lower, upper);
  
  for (int i = 0; i < 20; i+=1) {
    midpoint = avg(lower, upper);
    if (fn2(midpoint) == 0) {
      return midpoint;
    } else if (fn2(midpoint) < 0) {
      upper = midpoint; 
    } else {
      lower = midpoint;
    }
  }
  return midpoint;
}

float fn1(float x) {
  return 6*pow(x, 3) + 31*pow(x, 2) + 3*x - 10; 
}
float fn2(float x) {
  return 2*pow(x, 2) + 7*x - 15; 
}

void plot(float x, float y) {
  vertex(x * xscale, y * yscale);
}

void point(float x, float y) {
  ellipse(x * xscale, y * yscale, 5, 5); 
}

void grid() {
  strokeWeight(1);
  stroke(0, 255, 255);
  for (int i = (int)xmin; i <= xmax; i += 1) {
    line(i * xscale, ymin * yscale, i * xscale, ymax * yscale);
    line(xmin * xscale, i * yscale, xmax * xscale, i * yscale);
  }

  stroke(0);
  line(-width/2, 0, width/2, 0);
  line(0, -height/2, 0, height/2);
  rect(-width/2, -height/2, width-1, height-1);
}
