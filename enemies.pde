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
        done = true;
      }
      step = constrain(step, 0, pattern.length-1);
    };
    return pattern[step].getVel();
  }
}

class PatternA extends Pattern {
  ArrayList<Movement> movementList = new ArrayList<Movement>();

  PatternA(PVector startPos, PVector endPos, Enemy attachment) {

    movementList.add(new Straight(startPos, new PVector(420, 400), Movement.DEFAULT_SPEED, attachment));
    movementList.add(new Loop(movementList.get(movementList.size()-1), Loop.DEFAULT_RADIUS, Loop.RIGHT, 120, attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(200, 600), attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(10, 10), attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), new PVector(100, 600), attachment));
    movementList.add(new Straight(movementList.get(movementList.size()-1), endPos, attachment));
    this.pattern = movementList.toArray(new Movement[movementList.size()]);
    this.attachment = attachment;
  }


  //PVector getVel() {
  //    return new PVector(0,0);
  //}
}


class Movement {
  public final static float DEFAULT_SPEED = 4;
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

  PVector correction() {
    PVector distance = new PVector( -(currentPos.x - endPos.x), -(currentPos.y - endPos.y));
    return distance;
  }
}


class Straight extends Movement {

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
    if (startPos.dist(PVector.add(currentPos, velocity)) >= startPos.dist(endPos)) {
      if (!done) {
        done = true;
        PVector distance = new PVector( -(currentPos.x - endPos.x), -(currentPos.y - endPos.y));
        return distance;
      } else {
        return new PVector(0, 0);
      }
    } else {
      return velocity;
    }
  }
  boolean checkDone() {
    if (startPos.dist(currentPos) >= startPos.dist(endPos)) {
      this.endPos = currentPos.copy();
      done = true;
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
  Loop(Movement previous, float radius, float direction, float limit, Enemy attachment) {
    super(attachment);
    this.centerPoint = previous.velocity.copy();
    centerPoint.setMag(-radius);
    centerPoint.rotate(PI + (HALF_PI * direction));
    centerPoint.add(previous.endPos);
    this.t = previous.velocity.heading() + (PI + (HALF_PI * direction));
    this.loopEnd = t + (TWO_PI/100 * limit * direction);

    this.startPos = previous.endPos.copy();
    println(startPos);
    this.endPos = pointInCircle(loopEnd);

    this.direction = direction;
    this.magnitude = previous.magnitude;

    this.radius = radius;
    this.velocity = previous.velocity.copy();
    velocity.setMag(-magnitude);
    //this.currentPos = startPos;
  }

  PVector pointInCircle(float t) {
    return new PVector (centerPoint.x + radius*cos(t), centerPoint.y + radius*sin(t));
  } 
  PVector getVel() {
    //currentPos = attachment.cords.copy();
    //ellipse(centerPoint.x, centerPoint.y, 10,10);
    println("here"); //<>//
    //PVector pos = pointInCircle(t);
    t -= (-direction)*(magnitude/radius);


//    PVector pos2 = PVector.sub(pos, pointInCircle(t));
//    //pos2.mult(-1);
//    velocity = pos2;

    //println(centerPoint);
    velocity.x = -(currentPos.x - (centerPoint.x+radius*cos(t)));
    velocity.y = -(currentPos.y - (centerPoint.y+radius*sin(t)));
    
    return velocity;
  }
  boolean checkDone() {
    if (t < loopEnd && direction == 1) return false;
    if (t > loopEnd && direction == -1) return false;
    endPos = currentPos.copy();
    done = true;
    return true;
  }
}
