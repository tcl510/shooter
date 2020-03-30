class Player extends rect{
  
    //float playerMoveSpeed = 10;
     
    boolean up, down, left, right, isShooting = false;

    Player(){
      this.size = new PVector(50,50);
        this.cords = new PVector(width/2, height-50);
        // println(width, height);
    }

    float playerMoveSpeed = 5;
    void move(){
      //reset velocity, using the object system, the player moves according to velocity, so inorder to move the player within the object system, instead of
      //directly affecting the position, you manupliate the velocity instead
      this.vel = new PVector(0,0);
      if (up){
        //this.vel.y -= playerMoveSpeed;
      }
      if (down){
        //this.vel.y += playerMoveSpeed;
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
        pew.play();
    }
    
    void draw(){
      
      move();
      
      fill(255);
      super.draw();
      // vel = new PVector(0,0);
      // println(cords);
    }
}
