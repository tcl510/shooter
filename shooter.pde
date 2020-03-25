


void setup() {
  size(1280, 720);
  galaga_setup();
}

void draw() {
  galaga();
  time();
}

rect[] enemies;

//neatly wrapped game to be put in draw
void galaga() {
  bg();
}
//game setup
void galaga_setup(){
  newStars();
}
//controller function
void controller() {
}

//array of stars
Star[] stars; //<>//

//generate new stars
void newStars(){
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
void bg() {
  background(0);
  for(Star i: stars){
    //draw all the stars
    i.draw();
  }
}

float timeCount;
void time() {
  timeCount += 1/frameRate;
}

float speed = 0.5;

public class Star {
  int timeNow;
  float intensity;
  float posx, posy;
  int r,g,b ;


  float fallRate = random(0.1, 9.81);

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
  void draw() {
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
  void updateTime() {
    timeNow = (int)timeCount;
    println(timeNow);
  }
  void gravity() {
    //if position is bigger then the height limit reset
    if (posy > height){
      posy = 0;
    }
    //update position
    posy += fallRate * speed;
  }
}
