void enemies() {
  //draw enemies and check for hit
  for (Enemy enemy : enemies) {
    //for each bullet
    for (Bullet bullet : bullets) {
      //todo turn enemy into a list instead of array
      if (!enemy.hit) {
        if (enemy.collision(bullet)) {
          bullet.shot = true;
          enemy.hit = true;
          explosion.play();
          explosions.add(new Explosion(enemy));
          explosions.add(new Explosion(bullet));
        }
      }
    }
    if (!enemy.hit) {
      enemy.draw();
    }
  }
}

ArrayList<Enemy> enemy = new ArrayList<Enemy>();
static final PVector defaultEnemySize = new PVector(20,20);

Enemy[] enemies = {new Enemy(100, 100), 
  new Enemy(140, 100), new Enemy(180, 100),
  new Enemy(220, 100), 
  new Enemy(260, 100), new Enemy(300, 100)
};


class Enemy extends rect {
  
  boolean hit = false;
  
  Enemy(float x, float y){
    super(defaultEnemySize, x, y);
  }  
}
