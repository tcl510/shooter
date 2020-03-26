


void setup() {
  size(1280, 720);
  galaga_setup();
}

void draw() {
  //play the game galaga;
  galaga();
  time();
}




rect[] enemies;
Player player;
//neatly wrapped game to be put in draw
void galaga() {
  //update background
  bg();
  //draw objects
  player.draw();
  println(bullets.size());
  for (Bullet bullet : bullets) {
    //print(bullet.cords);

     
     if (bullet.cords.y > 0){
         bullet.draw();
     }
   }
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    if (bullet.finished()) {
      bullets.remove(i);
    }
  }
}
//game setup
void galaga_setup() {
  newStars();
  player = new Player();
}
//controller function
void galagaController(char key) {
  //player controller
  // float playerMoveSpeed = 10;
  // if (key == 'a') player.left(true);
  // if (key == 'd') player.right(true);
  // if (key == 'w') player.up(true);
  // if (key == 's') player.down(true);
}
void keyPressed() {
  galagaController(key);
  float playerMoveSpeed = 10;
  if (key == 'a') player.left = true;
  if (key == 'd') player.right = true;
  if (key == 'w') player.up = true;
  if (key == 's') player.down = true;
  if (key == ' ') player.shoot();
}
void keyReleased() {
  float playerMoveSpeed = 10;
  if (key == 'a') player.left = false;
  if (key == 'd') player.right = false;
  if (key == 'w') player.up = false;
  if (key == 's') player.down = false;
  if (key == ' ') player.isShooting = false;
}
