


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
player player;
//neatly wrapped game to be put in draw
void galaga() {
  //update background
  bg();
  //draw objects
  player.draw();
}
//game setup
void galaga_setup(){
  newStars();
  player = new player();
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
void keyPressed(){
  galagaController(key);
  float playerMoveSpeed = 10;
  if (key == 'a') player.left = true;
  if (key == 'd') player.right = true;
  if (key == 'w') player.up = true;
  if (key == 's') player.down = true;
  if (key == ' ') player.isShooting = true;
}
void keyReleased(){
  float playerMoveSpeed = 10;
  if (key == 'a') player.left = false;
  if (key == 'd') player.right = false;
  if (key == 'w') player.up = false;
  if (key == 's') player.down = false;
  if (key == ' ') player.isShooting = false;
}
