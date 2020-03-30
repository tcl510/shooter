import processing.sound.*;
SoundFile explosion;
SoundFile pew;

void loadSound(){
  explosion = new SoundFile(this, "explosion.wav");
  pew = new SoundFile(this, "pew.wav");
}
