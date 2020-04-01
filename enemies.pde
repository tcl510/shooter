int waves = 0;

void enemies() {
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
    waves = int(random(4));
    currentWave = newWave(waves);
  }
}
static final PVector defaultEnemySize = new PVector(20, 20);

float spacing = 40;
Enemy[] currentWave = newWave(3);
Enemy[] newWave(int waveCode) {
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

  void draw() {
    if (entry != null) {
      //mark
      this.vel = entry.getVel();
      // int diceRoll = random(1);
      if (int(random(150)) == 0){
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
    if (firstTime) {
      velocity = PVector.sub(currentPos, endPos);
      velocity.setMag(-magnitude);
      firstTime = false;
    }
    return velocity;
  }
  boolean checkDone() {

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

  PVector pointInCircle(float t) {
    return new PVector (centerPoint.x + radius*cos(t), centerPoint.y + radius*sin(t));
  }
  PVector getVel() {
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
  boolean checkDone() {
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
