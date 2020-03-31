void enemies() {
  //draw enemies and check for hit
  for (Enemy enemy : enemies) {
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
        }
      }
    }
    if (!enemy.hit) {
      enemy.draw();
    }
  }
}

ArrayList<Enemy> enemy = new ArrayList<Enemy>();
static final PVector defaultEnemySize = new PVector(20, 20);

Enemy[] enemies = {
  new Enemy(0,400,100, 100), 
  new Enemy(-40, 400, 140, 100), 
  new Enemy(-80, 400, 180, 100), 
  new Enemy(-100, 400, 220, 100), 
  new Enemy(-140, 400, 260, 100), 
  new Enemy(-180, 400, 300, 100)
};


class Enemy extends rect {

  boolean hit = false;
  Pattern entry = new Pattern();

  //Enemy(float x, float y) {
  //  super(defaultEnemySize, x, y);
  //  entry = new PatternA(new PVector(x, y), new PVector(100, 100));
  //}
  Enemy(Pattern pattern, float x, float y) {
    super(defaultEnemySize, x, y);
    entry = pattern;
  }
  Enemy(float x, float y){
   
   super(defaultEnemySize, 0, 400);
   entry = new PatternA(new PVector(cords.x, cords.y) , new PVector(x, y));
    
  }
  Enemy(float startX, float startY, float endX, float endY){
   super(defaultEnemySize, startX, startY);
   entry = new PatternA(new PVector(startX, startY), new PVector(endX, endY));
    
  }

  void draw() {
    if (entry != null) {
      this.vel = entry.getVel();
    }
    super.draw();
  }
}

class Pattern {
  Movement[] pattern = {new Movement()};
  int step = 0;
  boolean done = false;
  boolean checkDone() {
    return done;
  }

  PVector getVel() {
    if (pattern[step].checkDone())step++;
    if (step >= pattern.length) {
      step--;
      done = true;
      return new PVector(0, 0);
    }
    return pattern[step].getVel();
  }
}

class PatternA extends Pattern {
  ArrayList<Movement> movementList = new ArrayList<Movement>();
  PatternA(PVector startPos, PVector endPos) {
    
    movementList.add(new Straight(startPos, new PVector(100, 400), Movement.DEFAULT_SPEED));
    int index = 0;
    movementList.add(new Loop(movementList.get(index), Loop.DEFAULT_RADIUS, Loop.RIGHT, 160));
    index++;
    movementList.add(new Straight(movementList.get(index), endPos));
    //index++;
    this.pattern = movementList.toArray(new Movement[movementList.size()]);
  }
}


class Movement {
  public final static float DEFAULT_SPEED = 2;
  PVector startPos, endPos;
  PVector velocity = new PVector(0, 0);
  boolean done = false;
  float magnitude;


  PVector getStarting() {
    return startPos;
  };
  PVector getEnd() {
    return endPos;
  };
  PVector getVel() {
    return velocity;
  };

  boolean checkDone() {
    return done;
  }
}


class Straight extends Movement {
  PVector currentPos;
  Straight(PVector startPos, PVector endPos, float magnitude) {
    this.startPos = startPos;
    this.endPos = endPos;
    this.magnitude = magnitude;
    //this.velocity = new PVector(magnitude, 0);
    //velocity.
    //PVector tempMag = endPos.copy();
    //tempMag.limit(magnitude);
    //velocity = PVector.fromAngle(endPos.heading()).setMag(tempMag.mag());
    //this.velocity = PVector.fromAngle(PVector.angleBetween(startPos, endPos));
    
    this.velocity = PVector.sub(startPos, endPos);
    velocity.setMag(magnitude);
    this.currentPos = startPos.copy();
  }
  Straight(Movement previous, PVector endPos) {
    
    this.startPos = previous.endPos;
    this.endPos = endPos;
    this.magnitude = previous.magnitude;
    //this.velocity = PVector.fromAngle(PVector.angleBetween(startPos, endPos));
    this.velocity = PVector.sub(startPos, endPos);
    velocity.setMag(-previous.magnitude);
    this.currentPos = previous.endPos.copy();
    //print(velocity, magnitude);
  }
  PVector getVel() {
    
    currentPos.add(velocity);
    return velocity;
  }
  boolean checkDone() {
    //println(startPos.dist(currentPos), startPos.dist(endPos));
    if (startPos.dist(currentPos) >= startPos.dist(endPos)) {
      done = true;
      return true;
    }
    return false;
  }
}


class Loop extends Movement {
  public final static float DEFAULT_RADIUS = 50;
  PVector centerPoint;
  float t;
  float radius;
  float loopEnd;
  float direction;
  PVector currentPos;
  public final static float RIGHT = 1;
  public final static float LEFT = -1;

  Loop(PVector startPos, PVector velocity, float magnitude, float radius, float direction, float limit) {
    //this.centerPoint = velocity.copy();
    //centerPoint.setMag(-radius);
    //centerPoint.rotate(PI + (HALF_PI * direction));

    //this.t = velocity.heading() + (PI + (HALF_PI * direction));
    //this.loopEnd = t + (TWO_PI/100 * limit * direction);

    //this.startPos = startPos;
    //this.endPos = pointInCircle(loopEnd);

    //this.direction = direction;
    //this.magnitude = magnitude;
    this.centerPoint = velocity.copy();
    centerPoint.setMag(-radius);
    centerPoint.rotate(PI + (HALF_PI * direction));
    centerPoint.add(startPos);
    //println(centerPoint);
    this.t = velocity.heading() + (PI + (HALF_PI * direction));
    this.loopEnd = t + (TWO_PI/100 * limit * direction);

    this.startPos = startPos;
    this.endPos = pointInCircle(loopEnd);

    this.direction = direction;
    this.magnitude = magnitude;
    
    this.radius = radius;
    this.velocity = velocity;
    velocity.setMag(-magnitude);
    this.currentPos = startPos;
  }
  Loop(Movement previous, float radius, float direction, float limit) {
    print(previous.velocity);
    
    this.centerPoint = previous.velocity.copy();
    centerPoint.setMag(-radius);
    centerPoint.rotate(PI + (HALF_PI * direction));
    centerPoint.add(previous.endPos);
    //println(centerPoint);
    this.t = previous.velocity.heading() + (PI + (HALF_PI * direction));
    this.loopEnd = t + (TWO_PI/100 * limit * direction);

    this.startPos = previous.endPos;
    this.endPos = pointInCircle(loopEnd);

    this.direction = direction;
    this.magnitude = previous.magnitude;
    
    this.radius = radius;
    this.velocity = previous.velocity;
    velocity.setMag(-magnitude);
    this.currentPos = startPos;
    
  }

  PVector pointInCircle(float t) {
    return new PVector (centerPoint.x + radius*cos(t), centerPoint.y + radius*sin(t));
  } 
  PVector getVel() {
    
    //ellipse(centerPoint.x, centerPoint.y, 10,10);
    PVector pos = pointInCircle(t);
    t -= (-direction)*(magnitude/radius);
    

    PVector pos2 = PVector.sub(pos, pointInCircle(t));
    //pos2.mult(-1);
    velocity = pos2;
    
    //println(centerPoint);
    velocity.x = -(currentPos.x - (centerPoint.x+radius*cos(t)));
    velocity.y = -(currentPos.y - (centerPoint.y+radius*sin(t)));
    println(velocity);
    currentPos.add(velocity);
    return velocity;
  }
  boolean checkDone() {
    if (t < loopEnd && direction == 1) return false;
    if (t < loopEnd && direction == -1) return false;
    done = true;
    return true;
  }
}


 
