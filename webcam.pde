import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import java.util.*;

Capture video;
OpenCV opencv;

void loadWebCam() {
  video = new Capture(this, 640/4, 480/4, 100);
  opencv = new OpenCV(this, 640/4, 480/4);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();
}
boolean paused;
void updatePosByWebcam() {
  //scale(5);
  paused = true;
  opencv.loadImage(video);
  Rectangle[] faces = opencv.detect();
  if (faces.length > 1) {
    Arrays.sort(faces, new SortBySize());
  }
  if (faces.length > 0) {
    paused = false;
    fill(255, 0, 0);
    rect(faces[0].x, faces[0].y, faces[0].width, faces[0].height);
    player.cords.x = width - Math.round(faces[0].x*6.5);
    //rect(Math.round(faces[0].x*6.5), height-200, 50, 50);
  } 

  //for (int i = 0; i < faces.length; i++) {
  //  //println(faces[i].x + "," + faces[i].y);
  //  //rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  //  fill(255,255,9);
  //  println("x" + faces[i].width + "y" + faces[i].height + "order" + i);
  //      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  //      rect(Math.round(faces[i].x*6.5), height-200, 50, 50);
  //}
}

void captureEvent(Capture c) {
  c.read();
}

class SortBySize implements Comparator<Rectangle> {
  public int compare(Rectangle a, Rectangle b) {
    return int(a.width*a.height*1000)-int(b.width*b.height*1000);
  }
}
