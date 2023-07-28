ArrayList<Border> borders;
Sensor sensor;

void setup() {
  size(480, 360);
  borders = new ArrayList<Border>();
  borders.add(new Border(new PVector(300, 100), new PVector(300, 200)));
  for (int i = 0; i < 10; i++) {
    borders.add(new Border(random_vec(), random_vec()));
  }

  sensor = new Sensor(new PVector(width / 2, height / 2));
}

void draw() {
  background(200);
  for (Border b : borders) {
    b.display();
  }

  for (Ray ray : sensor.rays) {
    ray.display();
    Optional<PVector> closest_intersection = Optional.empty();

    for (Border b : borders) {
      Optional<PVector> intersection = ray.cast(b);
      if (intersection.isPresent()) {
        PVector point = intersection.get();
        if (closest_intersection.isPresent()) {
          if (PVector.dist(ray.pos, point) < PVector.dist(ray.pos, closest_intersection.get())) {
            closest_intersection = Optional.of(point);
          }
        } else {
          closest_intersection = Optional.of(point);
        }
      }
    }
    closest_intersection.ifPresent(point -> {
      ellipse(point.x, point.y, 7, 7);
      line(ray.pos.x, ray.pos.y, point.x, point.y);
    }
    );
  }
}

void mouseMoved() {
  sensor.look_at(new PVector(mouseX, mouseY));
}

void mouseClicked() {
  setup();
}

PVector random_vec() {
  return new PVector(random(0, width), random(0, height));
}
