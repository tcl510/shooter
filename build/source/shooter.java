import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.Rectangle; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class shooter extends PApplet {




public void setup() {
  
  galaga_setup();
  frameRate(10000);
}

public void draw() {
  //play the game galaga;
  galaga();
  time();
}




rect[] enemies;
Player player;
//neatly wrapped game to be put in draw
public void galaga() {
  //update background
  bg();
  //draw objects
  player.draw();
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
public void galaga_setup() {
  newStars();
  player = new Player();
}
//controller function
public void galagaController(char key) {
  //player controller
  // float playerMoveSpeed = 10;
  // if (key == 'a') player.left(true);
  // if (key == 'd') player.right(true);
  // if (key == 'w') player.up(true);
  // if (key == 's') player.down(true);
}
public void keyPressed() {
  galagaController(key);
  float playerMoveSpeed = 10;
  if (key == 'a') player.left = true;
  if (key == 'd') player.right = true;
  if (key == 'w') player.up = true;
  if (key == 's') player.down = true;
  if (key == ' ') player.shoot();
}
public void keyReleased() {
  float playerMoveSpeed = 10;
  if (key == 'a') player.left = false;
  if (key == 'd') player.right = false;
  if (key == 'w') player.up = false;
  if (key == 's') player.down = false;
  if (key == ' ') player.isShooting = false;
}
//array of stars
Star[] stars; //<>//

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
//background rendering
public void bg() {
  background(0);
  for(Star i: stars){
    //draw all the stars
    i.draw();
  }
}

float timeCount;
public void time() {
  timeCount += 1/frameRate;
  println(timeCount);
}

float speed = 25;

public class Star {
  int timeNow;
  float intensity;
  float posx, posy;
  int r,g,b ;


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
    rect(posx, posy, 2, 2); //<>//

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



class Bullet extends rect{
    float bulletVelocity = 20;
    Bullet(PVector start){
      super(new PVector(10,10), start);
      //this.cords = start;
      this.vel = new PVector(0, -bulletVelocity);
      //print("new bullet");
    }
    public boolean finished(){
      if (cords.y <= 0){
        return true;
      }
      ////if exploded
      
      return false;
    }
    public void draw(){
     super.draw();
    }
}

ArrayList<Enemy> enemy = new ArrayList<Enemy>();

class Enemy extends rect {

  Enemy(int type){
    super();
  }
  
}


public rect[] rectangleToRect(Rectangle[] rectangle_array) { //<>//

  //int length = rectangle_array.length;
  ArrayList<rect> rectList = new ArrayList<rect>();
  //rect[] rectList = new rect[length];
  //for (int i = 0; i <= length; i++){
  //  //rectList[i] =
  //  rectList[i] = new rect(rectangle_array[i]);
  //}
  for (Rectangle i : rectangle_array) {
    rectList.add(new rect(i));
  }
  //rect[] rectListArray = ;

  return rectList.toArray(new rect[rectList.size()]);
}
public ellipse[] rectangleToEllipse(Rectangle[] rectangle_array) {

  //int length = rectangle_array.length;
  ArrayList<ellipse> rectList = new ArrayList<ellipse>();
  //rect[] rectList = new rect[length];
  //for (int i = 0; i <= length; i++){
  //  //rectList[i] =
  //  rectList[i] = new rect(rectangle_array[i]);
  //}
  for (Rectangle i : rectangle_array) {
    rectList.add(new ellipse(i));
  }
  //rect[] rectListArray = ;

  return rectList.toArray(new ellipse[rectList.size()]);
}

public boolean ellipseWithEllipse(PVector cord, PVector size, PVector otherCord, PVector otherSize) {
  if (PVector.dist(cord, otherCord) < size.x+otherSize.x) {
    println("collided");
    return true;
  }
  return false;
}

public boolean rectWithRect(PVector cord, PVector size, PVector otherCord, PVector otherSize) {
  PVector[] corners = findCorners(cord, size);
  PVector[] other_corners = findCorners(otherCord, otherSize);
  for (PVector i : other_corners) {
    if (i.x < corners[0].x && i.x > corners[3].x) {
      //println("collidedx");
      if (i.y < corners[0].y && i.y > corners[1].y) {
        println("collided");
        return true;
      }
    }
  }
  return false;
}

public boolean rectWithEllipse(PVector boxCord, PVector boxSize, PVector ellipseCord, PVector ellipseSize) {
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

  // Find the closest point to the circle within the rectangle
  float closestX = constrain(ellipseCord.x, boxCord.x + boxSize.x/2, boxCord.x - boxSize.x/2);
  float closestY = constrain(ellipseCord.y, boxCord.y + boxSize.y/2, boxCord.y - boxSize.y/2);
  PVector closest = new PVector(closestX, closestY);

  // Calculate the distance between the circle's center and this closest point
  return PVector.dist(closest, boxCord) + ellipseSize.x/2 < PVector.dist(boxCord, ellipseCord);
}

public boolean rectWithEllipse(rect rect, ellipse ellipse) {
  return rectWithEllipse(rect.cords, rect.size, ellipse.cords, ellipse.size);
}



//try maybe forgoing the findcorners
PVector[] corners;

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

public interface entity{
  public boolean collision(object other);
  public void draw();

}

public class object {
  final static int TYPE_RECT = 1;
  final static int TYPE_ELLIPSE = 2;
  final static int defaultSize = 40;

  PVector size;
  PVector cords;
  PVector vel = new PVector(0,0);
  int type;

  object(PVector size, PVector cords){
    this.size = size;
    this.cords = cords;
  }
  object(PVector size){
    this.size = size;
    this.cords = new PVector(50,50);
  }

  public PVector getCords(){
    return cords;
  };
  public PVector getSize(){
   return size;
  }

  public int getType(){
    return type;
  }
//fix later

  public void move(float x, float y){
    cords.x += x;
    cords.y += y;
  };
  public void move(PVector delta){
    cords.add(delta);
  };
  public void moveTo(float x, float y){
    cords.x = x;
    cords.y = y;
  };
  public void moveTo(PVector delta){
    cords = delta;
  };
  public void draw(){
    //calc the adjust to framerate vel then move the object
    PVector adjustedVel = PVector.mult(vel, (60/frameRate));
    //move the object
    cords.add(adjustedVel);
    // println(vel);
  }
  //void setSize(PVector size);
  //void setSize(float x, float y);

}



class rect extends object implements entity{

  float acceleration;
  float defaultSize = 40;


  boolean collided;
  //constructor
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
  rect(PVector size, PVector cords){
    super(size, cords);
  }

  public boolean collision(object other) {
    switch (other.getType()) {
    case TYPE_RECT:
      return rectWithRect(cords, size, other.getCords(), other.getSize());
    case TYPE_ELLIPSE:
      return rectWithEllipse(cords, size, other.getCords(), other.getSize());
    }
    return false;
  }

  public void draw() {
    super.draw();
    rect(cords.x, cords.y, size.x, size.y);
  }

}


class ellipse extends object implements entity{

  float acceleration;
  int type = TYPE_ELLIPSE;
  boolean collided;



  //constructor
  ellipse(PVector size) {
    super(size);
  }
  ellipse() {
    super(new PVector(40, 40));
    // this.size = ;
  }
  ellipse(Rectangle rect) {
    super(new PVector (rect.width, rect.height), new PVector (rect.x, rect.y));
  }

  public boolean collision(object other) {
    switch (other.getType()) {
    case TYPE_RECT:
      return rectWithEllipse(other.getCords(), other.getSize(), cords, size);
    case TYPE_ELLIPSE:
      return collided = rectWithEllipse(cords, size, other.getCords(), other.getSize());
    }
    return false;
  }

  public void draw() {
    super.draw();
    ellipse(cords.x, cords.y, size.x, size.y);
  }

}
class Player extends rect{
  
    float playerMoveSpeed = 10;
    boolean up, down, left, right, isShooting = false;

    Player(){
        this.cords = new PVector(width/2, height-30);
        // println(width, height);
    }


    public void move(){
      this.vel = new PVector(0,0);
      if (up){
        this.vel.y -= playerMoveSpeed;
      }
      if (down){
        this.vel.y += playerMoveSpeed;
      }
      if (left){
        this.vel.x -= playerMoveSpeed;
      }
      if (right){
        this.vel.x += playerMoveSpeed;
      }
      
      
    }

    public void shoot(){
        if (!isShooting){
        bullets.add(new Bullet(new PVector(cords.x, cords.y)));
        }
        isShooting = true;
      
    }
    public void draw(){
      
      move();
      
      fill(255);
      super.draw();
      // vel = new PVector(0,0);
      // println(cords);
    }
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
