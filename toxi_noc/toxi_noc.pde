import toxi.physics2d.*; //<>//
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

import java.util.Optional;

MouseMovement lmb;
MouseMovement rmb;

VerletPhysics2D physics;
Particles particles;

void setup() {
  size(640, 480);
  lmb = new MouseMovement();
  rmb = new MouseMovement();

  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0, 0, width, height));
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.5)));

  particles = new Particles(physics);
  Particle p = particles.addParticle(width / 2, height / 2);
  particles.lock(p);
}

void draw() {
  background(200);
  physics.update();
  particles.update();

  particles.display();
}

void mousePressed() {
  PVector pos = new PVector(mouseX, mouseY);
  if (mouseButton == LEFT) {
    lmb.start = pos;
    lmb.currently_pressed = true;
    Particle closest_particle = particles.closestTo(pos);
    if (closest_particle.distance(pos) < 20) {
      closest_particle.selected = true;
      lmb.selected_particles.add(closest_particle);
      particles.lock(closest_particle);
    }
  } else if (mouseButton == RIGHT) {
    rmb.start = pos;
    rmb.currently_pressed = true;
  } else if (mouseButton == CENTER) {
  }
}

void mouseReleased(MouseEvent event) {
  PVector pos = new PVector(mouseX, mouseY);
  if (mouseButton == LEFT) {
    lmb.end = pos;
    lmb.currently_pressed = false;
    if (!lmb.isDragging()) {
      particles.addParticle(mouseX, mouseY);
    }
    for (Particle p : lmb.selected_particles) {
      p.selected = false;
      particles.unlock(p);
    }
    lmb.selected_particles.clear();
  } else if (mouseButton == RIGHT) {
    rmb.end = pos;
    rmb.currently_pressed = false;
  } else if (mouseButton == CENTER) {
  }
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    Vec2D delta = new Vec2D(mouseX - pmouseX, mouseY - pmouseY);
    for (Particle p : lmb.selected_particles) {
      p.p.addSelf(delta);
    }
  }
}
