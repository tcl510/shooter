//this is a universial time function used to untie game from frameRate at places where a varying frameRate would disrupt gameplay

public float timeCount;

void time() {
  //each loop the time adds the time passed
  //frameRate is measured in frames per second. therefore, if we put 1/frameRate, u can tell how much time has passed based on the last frame giving us a time independent of frameRate allow varying frameRate
  timeCount += 1/frameRate;
}
