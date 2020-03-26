class Player extends rect{
  
    float playerMoveSpeed = 10;
    boolean up, down, left, right, isShooting = false;

    Player(){
        this.cords = new PVector(width/2, height-30);
        // println(width, height);
    }


    void move(){
      this.vel = new PVector(0,0);
      if (up){
        this.vel.y -= playerMoveSpeed;
      }
      if (down){
        this.vel.y += playerMoveSpeed;
      }
      if (left){
        this.vel.x -= playerMoveSpeed;
      }
      if (right){
        this.vel.x += playerMoveSpeed;
      }
      
      
    }

    void shoot(){
        if (!isShooting){
        bullets.add(new Bullet(new PVector(cords.x, cords.y)));
        }
        isShooting = true;
      
    }
    void draw(){
      
      move();
      
      fill(255);
      super.draw();
      // vel = new PVector(0,0);
      // println(cords);
    }
}
