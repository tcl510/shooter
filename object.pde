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

interface object {
  final int TYPE_RECT = 1;
  final int TYPE_ELLIPSE = 2;
  final int defaultSize = 40;

  PVector getCords();
  PVector getSize();
  int getType();

  boolean collision(object other);

  void move(float x, float y);
  void move(PVector delta);
  void moveTo(float x, float y);
  void moveTo(PVector delta);
  //void setSize(PVector size);
  //void setSize(float x, float y);
  void draw();
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

  boolean collision(object other) {
    switch (other.getType()) {
    case TYPE_RECT:
      return rectWithRect(cords, size, other.getCords(), other.getSize());
    case TYPE_ELLIPSE:
      return rectWithEllipse(cords, size, other.getCords(), other.getSize());
    }
    return false;
  }

  void move(float x, float y) {
    cords.x += x;
    cords.y += y;
  }
  void move(PVector delta) {
    cords.add(delta);
  }

  void moveTo(float x, float y) {
    cords.x = x;
    cords.y = y;
  }
  void moveTo(PVector cord) {
    cords = cord;
  }

  void draw() {
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

  boolean collision(object other) {
    switch (other.getType()) {
    case TYPE_RECT:
      return rectWithEllipse(other.getCords(), other.getSize(), cords, size);
    case TYPE_ELLIPSE:
      return collided = rectWithEllipse(cords, size, other.getCords(), other.getSize());
    }
    return false;
  }

  void move(float x, float y) {
    cords.x += x;
    cords.y += y;
  }
  void move(PVector delta) {
    cords.add(delta);
  }
  void moveTo(float x, float y) {
    cords.x = x;
    cords.y = y;
  }
  void moveTo(PVector cord) {
    cords = cord;
  }

  void draw() {
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
