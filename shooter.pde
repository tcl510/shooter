 //<>//


void setup() {
  //based on og galaga dimensions
  size(672, 864);
  //bc this frameRate is unachieveable, processing will try its best to render at highest frameRate resulting in as smooth as possible gameplay
  frameRate(10000);
  //load sound files
  loadSound();
  //galaga setup
  galaga_setup();
  
}

void draw() {
  //play the game galaga;
  galaga();
  //start the timer function(helps universially with timing the game)
  time();
}

Player player;

//game setup
void galaga_setup() {
  newStars();
  player = new Player();
}

//neatly wrapped game to be put in draw
void galaga() {
  //update background
  bg();
  //draw and update objects
  //player
  player.draw();
  //draw, render, and delete, and determain behaviour of bullets
  bullets();
  //draw, render, and delete enemies
  enemies();
  //draw, render, and delete explosions
  explosions();
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
