ArrayList<Explosion> explosions = new ArrayList<Explosion>();

public class Explosion {
  PVector cords;
  float size = 1;
  float speed = 0.05;
  boolean done = false;
  float scale;

  Explosion(PVector cords, float size) {
    this.cords = cords;
    this.size = size;
  }

  Explosion(float x, float y, float size) {
    this.cords = new PVector(x, y);
    this.size = size;
  }
  Explosion(PVector cords){
   this.cords = cords; 
  }
  Explosion(object object){
   this.cords = object.cords;
   this.scale = object.size.x;
  }

  void draw() {
    if (size < scale*3) {
      size *= speed / (1/frameRate); 
      stroke(255);
      fill(255,255,255,size);
      strokeWeight(20);
      ellipse(cords.x, cords.y, size, size);
    } else {
      done = true;
    }
  }
}
