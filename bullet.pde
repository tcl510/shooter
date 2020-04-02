ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Bullet> enemyBullets = new ArrayList<Bullet>();

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

  for (Bullet bullet : enemyBullets) {
    //print(bullet.cords);
    bullet.draw();
  }
  //delete bullets
  for (int i = enemyBullets.size() - 1; i >= 0; i--) {
    Bullet bullet = enemyBullets.get(i);
    if (bullet.finished()) {
      enemyBullets.remove(i);
    }
  }

}

static final float DEFAULT_BULLETVELOCITY = 10;
class Bullet extends ellipse {
  float bulletVelocity = 10;

  int r, g, b = 255;

  Bullet(PVector start, int direction, int r, int g, int b, float bulletVelocity) {
    super(new PVector(10, 10), start);
    this.vel = new PVector(0, direction * bulletVelocity);
    this.r = r;
    this.g = g;
    this.b = b;
  }
  Bullet(PVector start){
    this(start, -1, 255, 255, 255, 10);
  }
  Bullet(PVector start, int direction, int r, int g, int b){
    this(start, direction, r, g, b, DEFAULT_BULLETVELOCITY);
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
    fill(r,g,b);
    super.draw();
  }
}
