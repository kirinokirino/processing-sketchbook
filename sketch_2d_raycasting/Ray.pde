import java.util.Optional;

class Ray {
  PVector pos;
  PVector direction;
  
  Ray(PVector position) {
     pos = position;
     direction = new PVector(1, 0);
  }
  
  void set_direction(PVector _direction) {
     direction = _direction; 
  }
  
  void look_at(PVector target) {
    PVector delta = PVector.sub(target, pos);
    delta.normalize();
    direction = delta;
  }
  
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    line(0, 0, direction.x * 10, direction.y * 10);
    popMatrix();
  }
  
  Optional<PVector> cast(Border border) {
     final float x1 = border.a.x;
     final float y1 = border.a.y;
     final float x2 = border.b.x;
     final float y2 = border.b.y;
     
     final float x3 = pos.x;
     final float y3 = pos.y;
     final float x4 = pos.x + direction.x;
     final float y4 = pos.y + direction.y;
     
     final float denominator = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
     if (denominator == 0) {
       return Optional.empty();
     } 
     
     final float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denominator;
     final float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denominator;
     if (t > 0 && t < 1 && u >= 0) {
       final float x = x1 + t * (x2 - x1);
       final float y = y1 + t * (y2 - y1);
       return Optional.of(new PVector(x, y));
     } else {
       return Optional.empty();
     }
  }
}
