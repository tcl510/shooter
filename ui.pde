public int score = 0;

void ui(){


}

void gameGui(){
  scoreBoard();
}

void scoreBoard(){
  textAlign(RIGHT,TOP);
  String scoreBoardText = "Score: " + score;
  fill(255);
  text(scoreBoardText, 672, 0);
  textAlign(RIGHT,BOTTOM);
  text("Lives: " + lives, 672, height);
  textAlign(LEFT,TOP);
  text("Level: " + level, 0, 0);
}

int selection = 0;

void menu(){
  textSize(20);

  float point1 = height/2;
  float point2 = point1 - 70;
  float point3 = point2 - 70;
  fill(255);
  text("Play with keyboard", width/2, point1);
  text("Play with Webcam", width/2, point2);
  text("Instructions", width/2, point3);

  textAlign(CENTER,CENTER);
  fill(255);
  textSize(30);
  text("HOW WOULD YOU LIKE TO PLAY", width/2, height/4);

  switch(selection){
    case 0:
      text(">", width/4, point1);
      break;
    case 1:
      text(">", width/4, point2);
      break;
    case 2:
      text(">", width/4, point3);
      break;
  }
}

void splashScreen(){
  textAlign(CENTER,CENTER);
  fill(255);
  textSize(60);
  text("WEBCAM PEW PEW", width/2, height/3);
  textSize(20);
  fill((timeCount%1)*255);
  text("PRESS SPACE TO START", width/2, height/2);
}

void howTo(){
  String instructions = "To play this game, in keyboard mode, use the wasd or arrow keys to move the charactor. Press spacebar to shoot. In order to play in webcam mode, the game tracks your nose, so lean left to right to move the ship, then press spacebar to shoot!";
  textAlign(CENTER,CENTER);
  fill(255);
  rectMode(CORNER);
  text(instructions, 100, 100, 2*width/3, 2*height/3);
  text(">back", width/2, height-100);
  // text(">", width/4, height-100);
}

void gameOver(){
  textAlign(CENTER,CENTER);
  fill(255);
  textSize(60);
  text("Game Over", width/2, height/3);
  textSize(20);
  text("Your score was " + score, width/2, 343);
  fill((timeCount%1)*255);
  text("PRESS TO RETURN TO MENU", width/2, height/2);
}
