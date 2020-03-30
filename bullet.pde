ArrayList<Bullet> bullets = new ArrayList<Bullet>();




class Bullet extends ellipse {
  float bulletVelocity = 10;

  Bullet(PVector start) {
    super(new PVector(10, 10), start);
    //this.cords = start;
    this.vel = new PVector(0, -bulletVelocity);
    //print("new bullet");
  }
  boolean shot = false;
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
