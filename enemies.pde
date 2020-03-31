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
  new Enemy(0, 400, 100, 100), 
  new Enemy(0, 400, 100, 100), 
  new Enemy(-40, 400, 140, 100), 
  new Enemy(-80, 400, 180, 100), 
  new Enemy(-120, 400, 220, 100), 
  new Enemy(-160, 400, 260, 100), 
  new Enemy(-200, 400, 300, 100), 
  new Enemy(-240, 400, 340, 100), 
  new Enemy(-280, 400, 380, 100), 
  new Enemy(-320, 400, 420, 100), 
  new Enemy(-360, 400, 460, 100), 
  new Enemy(-400, 400, 500, 100), 
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
  Enemy(float x, float y) {

    super(defaultEnemySize, 0, 400);
    //entry = new PatternA(new PVector(cords.x, cords.y), new PVector(x, y));
  }
  Enemy(float startX, float startY, float endX, float endY) {
    super(defaultEnemySize, startX, startY);
    entry = new PatternA(new PVector(startX, startY), new PVector(endX, endY), this);
  }

  void draw() {
    if (entry != null) {
      this.vel = entry.getVel();
    }
    ellipse(100, 100, 10, 10);
    super.draw();
  }
}

class Pattern {
  Enemy attachment;
  Movement[] pattern = {new Movement()};
  int step = 0;
  boolean done = false;
  boolean checkDone() {
    return done;
  }

  PVector getVel() {
    if (pattern[step].checkDone()) {
      step++;
      if (step > pattern.length-1) {
        step = constrain(step, 0, pattern.length-1);
        if (!done) {
          done = true;
          return pattern[step].getCorrection();
        }

        step = constrain(step, 0, pattern.length-1);
        return new PVector(0, 0);
      }
      step = constrain(step, 0, pattern.length-1);

      //println(startPos, currentPos);
      pattern[step].startPos = attachment.cords.copy();
      println(pattern[step].startPos, attachment.cords);
    };
    return pattern[step].getVel();
  }
}

class PatternA extends Pattern {
  ArrayList<Movement> movementList = new ArrayList<Movement>();

  PatternA(PVector startPos, PVector endPos, Enemy attachment) {
    movementList.add(new Straight(startPos, new PVector(0, 400), Movement.DEFAULT_SPEED, attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(200, 600), attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS, Loop.LEFT, 30, attachment));
    //movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(200, 600), attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(200, 200), attachment));
    //movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(100, 600), attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(200, 400), attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), endPos, attachment));
    //movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(100, 100), attachment));
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
  PVector getCorrection() {
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

  PVector getVel() {
    //if (startPos.dist(PVector.add(currentPos, velocity)) >= startPos.dist(endPos)) {
    //  if (!done) {
    //    done = true;
    //    PVector distance = new PVector( -(currentPos.x - endPos.x), -(currentPos.y - endPos.y));
    //    return velocity;
    //  } else {
    //    return new PVector (0,0);
    //  }
    //} else {
    //  return velocity;
    //if (!done){
    //println(startPos);

    //if (magnitude* (60/frameRate) >= currentPos.dist(endPos)){

    //  PVector temp = velocity.copy();
    //  temp.setMag(currentPos.dist(endPos));
    //  return temp;
    //} else 
    if (firstTime) {
      velocity = PVector.sub(currentPos, endPos);
      velocity.setMag(-magnitude);
      firstTime = false;
    }
    return velocity;
    //}

    //return new PVector(0,0);
  }
  boolean checkDone() {
    //if (startPos.dist(currentPos) == startPos.dist(endPos)) {
    //  this.endPos = currentPos.copy();
    //  done = true;
    //  return true;
    //}
    //PVector adjustedVel = PVector.mult(vel, (60/frameRate));
    //if (endPos.dist(currentPos) <= magnitude/(60/frameRate)) {
    if (startPos.dist(currentPos) >= startPos.dist(endPos)) {
      //println(startPos.dist(currentPos) - startPos.dist(endPos));
      done = true;
      //endPos = currentPos.copy();
      //println(PVector.add(endPos.a
      return true;
    }
    return done;
  }
}


class Loop extends Movement {
  public final static float DEFAULT_RADIUS = 50;
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
    centerPoint.add(startPos);//this is it
    //centerPoint.add(attachment.cords);
    this.t = velocity.heading() + (PI + (HALF_PI * direction));
    this.loopEnd = t + (TWO_PI/100 * limit * direction);

    this.startPos = startPos;
    this.endPos = pointInCircle(loopEnd);
    //this.endPos = currentPos;

    this.direction = direction;
    this.magnitude = magnitude;

    this.radius = radius;
    this.velocity = velocity.copy();
    velocity.setMag(-magnitude);
    //this.currentPos = startPos;
  }
  Loop(Movement previous, float radius, float direction, float limit, Enemy attachment) {
    this(previous.endPos.copy(), previous.velocity.copy(), radius, direction, limit, previous.magnitude, attachment);
  }

  PVector pointInCircle(float t) {
    return new PVector (centerPoint.x + radius*cos(t), centerPoint.y + radius*sin(t));
  } 
  PVector getVel() {
    ellipse(centerPoint.x, centerPoint.y, 10, 10);
    if (firstTime) {
      centerPoint = velocity.copy();
      centerPoint.setMag(-radius);
      centerPoint.rotate(PI + (HALF_PI * direction));
      centerPoint.add(startPos);//this is it
      firstTime = false;
    }
    ellipse(centerPoint.x, centerPoint.y, 10, 10);

    t -= (-direction)*(magnitude/radius);
    velocity.x = -(currentPos.x - (centerPoint.x+radius*cos(t)));
    velocity.y = -(currentPos.y - (centerPoint.y+radius*sin(t)));
    return velocity;
  }
  boolean checkDone() {
    if (t < loopEnd && direction == 1) {
      return false;
    }
    if (t > loopEnd && direction == -1) {
      return false;
    }
    //println(pointInCircle(t- (-direction)*(magnitude/radius)),endPos, currentPos, PVector.mult(velocity, 60/frameRate));
    //println(endPos, currentPos);
    endPos = currentPos.copy();
    //velocity.setMag(magnitude);
    done = true;
    return true;
  }
}
