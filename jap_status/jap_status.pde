/**
 * Text Rotation. 
 * 
 * Draws letters to the screen and rotates them at different angles.
 */

PFont f;
float angleRotate = 0.0;
boolean on_break = false;

void setup() {
  size(480, 360);
  background(0);

  // Create the font from the .ttf file in the data folder
  f = createFont("NotoSansCJK-Medium.ttc", 24);
  textFont(f);
} 

void draw() {
  background(0);

  strokeWeight(1);
  stroke(153);
  
  if (on_break) {
    
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(angleRotate));
  text("休憩中", 0, 0);
  rotate(radians(180));
  text("休憩中", 0, 0);
  popMatrix();
  translate(50, 50);
  text("break!", 0, 0);
  } else {
    
    
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(angleRotate));
  text("勉強中", 0, 0);
  rotate(radians(180));
  text("勉強中", 0, 0);
  popMatrix();
  translate(50, 50);
  text("studying japanese", 0, 0);
  }
  
  angleRotate += 0.25;
}

void mouseClicked(){
  if (on_break) {
    on_break = false;
  } else { on_break = true; }
}
