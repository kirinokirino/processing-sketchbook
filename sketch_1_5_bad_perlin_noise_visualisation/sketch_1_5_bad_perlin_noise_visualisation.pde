HeightMap m;

void setup() {
  size(640, 360);
  m = new HeightMap(10, 36);
}

void draw() {
  background(255);
  m.update();
  m.draw();
}

class HeightMap {
  int mapWidth;
  int mapHeight;
  float offset;
  float mapScale;
  float[][] heights;
  
  HeightMap(int _mapWidth,int _mapHeight) {
    mapWidth = _mapWidth;
    mapHeight = _mapHeight;
    mapScale = 0.3;
    offset = 0;
    heights = new float[mapWidth][mapHeight];
    for (int i = 0; i < mapWidth; i++) {
      for (int j = 0; j < mapHeight; j++) {
        heights[i][j] = noise(i*mapScale, j*mapScale) * 5 * mapScale;
      }
    }
  }
  
  void update() {
    offset += 0.1;
    
    for (int i = 0; i < mapWidth; i++) {
      for (int j = 0; j < mapHeight; j++) {
        heights[i][j] = noise(i*mapScale,offset + j*mapScale) * 5 * mapScale;
      }
    }
  }
  
  void draw() {
    float mapScale = 20;
    for (int i = 0; i < mapWidth; i++) {
      for (int j = 0; j < mapHeight; j++) {
        float heightScale = map(j, 0, mapHeight, 0.2, 1); //<>//
        float rowWidth = heightScale * (mapWidth * mapScale);
        float offset = (width/2 - rowWidth/2);
        float x = offset + heightScale * (i * mapScale);
        float pointHeight = (1+heights[i][j]) * heightScale * mapScale;
        float y = j * mapScale * heightScale;
        circle(x, y - pointHeight, 4);
        //heights[i][j] = noise(i*mapScale, j*mapScale);
      }
    }
  }
}
