ParticleSystem particles;
ArrayList<Planet> planets;
ArrayList<PImage> images;
Planet sun;

static final int FRAMERATE = 60;
static final float TIMESTEP = 0.005;

void setup() {
  size(640, 480);
  colorMode(HSB, 1.0);
  imageMode(CENTER);
  frameRate(FRAMERATE);
  PVector center = new PVector(width/2, height/2);
  images = new ArrayList<PImage>();
  for (int i = 1; i <= 4; i += 1) {
    PImage image = loadImage("assets/planet" + i + ".png");
    images.add(image);
  }
  particles = new ParticleSystem();
  particles.set_lifetime(10.0);
  sun = new Planet(50);
  sun.set_image(images.get(0));
  sun.pos = center.copy();
  planets = new ArrayList<Planet>();
  
  Planet planet1 = new Planet(10);
  planet1.set_image(images.get(1));
  planet1.pos = center.copy().add(20, 20);
  planet1.make_orbit(sun);
  planet1.apply_force(new PVector(150, -300));
  planets.add(planet1);
  
  Planet planet2 = new Planet(0.003);
  planet2.set_image(images.get(2));
  planet2.pos = planet1.pos.copy().add(-5, 2);
  planet2.make_orbit(planet1);
  planet2.apply_force(new PVector(40, -20));
  planets.add(planet2);
  
  Planet planet3 = new Planet(25);
  planet3.set_image(images.get(3));
  planet3.pos = center.copy().add(-10, -40);
  planet3.make_orbit(sun);
  planet3.apply_force(new PVector(-200, 100));
  planets.add(planet3);
}

void draw() {
  background(0.0, 0.0, 0.1);
  float delta = 1 / (float)FRAMERATE;
  float scale = 0.0005;
  sun.display(scale);
  
  for (float step = TIMESTEP; step >= 0.0; step -= delta) {
  particles.update(delta);
    for (Planet p : planets) {
      p.update(delta);
    }
  }


  particles.display();
  for (Planet p : planets) {
    p.display(scale);
    particles.add(p.pos.copy());
  }
}

void mousePressed() {
  particles.add(new PVector(mouseX, mouseY));
}
