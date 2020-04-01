import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.Rectangle; 
import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class shooter extends PApplet {

 //<>// //<>//


public void setup() {
  //based on og galaga dimensions
  
  //bc this frameRate is unachieveable, processing will try its best to render at highest frameRate resulting in as smooth as possible gameplay
  frameRate(10000);
  //load sound files
  loadSound();
  //galaga setup
  galaga_setup();

}

public void draw() {
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

public void gameStateHandler(){
  switch(gameState){
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
    default:
      gameState = GAMESTATE_GAME_KEYBOARD;
      break;
  }
}

//game setup
public void galaga_setup() {
  newStars();
  player = new Player();
}

//neatly wrapped game to be put in draw
public void galagaKeyboard() {
  //draw and update objects
  bg();//update background
  player.draw(); //player
  bullets();  //draw, render, and delete, and determain behaviour of bullets
  enemies(); //draw, render, and delete enemies
  explosions(); //draw, render, and delete explosions
  gameGui();//draw ui
}

public void galagaWebcam(){
  //draw and update objects
  bg();//update background
  player.draw(); //player
  bullets();  //draw, render, and delete, and determain behaviour of bullets
  enemies(); //draw, render, and delete enemies
  explosions(); //draw, render, and delete explosions
  gameGui();//draw ui
}


public void mousePressed(){
  println(new PVector(mouseX, mouseY));
}


//controller function
public void keyPressed() {
  //galaga movement
  if (gameState == GAMESTATE_OPENING){
    if (key == ' ') gameState = GAMESTATE_MENU;
    return;
  }
  if (gameState == GAMESTATE_MENU){
    if (key == 'a' || keyCode == LEFT || key == 'A') selection--;
    if (key == 'd' || keyCode == RIGHT || key == 'D') selection++;
    if (key == 'w' || keyCode == UP || key == 'W') selection++;
    if (key == 's' || keyCode == DOWN || key == 'S') selection--;
    if (selection > 2){
      selection = 0;
    }
    if (selection < 0){
      selection = 2;
    }
    if (key == ' ' || keyCode == ENTER) gameState = GAMESTATE_GAME_KEYBOARD + selection;
    return;
  }
  if (gameState == GAMESTATE_HOWTO){
    if (key == ' ' || keyCode == ENTER) gameState = GAMESTATE_MENU;
    return;
  }
  if (gameState == GAMESTATE_GAME_KEYBOARD){
  if (key == 'a' || keyCode == LEFT || key == 'A') player.left = true;
  if (key == 'd' || keyCode == RIGHT || key == 'D') player.right = true;
  if (key == 'w' || keyCode == UP || key == 'W') player.up = true;
  if (key == 's' || keyCode == DOWN || key == 'S') player.down = true;
  if (key == ' ') player.shoot();
}
if (gameState == GAMESTATE_GAME_WEBCAM){
  if (key == ' ') player.shoot();
}
}
public void keyReleased() {
  //galaga movement
  if (gameState == GAMESTATE_GAME_KEYBOARD){
  if (key == 'a' || keyCode == LEFT || key == 'A') player.left = false;
  if (key == 'd' || keyCode == RIGHT || key == 'D') player.right = false;
  if (key == 'w' || keyCode == UP || key == 'W') player.up = false;
  if (key == 's' || keyCode == DOWN || key == 'S') player.down = false;
  if (key == ' ') player.isShooting = false;
}
if (gameState == GAMESTATE_GAME_WEBCAM){
if (key == ' ') player.isShooting = false;
}
}
//array of stars
Star[] stars; //<>// //<>//

//generate new stars
public void newStars(){
  //star amount
  int starAmount = 100;
  //init stars
  stars = new Star[starAmount];
  for(int i=0; i< stars.length; i++){
    //populate array with new stars
    stars[i] = new Star();
  }
}
//background rendering (bg for background)
public void bg() {
  //clear the background to black
  background(0);
  //loop thru list of stars
  for(Star i: stars){
    //draw all the stars
    i.draw();
  }
}



float speed = 25;

public class Star {
  int timeNow;
  float intensity;
  float posx, posy;
  int r,g,b;


  float fallRate = random(0.1f, 9.81f);

  Star() {
    //random location
    this.posx = (int) random(0, width);
    this.posy = (int) random(0, height);
    //random color rgb
    this.r = (int) random(0, 2);
    this.g = (int) random(0, 2);
    this.b = (int) random(0, 2);
    //random intensity
    this.intensity = random(0,2);

  }
  public void draw() {
    //fall at their own rate
    gravity();
    //if time changed then brightness changes
    if (timeNow != (int)timeCount){
      //basically change into a random brightness each second
      intensity= random(0, 2);

    }
    //depending on the color adjust brightness
    fill(r*255, g*255, b*255 * intensity);

    noStroke();
    rectMode(CENTER);
    rect(posx, posy, 2, 2);

    //update time
    updateTime();
  }
  public void updateTime() {
    timeNow = (int)timeCount;
    // println(timeNow);
  }
  public void gravity() {
    //if position is bigger then the height limit reset
    if (posy > height){
      posy = 0;
    }
    //update position
    posy += fallRate * speed * 1/frameRate;
  }
}
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Bullet> enemyBullets = new ArrayList<Bullet>();

public void bullets() {

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
    println("enemyBullets");
  }
  //delete bullets
  for (int i = enemyBullets.size() - 1; i >= 0; i--) {
    Bullet bullet = enemyBullets.get(i);
    if (bullet.finished()) {
      enemyBullets.remove(i);
    }
  }

}


class Bullet extends ellipse {
  float bulletVelocity = 10;

  Bullet(PVector start) {
    super(new PVector(10, 10), start);
    this.vel = new PVector(0, -bulletVelocity);
  }
  boolean shot = false;

  //check to see if the bullet is out of bounds or hit something, if either finished is true
  public boolean finished() {
    if (cords.y <= 0) {
      return true;
    }
    ////if exploded
    if (shot) {
      return true;
    }

    return false;
  }

  public void draw() {
    noStroke();
    super.draw();
  }
}
int waves = 0;

public void enemies() {
  //draw enemies and check for hit
  boolean waveFinished = true;
  for (Enemy enemy : currentWave) {
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
          score += 1;
        }
      }
    }
    if (!enemy.hit) {
      waveFinished = false;
      enemy.draw();
    }
  }
  if (waveFinished) {
    waves = PApplet.parseInt(random(4));
    currentWave = newWave(waves);
  }
}
static final PVector defaultEnemySize = new PVector(20, 20);

float spacing = 40;
Enemy[] currentWave = newWave(3);
public Enemy[] newWave(int waveCode) {
  switch(waveCode) {
  case 0:
    return new Enemy[] {
      new Enemy(0, 400, 100, 100, INTRO_1),
      new Enemy(-40, 400, 140, 100, INTRO_1),
      new Enemy(-80, 400, 180, 100, INTRO_1),
      new Enemy(-120, 400, 220, 100, INTRO_1),
      new Enemy(-160, 400, 260, 100, INTRO_1),
      new Enemy(-200, 400, 300, 100, INTRO_1),
      new Enemy(-240, 400, 340, 100, INTRO_1),
      new Enemy(-280, 400, 380, 100, INTRO_1),
      new Enemy(-320, 400, 420, 100, INTRO_1),
      new Enemy(-360, 400, 460, 100, INTRO_1),
      new Enemy(-400, 400, 500, 100, INTRO_1),
      new Enemy(-440, 400, 540, 100, INTRO_1),

      new Enemy(672+440, 400, 80, 150, INTRO_1_FLIPPED),
      new Enemy(672+400, 400, 120, 150, INTRO_1_FLIPPED),
      new Enemy(672+360, 400, 160, 150, INTRO_1_FLIPPED),
      new Enemy(672+320, 400, 200, 150, INTRO_1_FLIPPED),
      new Enemy(672+280, 400, 240, 150, INTRO_1_FLIPPED),
      new Enemy(672+240, 400, 280, 150, INTRO_1_FLIPPED),
      new Enemy(672+200, 400, 320, 150, INTRO_1_FLIPPED),
      new Enemy(672+160, 400, 360, 150, INTRO_1_FLIPPED),
      new Enemy(672+120, 400, 400, 150, INTRO_1_FLIPPED),
      new Enemy(672+80, 400, 440, 150, INTRO_1_FLIPPED),
      new Enemy(672+40, 400, 480, 150, INTRO_1_FLIPPED),
      new Enemy(672, 400, 520, 150, INTRO_1_FLIPPED),

      new Enemy(672/2 - 40, 0, 100, 200, INTRO_2),
      new Enemy(672/2 - 40, -40, 140, 200, INTRO_2),
      new Enemy(672/2 - 40, -80, 180, 200, INTRO_2),
      new Enemy(672/2 - 40, -120, 220, 200, INTRO_2),
      new Enemy(672/2 - 40, -160, 260, 200, INTRO_2),
      new Enemy(672/2 - 40, -200, 300, 200, INTRO_2),
      new Enemy(672/2 - 40, -240, 340, 200, INTRO_2),
      new Enemy(672/2 - 40, -280, 380, 200, INTRO_2),
      new Enemy(672/2 - 40, -320, 420, 200, INTRO_2),
      new Enemy(672/2 - 40, -360, 460, 200, INTRO_2),
      new Enemy(672/2 - 40, -400, 500, 200, INTRO_2),
      new Enemy(672/2 - 40, -440, 540, 200, INTRO_2),

      new Enemy(672/2 + 40, -440, 100-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, -400, 140-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, -360, 180-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, -320, 220-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, -280, 260-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, -240, 300-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, -200, 340-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, -160, 380-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, -120, 420-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, -80, 460-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, -40, 500-20, 250, INTRO_2_FLIPPED),
      new Enemy(672/2 + 40, 0, 540-20, 250, INTRO_2_FLIPPED),
    };
    case 1:
      return new Enemy[] {
        new Enemy(0, 600, 100, 100, INTRO_3),
        new Enemy(-40, 600, 140, 100, INTRO_3),
        new Enemy(-80, 600, 180, 100, INTRO_3),
        new Enemy(-120, 600, 220, 100, INTRO_3),
        new Enemy(-160, 600, 260, 100, INTRO_3),
        new Enemy(-200, 600, 300, 100, INTRO_3),
        new Enemy(-240, 600, 340, 100, INTRO_3),
        new Enemy(-280, 600, 380, 100, INTRO_3),
        new Enemy(-320, 600, 420, 100, INTRO_3),
        new Enemy(-360, 600, 460, 100, INTRO_3),
        new Enemy(-400, 600, 500, 100, INTRO_3),
        new Enemy(-440, 600, 540, 100, INTRO_3),

        new Enemy(672+440, 600, 80, 150, INTRO_3_FLIPPED),
        new Enemy(672+400, 600, 120, 150, INTRO_3_FLIPPED),
        new Enemy(672+360, 600, 160, 150, INTRO_3_FLIPPED),
        new Enemy(672+320, 600, 200, 150, INTRO_3_FLIPPED),
        new Enemy(672+280, 600, 240, 150, INTRO_3_FLIPPED),
        new Enemy(672+240, 600, 280, 150, INTRO_3_FLIPPED),
        new Enemy(672+200, 600, 320, 150, INTRO_3_FLIPPED),
        new Enemy(672+160, 600, 360, 150, INTRO_3_FLIPPED),
        new Enemy(672+120, 600, 400, 150, INTRO_3_FLIPPED),
        new Enemy(672+80, 600, 440, 150, INTRO_3_FLIPPED),
        new Enemy(672+40, 600, 480, 150, INTRO_3_FLIPPED),
        new Enemy(672, 600, 520, 150, INTRO_3_FLIPPED),

      };
      case 2:
      return new Enemy[] {
        new Enemy(0, 400, 100, 100, INTRO_3),
        new Enemy(-40, 400, 140, 100, INTRO_3),
        new Enemy(-80, 400, 180, 100, INTRO_3),
        new Enemy(-120, 400, 220, 100, INTRO_3),
        new Enemy(-160, 400, 260, 100, INTRO_3),
        new Enemy(-200, 400, 300, 100, INTRO_3),
        new Enemy(-240, 400, 340, 100, INTRO_3),
        new Enemy(-280, 400, 380, 100, INTRO_3),
        new Enemy(-320, 400, 420, 100, INTRO_3),
        new Enemy(-360, 400, 460, 100, INTRO_3),
        new Enemy(-400, 400, 500, 100, INTRO_3),
        new Enemy(-440, 400, 540, 100, INTRO_3),
        new Enemy(spacing * -12, 400, 100, 200, INTRO_3),
        new Enemy(spacing * -13, 400, 140, 200, INTRO_3),
        new Enemy(spacing * -14, 400, 180, 200, INTRO_3),
        new Enemy(spacing * -15, 400, 220, 200, INTRO_3),
        new Enemy(spacing * -16, 400, 260, 200, INTRO_3),
        new Enemy(spacing * -17, 400, 300, 200, INTRO_3),
        new Enemy(spacing * -18, 400, 340, 200, INTRO_3),
        new Enemy(spacing * -19, 400, 380, 200, INTRO_3),
        new Enemy(spacing * -20, 400, 420, 200, INTRO_3),
        new Enemy(spacing * -21, 400, 460, 200, INTRO_3),
        new Enemy(spacing * -22, 400, 500, 200, INTRO_3),
        new Enemy(spacing * -23, 400, 540, 200, INTRO_3),

        new Enemy(672+900, 400, 100-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+880, 400, 140-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+840, 400, 180-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+800, 400, 220-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+760, 400, 260-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+720, 400, 300-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+680, 400, 340-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+640, 400, 380-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+600, 400, 420-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+560, 400, 460-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+520, 400, 500-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+480, 400, 540-20, 250, INTRO_3_FLIPPED),
        new Enemy(672+440, 400, 80, 150, INTRO_3_FLIPPED),
        new Enemy(672+400, 400, 120, 150, INTRO_3_FLIPPED),
        new Enemy(672+360, 400, 160, 150, INTRO_3_FLIPPED),
        new Enemy(672+320, 400, 200, 150, INTRO_3_FLIPPED),
        new Enemy(672+280, 400, 240, 150, INTRO_3_FLIPPED),
        new Enemy(672+240, 400, 280, 150, INTRO_3_FLIPPED),
        new Enemy(672+200, 400, 320, 150, INTRO_3_FLIPPED),
        new Enemy(672+160, 400, 360, 150, INTRO_3_FLIPPED),
        new Enemy(672+120, 400, 400, 150, INTRO_3_FLIPPED),
        new Enemy(672+80, 400, 440, 150, INTRO_3_FLIPPED),
        new Enemy(672+40, 400, 480, 150, INTRO_3_FLIPPED),
        new Enemy(672, 400, 400, 150, INTRO_3_FLIPPED),

      };
      case 3:
      return new Enemy[] {
        new Enemy(0, 400, 100, 100, INTRO_4),
        new Enemy(-40, 400, 140, 100, INTRO_4),
        new Enemy(-80, 400, 180, 100, INTRO_4),
        new Enemy(-120, 400, 220, 100, INTRO_4),
        new Enemy(-160, 400, 260, 100, INTRO_4),
        new Enemy(-200, 400, 300, 100, INTRO_4),
        new Enemy(-240, 400, 340, 100, INTRO_4),
        new Enemy(-280, 400, 380, 100, INTRO_4),
        new Enemy(-320, 400, 420, 100, INTRO_4),
        new Enemy(-360, 400, 460, 100, INTRO_4),
        new Enemy(-400, 400, 500, 100, INTRO_4),
        new Enemy(-440, 400, 540, 100, INTRO_4),

        new Enemy(672+440, 400, 80, 150, INTRO_4_FLIPPED),
        new Enemy(672+400, 400, 120, 150, INTRO_4_FLIPPED),
        new Enemy(672+360, 400, 160, 150, INTRO_4_FLIPPED),
        new Enemy(672+320, 400, 200, 150, INTRO_4_FLIPPED),
        new Enemy(672+280, 400, 240, 150, INTRO_4_FLIPPED),
        new Enemy(672+240, 400, 280, 150, INTRO_4_FLIPPED),
        new Enemy(672+200, 400, 320, 150, INTRO_4_FLIPPED),
        new Enemy(672+160, 400, 360, 150, INTRO_4_FLIPPED),
        new Enemy(672+120, 400, 400, 150, INTRO_4_FLIPPED),
        new Enemy(672+80, 400, 440, 150, INTRO_4_FLIPPED),
        new Enemy(672+40, 400, 480, 150, INTRO_4_FLIPPED),
        new Enemy(672, 400, 520, 150, INTRO_4_FLIPPED),

        new Enemy(672/2 - 40, 0, 100, 200, INTRO_4),
        new Enemy(672/2 - 40, -40, 140, 200, INTRO_4),
        new Enemy(672/2 - 40, -80, 180, 200, INTRO_4),
        new Enemy(672/2 - 40, -120, 220, 200, INTRO_4),
        new Enemy(672/2 - 40, -160, 260, 200, INTRO_4),
        new Enemy(672/2 - 40, -200, 300, 200, INTRO_4),
        new Enemy(672/2 - 40, -240, 340, 200, INTRO_4),
        new Enemy(672/2 - 40, -280, 380, 200, INTRO_4),
        new Enemy(672/2 - 40, -320, 420, 200, INTRO_4),
        new Enemy(672/2 - 40, -360, 460, 200, INTRO_4),
        new Enemy(672/2 - 40, -400, 500, 200, INTRO_4),
        new Enemy(672/2 - 40, -440, 540, 200, INTRO_4),

        new Enemy(672/2 + 40, -440, 100-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, -400, 140-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, -360, 180-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, -320, 220-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, -280, 260-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, -240, 300-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, -200, 340-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, -160, 380-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, -120, 420-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, -80, 460-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, -40, 500-20, 250, INTRO_4_FLIPPED),
        new Enemy(672/2 + 40, 0, 540-20, 250, INTRO_4_FLIPPED),
      };


  default:
  return new Enemy[] {
    new Enemy(0, 400, 100, 100, INTRO_1),
    new Enemy(-40, 400, 140, 100, INTRO_1),
    new Enemy(-80, 400, 180, 100, INTRO_1),
    new Enemy(-120, 400, 220, 100, INTRO_1),
    new Enemy(-160, 400, 260, 100, INTRO_1),
    new Enemy(-200, 400, 300, 100, INTRO_1),
    new Enemy(-240, 400, 340, 100, INTRO_1),
    new Enemy(-280, 400, 380, 100, INTRO_1),
    new Enemy(-320, 400, 420, 100, INTRO_1),
    new Enemy(-360, 400, 460, 100, INTRO_1),
    new Enemy(-400, 400, 500, 100, INTRO_1),
    new Enemy(-440, 400, 540, 100, INTRO_1),

    new Enemy(672+440, 400, 80, 150, INTRO_1_FLIPPED),
    new Enemy(672+400, 400, 120, 150, INTRO_1_FLIPPED),
    new Enemy(672+360, 400, 160, 150, INTRO_1_FLIPPED),
    new Enemy(672+320, 400, 200, 150, INTRO_1_FLIPPED),
    new Enemy(672+280, 400, 240, 150, INTRO_1_FLIPPED),
    new Enemy(672+240, 400, 280, 150, INTRO_1_FLIPPED),
    new Enemy(672+200, 400, 320, 150, INTRO_1_FLIPPED),
    new Enemy(672+160, 400, 360, 150, INTRO_1_FLIPPED),
    new Enemy(672+120, 400, 400, 150, INTRO_1_FLIPPED),
    new Enemy(672+80, 400, 440, 150, INTRO_1_FLIPPED),
    new Enemy(672+40, 400, 480, 150, INTRO_1_FLIPPED),
    new Enemy(672, 400, 520, 150, INTRO_1_FLIPPED),

    new Enemy(672/2 - 40, 0, 100, 200, INTRO_2),
    new Enemy(672/2 - 40, -40, 140, 200, INTRO_2),
    new Enemy(672/2 - 40, -80, 180, 200, INTRO_2),
    new Enemy(672/2 - 40, -120, 220, 200, INTRO_2),
    new Enemy(672/2 - 40, -160, 260, 200, INTRO_2),
    new Enemy(672/2 - 40, -200, 300, 200, INTRO_2),
    new Enemy(672/2 - 40, -240, 340, 200, INTRO_2),
    new Enemy(672/2 - 40, -280, 380, 200, INTRO_2),
    new Enemy(672/2 - 40, -320, 420, 200, INTRO_2),
    new Enemy(672/2 - 40, -360, 460, 200, INTRO_2),
    new Enemy(672/2 - 40, -400, 500, 200, INTRO_2),
    new Enemy(672/2 - 40, -440, 540, 200, INTRO_2),

    new Enemy(672/2 + 40, -440, 100-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, -400, 140-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, -360, 180-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, -320, 220-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, -280, 260-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, -240, 300-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, -200, 340-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, -160, 380-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, -120, 420-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, -80, 460-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, -40, 500-20, 250, INTRO_2_FLIPPED),
    new Enemy(672/2 + 40, 0, 540-20, 250, INTRO_2_FLIPPED),
  };
  }
}


final static int INTRO_1 = 1;
final static int INTRO_1_FLIPPED = 2;
final static int INTRO_2 = 3;
final static int INTRO_2_FLIPPED = 4;
final static int INTRO_3 = 5;
final static int INTRO_3_FLIPPED = 6;
final static int INTRO_4 = 7;
final static int INTRO_4_FLIPPED = 8;

class Enemy extends rect {



  boolean hit = false;
  Pattern entry = new Pattern();

  Enemy(float startX, float startY, float endX, float endY, int type) {
    super(defaultEnemySize, startX, startY);
    switch(type) {
    case INTRO_1:
      entry = new PatternA(new PVector(startX, startY), new PVector(endX, endY), this);
      break;
    case INTRO_1_FLIPPED:
      entry = new PatternB(new PVector(startX, startY), new PVector(endX, endY), this);
      break;
    case INTRO_2:
      entry = new PatternC(new PVector(startX, startY), new PVector(endX, endY), this);
      break;
    case INTRO_2_FLIPPED:
      entry = new PatternD(new PVector(startX, startY), new PVector(endX, endY), this);
      break;
    case INTRO_3:
      entry = new PatternE(new PVector(startX, startY), new PVector(endX, endY), this);
      break;
    case INTRO_3_FLIPPED:
      entry = new PatternF(new PVector(startX, startY), new PVector(endX, endY), this);
      break;
    case INTRO_4:
      entry = new PatternG(new PVector(startX, startY), new PVector(endX, endY), this);
      break;
    case INTRO_4_FLIPPED:
      entry = new PatternH(new PVector(startX, startY), new PVector(endX, endY), this);
      break;
    }
  }

  public void draw() {
    if (entry != null) {
      //mark
      this.vel = entry.getVel();
      // int diceRoll = random(1);
      if (PApplet.parseInt(random(150)) == 0){
        enemyBullets.add(new Bullet(cords.copy()));
      }
    }
    super.draw();
  }
}

class Pattern {
  ArrayList<Movement> movementList = new ArrayList<Movement>();
  Enemy attachment;
  Movement[] pattern = {new Movement()};
  int step = 0;
  boolean done = false;
  public boolean checkDone() {
    return done;
  }

  public PVector getVel() {
    if (pattern[step].checkDone()) {
      step++;
      if (step > pattern.length-1) {
        step = constrain(step, 0, pattern.length-1);
        if (!done) {
          done = true;
          return pattern[step].getCorrection();
        }
        return new PVector(0, 0);
      }
      step = constrain(step, 0, pattern.length-1);
      pattern[step].startPos = attachment.cords.copy();
    };
    return pattern[step].getVel();
  }
}

class PatternA extends Pattern {


  PatternA(PVector startPos, PVector endPos, Enemy attachment) {
    movementList.add(new Straight(startPos, new PVector(0, 400), Movement.DEFAULT_SPEED, attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(200, 600), attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS, Loop.LEFT, 130, attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), endPos, attachment));
    this.pattern = movementList.toArray(new Movement[movementList.size()]);
    this.attachment = attachment;
  }
}

class PatternB extends Pattern {


  PatternB(PVector startPos, PVector endPos, Enemy attachment) {
    movementList.add(new Straight(startPos, new PVector(672, 400), Movement.DEFAULT_SPEED, attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(672-200, 600), attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS, Loop.RIGHT, 130, attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), endPos, attachment));
    this.pattern = movementList.toArray(new Movement[movementList.size()]);
    this.attachment = attachment;
  }
}

class PatternC extends Pattern {

  PatternC(PVector startPos, PVector endPos, Enemy attachment) {
    movementList.add(new Straight(startPos, new PVector(672/2 - 40, 600), Movement.DEFAULT_SPEED, attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS, Loop.RIGHT, 60, attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), endPos, attachment));
    this.pattern = movementList.toArray(new Movement[movementList.size()]);
    this.attachment = attachment;
  }
}

class PatternD extends Pattern {

  PatternD(PVector startPos, PVector endPos, Enemy attachment) {
    movementList.add(new Straight(startPos, new PVector(672/2 + 40, 600), Movement.DEFAULT_SPEED, attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS, Loop.LEFT, 60, attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), endPos, attachment));
    this.pattern = movementList.toArray(new Movement[movementList.size()]);
    this.attachment = attachment;
  }
}

class PatternE extends Pattern {

  PatternE(PVector startPos, PVector endPos, Enemy attachment) {
    movementList.add(new Straight(startPos, new PVector(300, 500), Movement.DEFAULT_SPEED, attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS, Loop.RIGHT, 100, attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS+20, Loop.LEFT, 100, attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS+40, Loop.LEFT, 100, attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(672/2, 300), attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), endPos, attachment));
    this.pattern = movementList.toArray(new Movement[movementList.size()]);
    this.attachment = attachment;
  }
}

class PatternF extends Pattern {

  PatternF(PVector startPos, PVector endPos, Enemy attachment) {
    movementList.add(new Straight(startPos, new PVector(672-300, 500), Movement.DEFAULT_SPEED, attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS, Loop.LEFT, 100, attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS+20, Loop.RIGHT, 100, attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS+40, Loop.RIGHT, 100, attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(672/2, 300), attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), endPos, attachment));
    this.pattern = movementList.toArray(new Movement[movementList.size()]);
    this.attachment = attachment;
  }
}
class PatternG extends Pattern {

  PatternG(PVector startPos, PVector endPos, Enemy attachment) {
      movementList.add(new Straight(startPos, new PVector(672-300, 500), Movement.DEFAULT_SPEED, attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(30, 500), attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(100, 450), attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(30, 400), attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(100, 350), attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(30, 300), attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), endPos, attachment));
      this.pattern = movementList.toArray(new Movement[movementList.size()]);
      this.attachment = attachment;
  }


}

class PatternH extends Pattern {

  PatternH(PVector startPos, PVector endPos, Enemy attachment) {
      movementList.add(new Straight(startPos, new PVector(300, 500), Movement.DEFAULT_SPEED, attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(672-30, 500), attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(672-100, 450), attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(672-30, 400), attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(672-100, 350), attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(672-30, 300), attachment));
      movementList.add(new Straight(movementList.get(movementList.size()-1), endPos, attachment));
      this.pattern = movementList.toArray(new Movement[movementList.size()]);
      this.attachment = attachment;
  }



}

class Movement {
  public final static float DEFAULT_SPEED = 3;
  PVector startPos, endPos;
  PVector velocity = new PVector(0, 0);
  boolean done = false;
  float magnitude;
  PVector currentPos;


  Movement() {
  }

  Movement(Enemy attachment) {
    this.currentPos = attachment.cords;
  }

  public PVector getStarting() {
    return startPos;
  };
  public PVector getEnd() {
    return endPos;
  };
  public PVector getVel() {
    return velocity;
  };

  public boolean checkDone() {
    return done;
  }
  public PVector getCorrection() {
    PVector temp = PVector.sub(currentPos, endPos);
    temp.mult(-1);
    return temp;
  }
}


class Straight extends Movement {
  Boolean firstTime = true;

  Straight(PVector startPos, PVector endPos, float magnitude, Enemy attachment) {
    super(attachment);
    this.startPos = startPos;
    this.endPos = endPos;
    this.magnitude = magnitude;
    this.velocity = PVector.sub(startPos, endPos);
    velocity.setMag(-magnitude);
  }
  Straight(Movement previous, PVector endPos, Enemy attachment) {
    this(previous.endPos, endPos, previous.magnitude, attachment);
  }

  public PVector getVel() {
    if (firstTime) {
      velocity = PVector.sub(currentPos, endPos);
      velocity.setMag(-magnitude);
      firstTime = false;
    }
    return velocity;
  }
  public boolean checkDone() {

    if (startPos.dist(currentPos) >= startPos.dist(endPos)) {
      done = true;
      return true;
    }
    return done;
  }
}


class Loop extends Movement {
  public final static float DEFAULT_RADIUS = 100;
  PVector centerPoint;
  float t;
  float radius;
  float loopEnd;
  float direction;
  public final static float RIGHT = 1;
  public final static float LEFT = -1;
  boolean firstTime = true;

  Loop(PVector startPos, PVector velocity, float radius, float direction, float limit, float magnitude, Enemy attachment) {
    super(attachment);
    this.centerPoint = velocity.copy();
    centerPoint.setMag(-radius);
    centerPoint.rotate(PI + (HALF_PI * direction));
    centerPoint.add(startPos);
    this.t = velocity.heading() + (PI + (HALF_PI * direction));
    this.loopEnd = t + (TWO_PI/100 * limit * direction);

    this.startPos = startPos;
    this.endPos = pointInCircle(loopEnd);

    this.direction = direction;
    this.magnitude = magnitude;

    this.radius = radius;
    this.velocity = velocity.copy();
    velocity.setMag(-magnitude);
  }
  Loop(Movement previous, float radius, float direction, float limit, Enemy attachment) {
    this(previous.endPos.copy(), previous.velocity.copy(), radius, direction, limit, previous.magnitude, attachment);
  }

  public PVector pointInCircle(float t) {
    return new PVector (centerPoint.x + radius*cos(t), centerPoint.y + radius*sin(t));
  }
  public PVector getVel() {
    if (firstTime) {
      centerPoint = velocity.copy();
      centerPoint.setMag(-radius);
      centerPoint.rotate(PI + (HALF_PI * direction));
      centerPoint.add(startPos);//this is it
      firstTime = false;
    }

    t -= (-direction)*(magnitude/radius);
    velocity.x = -(currentPos.x - (centerPoint.x+radius*cos(t)));
    velocity.y = -(currentPos.y - (centerPoint.y+radius*sin(t)));
    return velocity;
  }
  public boolean checkDone() {
    if (t < loopEnd && direction == 1) {
      return false;
    }
    if (t > loopEnd && direction == -1) {
      return false;
    }
    endPos = currentPos.copy();
    done = true;
    return true;
  }
}
ArrayList<Explosion> explosions = new ArrayList<Explosion>();

//render and delete explosions
public void explosions() {
  //draw all explosions
  for (Explosion explosion : explosions) {
    explosion.draw();
  }
  //check if explosion is exploded, if its expoded purge from the list so it stop rendering the same explosion
  for (int i = explosions.size() - 1; i >= 0; i--) {
    Explosion explosion = explosions.get(i);
    if (explosion.done) {
      explosions.remove(i);
    }
  }
}


public class Explosion {
  PVector cords;
  float size = 1;
  float speed = 0.05f;
  boolean done = false;
  float scale;


//constructors
  Explosion(PVector cords, float size) {
    this.cords = cords;
    this.size = size;
  }

  Explosion(float x, float y, float size) {
    this.cords = new PVector(x, y);
    this.size = size;
  }
  Explosion(PVector cords){
   this.cords = cords;
  }
  Explosion(object object){
   this.cords = object.cords;
   this.scale = object.size.x;
  }

  float alpha = 200;

  public void draw() {
    //in essense, increase the scale till a certain point
    if (size < scale*2) {

      //increase the size
      size *= speed / (1/frameRate);

      drawRing(255*(size/scale*2));
    } else {
      //once the explosion is a certain size, fade the explosion
      if (alpha*size > 0){
        drawRing(alpha);
      alpha -= 15/(60/frameRate);
      } else {
      done = true;
      }
    }
  }
  public void drawRing(float alpha){
      //draw the explosion
      stroke(alpha);
      fill(255,255,255, alpha);
      strokeWeight(10);
      //draw explosion ring
      ellipse(cords.x, cords.y, size, size);
      //randomise explosion
      ellipse(cords.x + random(0,3), cords.y + random(0,3), size, size);
  }
}



/*
converters:

converts the java rectangle format to my format of a rectangle
*/
public rect[] rectangleToRect(Rectangle[] rectangle_array) {
  //call arraylist rectlist
  ArrayList<rect> rectList = new ArrayList<rect>();
  for (Rectangle i : rectangle_array) {
    //adds to rectlist the rectangle in my custom rect form
    rectList.add(new rect(i));
  }
  return rectList.toArray(new rect[rectList.size()]);
}
//same as rectToRect but with convert the rectangle to custom ellipse format
public ellipse[] rectangleToEllipse(Rectangle[] rectangle_array) {
  ArrayList<ellipse> rectList = new ArrayList<ellipse>();

  for (Rectangle i : rectangle_array) {
    rectList.add(new ellipse(i));
  }
  return rectList.toArray(new ellipse[rectList.size()]);
}



/*
Collision calculations

calculate the collision of different shapes
*/
//calculate the collision of two circles
public boolean ellipseWithEllipse(PVector cord, PVector size, PVector otherCord, PVector otherSize) {
  //do boil it down, the collider adds the radius of both of the circles, and if the position of the two circles are smaller then the sum of the radii then it would be overlapping.
  //using the PVector.dist function, i can find the distance bewteen the two circles
  if (PVector.dist(cord, otherCord) < size.x+otherSize.x) {
    println("collided");
    return true;
  }
  return false;
}
//calculate the collision of two rectangles
public boolean rectWithRect(PVector cord, PVector size, PVector otherCord, PVector otherSize) {
  //to sum it up first begin by finding the cords of all of the 4 corners.
  PVector[] corners = findCorners(cord, size);
  PVector[] other_corners = findCorners(otherCord, otherSize);
  //then depending on which rectangle is bigger, have the bigger compared
  if (size.mag() > otherSize.mag()) {
    for (PVector i : other_corners) {
      //check all corners and see if it is within the bounds of the box
      if (i.x < corners[0].x && i.x > corners[3].x) {
        if (i.y < corners[0].y && i.y > corners[1].y) {
          println("collided");
          return true;
        }
      }
    }
  } else {
    //same as above except the bigger is the subject
    for (PVector i : corners) {
      if (i.x < other_corners[0].x && i.x > other_corners[3].x) {
        println("collidedx");
        if (i.y < other_corners[0].y && i.y > other_corners[1].y) {
          println("collided");
          return true;
        }
      }
    }
  }
  return false;
}

public boolean rectWithEllipse(PVector boxCord, PVector boxSize, PVector ellipseCord, PVector ellipseSize) {
  //the below commented code is commented out because of its resouce intensive cos and atan functions
  //define bounds of this box
  //PVector[] corners = findCorners(boxCord, boxSize);
  //check if any point is inside the radius

  //remember in this case, we only have circles so far, so x or y would be the same and both would be radius

  //for (PVector i : corners) {
  //  float distance = i.dist(ellipseCord);
  //  //if the point's distance from the center is smaller then the radius then there is a collision
  //  if (distance < ellipseSize.x/2) {
  //    println("collided");
  //    return true;
  //  }
  //}

  //float angle = atan((boxSize.x/2)/(boxSize.y/2));
  //float x = cos(angle) * boxSize.x/2;

  // clamp(value, min, max) - limits value to the range min..max

  // Find the closest point to the circle within the rectangle, by constraing and limiting the range
  float closestX = constrain(ellipseCord.x, boxCord.x + boxSize.x/2, boxCord.x - boxSize.x/2);
  float closestY = constrain(ellipseCord.y, boxCord.y + boxSize.y/2, boxCord.y - boxSize.y/2);
  //therefore we can find the closest point
  PVector closest = new PVector(closestX, closestY);

  // Calculate the distance between the circle's center and this closest point, and using the comparsion and theory similar to the ellipse with ellipse we can find the collision
  return PVector.dist(boxCord, ellipseCord) <= PVector.dist(closest, boxCord) + ellipseSize.x/2;
}

//same function with different inputs
public boolean rectWithEllipse(rect rect, ellipse ellipse) {
  return rectWithEllipse(rect.cords, rect.size, ellipse.cords, ellipse.size);
}


public PVector[] findCorners(PVector cords, PVector size) {
  PVector[] corners = {
    //top right corner
    new PVector(cords.x + size.x/2, cords.y + size.y/2),
    //bottom left corner
    new PVector(cords.x - size.x/2, cords.y - size.y/2),
    //bottom right corner
    new PVector(cords.x + size.x/2, cords.y - size.y/2),
    //top left corner
    new PVector(cords.x - size.x/2, cords.y + size.y/2)

  };
  return corners;
}

public interface entity {
  //interface making sure those objects have the required components to draw or detect collision. That way I could have a mix array of objects and still render them in an array
  final static int TYPE_RECT = 1;
  final static int TYPE_ELLIPSE = 2;
  final static int defaultSize = 40;
  public boolean collision(object other);
  public void draw();
}


public class object {


  PVector size;
  PVector cords;
  PVector vel = new PVector(0, 0);
  int type;

  object(PVector size, PVector cords) {
    this.size = size;
    this.cords = cords;
  }
  object(PVector size) {
    this.size = size;
    this.cords = new PVector(50, 50);
  }

  public PVector getCords() {
    return cords;
  };
  public PVector getSize() {
    return size;
  }

  public int getType() {
    return type;
  }
  //fix later

  public void move(float x, float y) {
    cords.x += x;
    cords.y += y;
  };
  public void move(PVector delta) {
    cords.add(delta);
  };
  public void moveTo(float x, float y) {
    cords.x = x;
    cords.y = y;
  };
  public void moveTo(PVector delta) {
    cords = delta;
  };
  public void draw() {
    //calc the adjust to framerate vel then move the object
    PVector adjustedVel = PVector.mult(vel, (60/frameRate));
    //move the object
    cords.add(adjustedVel);
  }
}



class rect extends object implements entity {

  float acceleration;
  float defaultSize = 40;


  boolean collided;
  //constructors
  rect() {
    super(new PVector(40, 40));
    this.type = TYPE_RECT;
  }
  rect(PVector size) {
    super(size);
    this.type = TYPE_RECT;
  }
  rect(float size) {
    super(new PVector(size, size));
    this.type = TYPE_RECT;
  }
  rect(float x, float y) {
    super(new PVector(x, y));
    this.type = TYPE_RECT;
  }
  rect(Rectangle rectangle) {
    super(new PVector (rectangle.width, rectangle.height), new PVector (rectangle.x, rectangle.y));
    this.type = TYPE_RECT;
  }
  rect(PVector size, PVector cords) {
    super(size, cords);
    this.type = TYPE_RECT;
  }
  rect(PVector size, float x, float y) {
    super(size, new PVector(x, y));
    this.type = TYPE_RECT;
  }

  public boolean collision(object other) {
    //returns the collision by comparing with other object. Using the type variable in object, (set in constructor) the type of the object is used to call the correct collider
    switch (other.getType()) {
    case TYPE_RECT:
      return rectWithRect(cords, size, other.getCords(), other.getSize());
    case TYPE_ELLIPSE:
      return rectWithEllipse(cords, size, other.getCords(), other.getSize());
    }
    return false;
  }

  public void draw() {
    //object.draw() applies the proper physics, by supering the draw, the physics is first applied before drawing
    super.draw();
    //draw the actual object
    noStroke();
    rect(cords.x, cords.y, size.x, size.y);
  }
}


class ellipse extends object implements entity {

  float acceleration;
  //int type = TYPE_ELLIPSE;
  boolean collided;



  //constructor
  ellipse(PVector size) {
    super(size);
    this.type = TYPE_ELLIPSE;
  }
  ellipse() {
    super(new PVector(40, 40));
    this.type = TYPE_ELLIPSE;
  }
  ellipse(Rectangle rect) {
    super(new PVector (rect.width, rect.height), new PVector (rect.x, rect.y));
    this.type = TYPE_ELLIPSE;
  }

  ellipse(float size) {
    super(new PVector(size, size));
    this.type = TYPE_ELLIPSE;
  }
  ellipse(float x, float y) {
    super(new PVector(x, y));
    this.type = TYPE_ELLIPSE;
  }
  ellipse(PVector size, PVector cords) {
    super(size, cords);
    this.type = TYPE_ELLIPSE;
  }
  ellipse(PVector size, float x, float y) {
    super(size, new PVector(x, y));
    this.type = TYPE_ELLIPSE;
  }

  public boolean collision(object other) {
    //returns the collision by comparing with other object. Using the type variable in object, (set in constructor) the type of the object is used to call the correct collider
    switch (other.getType()) {
    case TYPE_RECT:
      return rectWithEllipse(other.getCords(), other.getSize(), cords, size);
    case TYPE_ELLIPSE:
      return collided = rectWithEllipse(cords, size, other.getCords(), other.getSize());
    }
    return false;
  }

  public void draw() {
    //object.draw() applies the proper physics, by supering the draw, the physics is first applied before drawing
    super.draw();
    //draw the actual object
    noStroke();
    ellipse(cords.x, cords.y, size.x, size.y);
  }
}


class Player extends rect{

    //float playerMoveSpeed = 10;


    boolean up, down, left, right, isShooting, hit = false;

    Player(){
      this.size = new PVector(50,50);
        this.cords = new PVector(width/2, height-50);
        // println(width, height);
    }

    float playerMoveSpeed = 5;
    public void move(){
      //reset velocity, using the object system, the player moves according to velocity, so inorder to move the player within the object system, instead of
      //directly affecting the position, you manupliate the velocity instead, by adding velocities u can allow for multiple inputs at the same time.
      this.vel = new PVector(0,0);
      if (up){
        //disabled for this specific gamemode
        //this.vel.y -= playerMoveSpeed;
      }
      if (down){
        //disabled for this specific gamemode
        //this.vel.y += playerMoveSpeed;
      }
      if (left){
        this.vel.x -= playerMoveSpeed;
      }
      if (right){
        this.vel.x += playerMoveSpeed;
      }


    }

    public void shoot(){
      //if this function is called, the isShooting variable is controlled by the keyinput, when the key is pressed down, the isShooting variable changes, so until the key is released another shot cannot be made
        if (!isShooting){
        //add a new bullet to the list of bullets
        bullets.add(new Bullet(new PVector(cords.x, cords.y)));
        //play sound effect
        pew.play();
        }
        //make this function not work until the key is released
        isShooting = true;

    }

    public void draw(){
      //update velocity
      move();
      //color the player
      fill(255);
      //draw according to parent
      super.draw();
      //for each bullet
        for (Bullet bullet : bullets) {
          //todo turn enemy into a list instead of array
          if (!hit) {
            if (this.collision(bullet)) {
              bullet.shot = true;
              hit = true;
              explosion.play();
              explosions.add(new Explosion(cords));
              explosions.add(new Explosion(bullet));
              // score += 1;
            }
          }
        }


      }
    }

SoundFile explosion;
SoundFile pew;

public void loadSound(){
  //loads all the soundfiles
  explosion = new SoundFile(this, "explosion.wav");
  pew = new SoundFile(this, "pew.wav");
}
//this is a universial time function used to untie game from frameRate at places where a varying frameRate would disrupt gameplay

public float timeCount;

public void time() {
  //each loop the time adds the time passed
  //frameRate is measured in frames per second. therefore, if we put 1/frameRate, u can tell how much time has passed based on the last frame giving us a time independent of frameRate allow varying frameRate
  timeCount += 1/frameRate;
  //println(frameRate);
}
public int score = 0;

public void ui(){


}

public void gameGui(){
  scoreBoard();
}

public void scoreBoard(){
  textAlign(RIGHT,TOP);
  String scoreBoardText = "Score: " + score;
  fill(255);
  text(scoreBoardText, 672, 0);
}

int selection = 0;

public void menu(){
  textSize(20);

  float point1 = height/2;
  float point2 = point1 - 70;
  float point3 = point2 - 70;
  text("Play with keyboard", width/2, point1);
  text("Play with Webcam", width/2, point2);
  text("Instructions", width/2, point3);

  textAlign(CENTER,CENTER);
  fill(255);
  textSize(30);
  text("HOW WOULD YOU LIKE TO PLAY", width/2, height/4);

  switch(selection){
    case 0:
      text(">", width/4, point1);
      break;
    case 1:
      text(">", width/4, point2);
      break;
    case 2:
      text(">", width/4, point3);
      break;
  }
}

public void splashScreen(){
  textAlign(CENTER,CENTER);
  fill(255);
  textSize(60);
  text("WEBCAM PEW PEW", width/2, height/3);
  textSize(20);
  fill((timeCount%1)*255);
  text("PRESS SPACE TO START", width/2, height/2);
}

public void howTo(){
  String instructions = "To play this game, in keyboard mode, use the wasd or arrow keys to move the charactor. Press spacebar to shoot. In order to play in webcam mode, the game tracks your nose, so lean left to right to move the ship, then press spacebar to shoot!";
  textAlign(CENTER,CENTER);
  fill(255);
  rectMode(CORNER);
  text(instructions, 100, 100, 2*width/3, 2*height/3);
  text(">back", width/2, height-100);
  // text(">", width/4, height-100);
}
  public void settings() {  size(672, 864); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "shooter" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
