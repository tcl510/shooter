


void setup() {
  size(672, 864);
  galaga_setup();
  frameRate(10000);
}

void draw() {
  //play the game galaga;
  galaga();
  time();
}




Enemy[] enemies = {new Enemy(100,100),
new Enemy(140, 100), new Enemy(180,100)
};
Player player;
//neatly wrapped game to be put in draw
void galaga() {
  //update background
  bg();
  //draw objects
  player.draw();
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
  //draw enemies and check for hit
  for (Enemy enemy: enemies){
    for(Bullet bullet: bullets){
     //if (rectWithRect(bullet.cords, bullet.size, enemy.cords, enemy.size)){ //<>//
       if(!enemy.hit){
       if (enemy.collision(bullet)){
       bullet.shot = true;
       enemy.hit = true;
       }
     }
    }
    //if (enemy.collision(player)){
    // //enemy.hit = true; 
    //}
    if (!enemy.hit){
     enemy.draw();
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
