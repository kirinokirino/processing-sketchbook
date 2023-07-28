static final float DRAGGED_TOLERANCE = 20.0;

class MouseMovement {
  PVector start;
  PVector end;
  
  boolean currently_pressed;
  ArrayList<Particle> selected_particles;
  
  MouseMovement() {
    start = new PVector(0, 0);
    end = new PVector(0, 0);
    selected_particles = new ArrayList<Particle>();
  }
  
  boolean isDragging() {
    if (!selected_particles.isEmpty()) {
      return true; 
    }
    return PVector.dist(start, end) > DRAGGED_TOLERANCE;
  }
}
