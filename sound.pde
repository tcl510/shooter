import processing.sound.*;
SoundFile explosion;
SoundFile pew;
SoundFile noiise;
SoundFile oof;
SoundFile sad;

void loadSound(){
  //loads all the soundfiles
  explosion = new SoundFile(this, "explosion.wav");
  pew = new SoundFile(this, "pew.wav");
  noiise = new SoundFile(this, "noiise.wav");
  oof = new SoundFile(this, "oof.wav");
  sad = new SoundFile(this, "sad.wav");
}
