ArrayList<Bullet> bullets = new ArrayList<Bullet>();

void bullets() {

  //draw bullets
  for (Bullet bullet : bullets) {
    //print(bullet.cords);
    bullet.draw();
  }
  //delete bullets
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    if (bullet.finished()) {
      bullets.remove(i);
    }
  }
}


class Bullet extends ellipse {
  float bulletVelocity = 10;

  Bullet(PVector start) {
    super(new PVector(10, 10), start);
    this.vel = new PVector(0, -bulletVelocity);
  }
  boolean shot = false;
  
  //check to see if the bullet is out of bounds or hit something, if either finished is true
  boolean finished() {
    if (cords.y <= 0) {
      return true;
    }
    ////if exploded
    if (shot) {
      return true;
    }

    return false;
  }
  
  void draw() {
    noStroke();
    super.draw();
  }
}
