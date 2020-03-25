

class enemy extends rect {

  enemy(int type){
    super();
  }





}

class player extends rect{
    float playerMoveSpeed = 10;
    boolean up, down, left, right, isShooting = false;

    player(){
        this.cords = new PVector(width/2, height-30);
        // println(width, height);
    }


    void move(){
      vel = new PVector(0,0);
      if (up){
        vel.y -= playerMoveSpeed;
      }
      if (down){
        vel.y += playerMoveSpeed;
      }
      if (left){
        vel.x -= playerMoveSpeed;
      }
      if (right){
        vel.x += playerMoveSpeed;
      }
      // cords.add(vel);
    }

    void shoot(){
      if (isShooting){

      }
    }
    void draw(){
      move();
      super.draw();
      // vel = new PVector(0,0);
      // println(cords);
    }
}

class bullet extends rect{

    bullet(PVector start){
      super(10,10);
      this.cords = (start);
    }





}
