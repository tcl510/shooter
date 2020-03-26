ArrayList<Bullet> bullets = new ArrayList<Bullet>();



class Bullet extends rect{
    float bulletVelocity = 20;
    Bullet(PVector start){
      super(new PVector(10,10), start);
      //this.cords = start;
      this.vel = new PVector(0, -bulletVelocity);
      //print("new bullet");
    }
    boolean finished(){
      if (cords.y <= 0){
        return true;
      }
      ////if exploded
      
      return false;
    }
    void draw(){
     super.draw();
    }
}
