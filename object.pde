import java.awt.Rectangle;

rect[] rectangleToRect(Rectangle[] rectangle_array) { //<>//

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
ellipse[] rectangleToEllipse(Rectangle[] rectangle_array) {

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

boolean ellipseWithEllipse(PVector cord, PVector size, PVector otherCord, PVector otherSize) {
  if (PVector.dist(cord, otherCord) < size.x+otherSize.x) {
    println("collided");
    return true;
  }
  return false;
}

boolean rectWithRect(PVector cord, PVector size, PVector otherCord, PVector otherSize) {
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

boolean rectWithEllipse(PVector boxCord, PVector boxSize, PVector ellipseCord, PVector ellipseSize) {
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

boolean rectWithEllipse(rect rect, ellipse ellipse) {
  return rectWithEllipse(rect.cords, rect.size, ellipse.cords, ellipse.size);
}



//try maybe forgoing the findcorners
PVector[] corners;

PVector[] findCorners(PVector cords, PVector size) {
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
  boolean collision(object other);
  void draw();

}

public class object {
  final int TYPE_RECT = 1;
  final int TYPE_ELLIPSE = 2;
  final int defaultSize = 40;

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

  PVector getCords(){
    return cords;
  };
  PVector getSize(){
   return size;
  }

  int getType(){
    return type;
  }
//fix later

  void move(float x, float y){
    cords.x += x;
    cords.y += y;
  };
  void move(PVector delta){
    cords.add(delta);
  };
  void moveTo(float x, float y){
    cords.x = x;
    cords.y = y;
  };
  void moveTo(PVector delta){
    cords = delta;
  };
  void draw(){
    cords.add(vel);
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

  boolean collision(object other) {
    switch (other.getType()) {
    case TYPE_RECT:
      return rectWithRect(cords, size, other.getCords(), other.getSize());
    case TYPE_ELLIPSE:
      return rectWithEllipse(cords, size, other.getCords(), other.getSize());
    }
    return false;
  }

  void draw() {
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

  boolean collision(object other) {
    switch (other.getType()) {
    case TYPE_RECT:
      return rectWithEllipse(other.getCords(), other.getSize(), cords, size);
    case TYPE_ELLIPSE:
      return collided = rectWithEllipse(cords, size, other.getCords(), other.getSize());
    }
    return false;
  }

  void draw() {
    super.draw();
    ellipse(cords.x, cords.y, size.x, size.y);
  }

}
