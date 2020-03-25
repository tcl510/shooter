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
}

public void draw() {
  galaga();
  time();
}

rect[] enemies;

//neatly wrapped game to be put in draw
public void galaga() {
  bg();
}
//game setup
public void galaga_setup(){
  newStars();
}
//controller function
public void controller() {
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
}

float speed = 0.5f;

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
    println(timeNow);
  }
  public void gravity() {
    //if position is bigger then the height limit reset
    if (posy > height){
      posy = 0;
    }
    //update position
    posy += fallRate * speed;
  }
}


class enemy extends rect {

  enemy(int type){
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

interface object {
  final int TYPE_RECT = 1;
  final int TYPE_ELLIPSE = 2;
  final int defaultSize = 40;

  public PVector getCords();
  public PVector getSize();
  public int getType();

  public boolean collision(object other);

  public void move(float x, float y);
  public void move(PVector delta);
  public void moveTo(float x, float y);
  public void moveTo(PVector delta);
  //void setSize(PVector size);
  //void setSize(float x, float y);
  public void draw();
}



class rect implements object {
  PVector size;
  PVector cords;
  float acceleration;
  int type = TYPE_RECT;
  boolean collided;


  //constructor
  rect() {
    this.size = new PVector(defaultSize, defaultSize);
  }
  rect(PVector size) {
    this.size = size;
  }
  rect(float size) {
    this.size = new PVector(size, size);
  }
  rect(float x, float y) {
    this.size = new PVector(x, y);
  }
  rect(Rectangle rectangle) {
    this.size = new PVector (rectangle.width, rectangle.height);
    this.cords = new PVector (rectangle.x, rectangle.y);
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

  public void move(float x, float y) {
    cords.x += x;
    cords.y += y;
  }
  public void move(PVector delta) {
    cords.add(delta);
  }

  public void moveTo(float x, float y) {
    cords.x = x;
    cords.y = y;
  }
  public void moveTo(PVector cord) {
    cords = cord;
  }

  public void draw() {
    rect(cords.x, cords.y, size.x, size.y);
  }

  public int getType() {
    return type;
  }
  public PVector getCords() {
    return cords;
  }
  public PVector getSize() {
    return size;
  }
}


class ellipse implements object {
  PVector size;
  PVector cords = new PVector (50, 50);
  float acceleration;
  int type = TYPE_ELLIPSE;
  boolean collided;


  //constructor
  ellipse(PVector size) {
    this.size = size;
  }
  ellipse() {
    this.size = new PVector(defaultSize, defaultSize);
  }
  ellipse(Rectangle rect) {
    this.size = new PVector (rect.width, rect.height);
    this.cords = new PVector (rect.x, rect.y);
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

  public void move(float x, float y) {
    cords.x += x;
    cords.y += y;
  }
  public void move(PVector delta) {
    cords.add(delta);
  }
  public void moveTo(float x, float y) {
    cords.x = x;
    cords.y = y;
  }
  public void moveTo(PVector cord) {
    cords = cord;
  }

  public void draw() {
    ellipse(cords.x, cords.y, size.x, size.y);
  }

  public int getType() {
    return type;
  }
  public PVector getCords() {
    return cords;
  }
  public PVector getSize() {
    return size;
  }
}
  public void settings() {  size(1280, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "shooter" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
