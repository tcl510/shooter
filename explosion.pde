ArrayList<Explosion> explosions = new ArrayList<Explosion>();

//render and delete explosions
void explosions() {
  //draw all explosions
  for (Explosion explosion : explosions) {
    explosion.draw();
  }
  //check if explosion is exploded, if its expoded purge from the list so it stop rendering the same explosion
  for (int i = explosions.size() - 1; i >= 0; i--) {
    Explosion explosion = explosions.get(i);
    if (explosion.done) {
      explosions.remove(i);
    }
  }
}


public class Explosion {
  PVector cords;
  float size = 1;
  float speed = 0.05;
  boolean done = false;
  float scale;


//constructors
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
  
  float alpha = 200;

  void draw() {
    //in essense, increase the scale till a certain point
    if (size < scale*2) {
      
      //increase the size
      size *= speed / (1/frameRate); 
      
      drawRing(255*(size/scale*2));
    } else {
      //once the explosion is a certain size, fade the explosion
      if (alpha*size > 0){
        drawRing(alpha);
      alpha -= 15/(60/frameRate);
      } else {
      done = true;
      }
    }
  }
  void drawRing(float alpha){
      //draw the explosion
      stroke(alpha);
      fill(255,255,255, alpha);
      strokeWeight(10);
      //draw explosion ring
      ellipse(cords.x, cords.y, size, size);
      //randomise explosion
      ellipse(cords.x + random(0,3), cords.y + random(0,3), size, size);
  }
}
