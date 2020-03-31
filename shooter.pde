 //<>// //<>//


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


void mousePressed(){
  println(new PVector(mouseX, mouseY));
}


//controller function
void keyPressed() {
  //galaga movement
  if (key == 'a' || keyCode == LEFT || key == 'A') player.left = true;
  if (key == 'd' || keyCode == RIGHT || key == 'D') player.right = true;
  if (key == 'w' || keyCode == UP || key == 'W') player.up = true;
  if (key == 's' || keyCode == DOWN || key == 'S') player.down = true;
  if (key == ' ') player.shoot();
}
void keyReleased() {
  //galaga movement
  if (key == 'a' || keyCode == LEFT || key == 'A') player.left = false;
  if (key == 'd' || keyCode == RIGHT || key == 'D') player.right = false;
  if (key == 'w' || keyCode == UP || key == 'W') player.up = false;
  if (key == 's' || keyCode == DOWN || key == 'S') player.down = false;
  if (key == ' ') player.isShooting = false;
}
