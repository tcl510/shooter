//<>// //<>//


void setup() {
  //based on og galaga dimensions
  size(672, 864);
  //bc this frameRate is unachieveable, processing will try its best to render at highest frameRate resulting in as smooth as possible gameplay
  frameRate(100000);
  //load sound files
  loadSound();
  //galaga setup
  galaga_setup();
}

void draw() {
  //play the game galaga;
  gameStateHandler();
  //start the timer function(helps universially with timing the game)
  time();
}

Player player;
int gameState = 1;
final int GAMESTATE_MENU = 0;
final int GAMESTATE_OPENING = 1;
final int GAMESTATE_GAME_KEYBOARD = 2;
final int GAMESTATE_GAME_WEBCAM = 3;
final int GAMESTATE_HOWTO = 4;
final int GAMESTATE_GAMEOVER = 5;

void gameStateHandler() {
  switch(gameState) {
  case GAMESTATE_MENU:
    bg();
    menu();
    break;
  case GAMESTATE_GAME_KEYBOARD:

    galagaKeyboard();
    break;
  case GAMESTATE_OPENING:
    bg();
    splashScreen();
    break;
  case GAMESTATE_GAME_WEBCAM:

    galagaWebcam();
    break;
  case GAMESTATE_HOWTO:
    bg();
    howTo();
    break;
  case GAMESTATE_GAMEOVER:
    background(0);
    gameOver();
    break;
  default:
    gameState = GAMESTATE_GAME_KEYBOARD;
    break;
  }
}

//game setup
void galaga_setup() {
  newStars();
  player = new Player();
}

//neatly wrapped game to be put in draw
void galagaKeyboard() {
  //draw and update objects
  bg();//update background
  player.draw(); //player
  bullets();  //draw, render, and delete, and determain behaviour of bullets
  enemies(); //draw, render, and delete enemies
  explosions(); //draw, render, and delete explosions
  gameGui();//draw ui
}

void galagaWebcam() {
   //draw and update objects
  updatePosByWebcam(); //updating the position of the block
  bg();//update background
  gameGui();//draw ui
  
  if (!paused){
  player.draw(); //player
  bullets();  //draw, render, and delete, and determain behaviour of bullets
  enemies(); //draw, render, and delete enemies
  explosions(); //draw, render, and delete explosions
  
  } else {
    textAlign(CENTER,CENTER);
   text("paused", width/2, height/2); 
  }
}


void mousePressed() {
  println(new PVector(mouseX, mouseY));
}


//controller function
void keyPressed() {
  //galaga movement
  if (gameState == GAMESTATE_OPENING) {

    if (key == ' ') gameState = GAMESTATE_MENU;
    return;
  }
  if (gameState == GAMESTATE_MENU) {
    if (key == 'a' || keyCode == LEFT || key == 'A') selection--;
    if (key == 'd' || keyCode == RIGHT || key == 'D') selection++;
    if (key == 'w' || keyCode == UP || key == 'W') selection++;
    if (key == 's' || keyCode == DOWN || key == 'S') selection--;
    if (selection > 2) {
      selection = 0;
    }
    if (selection < 0) {
      selection = 2;
    }
    if (key == ' ' || keyCode == ENTER) {
      gameState = GAMESTATE_GAME_KEYBOARD + selection;
      restartGame();
    };
    return;
  }
  if (gameState == GAMESTATE_HOWTO) {
    if (key == ' ' || keyCode == ENTER) gameState = GAMESTATE_MENU;
    return;
  }
  if (gameState == GAMESTATE_GAME_KEYBOARD) {
    if (key == 'a' || keyCode == LEFT || key == 'A') player.left = true;
    if (key == 'd' || keyCode == RIGHT || key == 'D') player.right = true;
    if (key == 'w' || keyCode == UP || key == 'W') player.up = true;
    if (key == 's' || keyCode == DOWN || key == 'S') player.down = true;
    if (key == ' ') player.shoot();
  }
  if (gameState == GAMESTATE_GAME_WEBCAM) {
    if (key == ' ') player.shoot();
  }
  if (gameState == GAMESTATE_GAMEOVER) {
    if (key == ' ') {
      sad.stop();
      gameState = GAMESTATE_OPENING;
    };
  }
}
void keyReleased() {
  //galaga movement
  if (gameState == GAMESTATE_GAME_KEYBOARD) {
    if (key == 'a' || keyCode == LEFT || key == 'A') player.left = false;
    if (key == 'd' || keyCode == RIGHT || key == 'D') player.right = false;
    if (key == 'w' || keyCode == UP || key == 'W') player.up = false;
    if (key == 's' || keyCode == DOWN || key == 'S') player.down = false;
    if (key == ' ') player.isShooting = false;
  }
  if (gameState == GAMESTATE_GAME_WEBCAM) {
    if (key == ' ') player.isShooting = false;
  }
}
void restartGame() {
  if (gameState == GAMESTATE_GAME_WEBCAM){
    loadWebCam();
  }
  currentWave = newWave(0);
  score = 0;
  level = 1;
  lives = 3; 
  player = new Player();
  bullets = new ArrayList<Bullet>();
  enemyBullets = new ArrayList<Bullet>();
  explosions = new ArrayList<Explosion>();
}
