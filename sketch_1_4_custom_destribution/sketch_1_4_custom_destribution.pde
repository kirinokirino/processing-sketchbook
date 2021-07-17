float[] heights;
int bars = 100;
float timestep = 0.1;
float offset = 0;

void setup() {
  size(640, 360);
  background(255);
  heights = new float[100];
  for (int i = 0; i < bars; i++) {
    heights[i] = noise(i*timestep)*height/2; 
  }
}

void draw() {
  background(255);
  fill(0);
  stroke(60);
  
  for (int i = 0; i < bars; i++) {
    heights[i] = noise(offset + i*timestep)*height/2; 
  }
  offset += timestep;
  
  float barWidth = width/(bars-1);
  for (int i = 0; i < bars; i++) {
    rect(i*barWidth, height/2-heights[i]/2, barWidth, heights[i]);
  }
  
}
