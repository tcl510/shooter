 //<>//


void setup() {
  size(672, 864);
  frameRate(10000);
  loadSound();
  galaga_setup();
  
}

void draw() {
  //play the game galaga;
  galaga();
  time();
}




Enemy[] enemies = {new Enemy(100, 100), 
  new Enemy(140, 100), new Enemy(180, 100),
  new Enemy(220, 100), 
  new Enemy(260, 100), new Enemy(300, 100)
};

Player player;

//neatly wrapped game to be put in draw
void galaga() {
  //update background
  bg();
  //draw objects
  player.draw();
  bullets();
  enemies();
  explosions();
}

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

//render and delete explosions
void explosions() {
  for (Explosion explosion : explosions) {
    explosion.draw();
  }
  for (int i = explosions.size() - 1; i >= 0; i--) {
    Explosion explosion = explosions.get(i);
    if (explosion.done) {
      explosions.remove(i);
    }
  }
}



//game setup
void galaga_setup() {
  newStars();
  player = new Player();
}
//controller function

void keyPressed() {
  //galaga movement
  if (key == 'a' || keyCode == LEFT) player.left = true;
  if (key == 'd' || keyCode == RIGHT) player.right = true;
  if (key == 'w' || keyCode == UP) player.up = true;
  if (key == 's' || keyCode == DOWN) player.down = true;
  if (key == ' ') player.shoot();
}
void keyReleased() {
  //galaga movement
  if (key == 'a' || keyCode == LEFT) player.left = false;
  if (key == 'd' || keyCode == RIGHT) player.right = false;
  if (key == 'w' || keyCode == UP) player.up = false;
  if (key == 's' || keyCode == DOWN) player.down = false;
  if (key == ' ') player.isShooting = false;
}
