import processing.sound.*;
SoundFile explosion;
SoundFile pew;

void loadSound(){
  //loads all the soundfiles
  explosion = new SoundFile(this, "explosion.wav");
  pew = new SoundFile(this, "pew.wav");
}
