import java.awt.Rectangle; //<>//


/* 
converters: 

converts the java rectangle format to my format of a rectangle
*/
rect[] rectangleToRect(Rectangle[] rectangle_array) {
  //call arraylist rectlist
  ArrayList<rect> rectList = new ArrayList<rect>();
  for (Rectangle i : rectangle_array) {
    //adds to rectlist the rectangle in my custom rect form
    rectList.add(new rect(i));
  }
  return rectList.toArray(new rect[rectList.size()]);
}
//same as rectToRect but with convert the rectangle to custom ellipse format
ellipse[] rectangleToEllipse(Rectangle[] rectangle_array) {
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
boolean ellipseWithEllipse(PVector cord, PVector size, PVector otherCord, PVector otherSize) {
  //do boil it down, the collider adds the radius of both of the circles, and if the position of the two circles are smaller then the sum of the radii then it would be overlapping.
  //using the PVector.dist function, i can find the distance bewteen the two circles
  if (PVector.dist(cord, otherCord) < size.x+otherSize.x) {
    println("collided");
    return true;
  }
  return false;
}
//calculate the collision of two rectangles
boolean rectWithRect(PVector cord, PVector size, PVector otherCord, PVector otherSize) {
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

boolean rectWithEllipse(PVector boxCord, PVector boxSize, PVector ellipseCord, PVector ellipseSize) {
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
boolean rectWithEllipse(rect rect, ellipse ellipse) {
  return rectWithEllipse(rect.cords, rect.size, ellipse.cords, ellipse.size);
}


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

public interface entity {
  //interface making sure those objects have the required components to draw or detect collision. That way I could have a mix array of objects and still render them in an array
  final static int TYPE_RECT = 1;
  final static int TYPE_ELLIPSE = 2;
  final static int defaultSize = 40;
  boolean collision(object other);
  void draw();
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

  PVector getCords() {
    return cords;
  };
  PVector getSize() {
    return size;
  }

  int getType() {
    return type;
  }
  //fix later

  void move(float x, float y) {
    cords.x += x;
    cords.y += y;
  };
  void move(PVector delta) {
    cords.add(delta);
  };
  void moveTo(float x, float y) {
    cords.x = x;
    cords.y = y;
  };
  void moveTo(PVector delta) {
    cords = delta;
  };
  void draw() {
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

  boolean collision(object other) {
    //returns the collision by comparing with other object. Using the type variable in object, (set in constructor) the type of the object is used to call the correct collider
    switch (other.getType()) {
    case TYPE_RECT:
      return rectWithRect(cords, size, other.getCords(), other.getSize());
    case TYPE_ELLIPSE:
      return rectWithEllipse(cords, size, other.getCords(), other.getSize());
    }
    return false;
  }

  void draw() {
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

  boolean collision(object other) {
    //returns the collision by comparing with other object. Using the type variable in object, (set in constructor) the type of the object is used to call the correct collider
    switch (other.getType()) {
    case TYPE_RECT:
      return rectWithEllipse(other.getCords(), other.getSize(), cords, size);
    case TYPE_ELLIPSE:
      return collided = rectWithEllipse(cords, size, other.getCords(), other.getSize());
    }
    return false;
  }

  void draw() {
    //object.draw() applies the proper physics, by supering the draw, the physics is first applied before drawing
    super.draw();
    //draw the actual object
    noStroke();
    ellipse(cords.x, cords.y, size.x, size.y);
  }
}
