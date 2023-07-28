static int NUM_RAYS = 10;
static float ANGLE_SPREAD = 60.0;
static float ANGLE_STEP = ANGLE_SPREAD * 2 / NUM_RAYS;

class Sensor {
  PVector pos;
  PVector direction;
  
  ArrayList<Ray> rays;
  
  Sensor(PVector position) {
    rays = new ArrayList<Ray>();
    pos = position;
    direction = new PVector(0, 0);
    for (int i = 0; i < NUM_RAYS; i+= 1) {
        Ray ray = new Ray(pos.copy());
        rays.add(ray);
    }
  }
  
  void look_at(PVector target) {
    PVector delta = PVector.sub(target, pos);
    delta.normalize();
    direction = delta;
    
    for (int i = 0; i < NUM_RAYS; i+= 1) {
      float angle = -ANGLE_SPREAD + (i * ANGLE_STEP);
      rays.get(i).set_direction(direction.copy().rotate(radians(angle)));
    }
  }
}
