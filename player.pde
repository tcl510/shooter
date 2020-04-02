int lives = 3;

class Player extends rect{

    //float playerMoveSpeed = 10;


    boolean up, down, left, right, isShooting, hit = false;

    Player(){
      this.size = new PVector(50,50);
        this.cords = new PVector(width/2, height-50);
        // println(width, height);
    }

    float playerMoveSpeed = 5;
    void move(){
      //reset velocity, using the object system, the player moves according to velocity, so inorder to move the player within the object system, instead of
      //directly affecting the position, you manupliate the velocity instead, by adding velocities u can allow for multiple inputs at the same time.
      this.vel = new PVector(0,0);
      if (up){
        //disabled for this specific gamemode
        //this.vel.y -= playerMoveSpeed;
      }
      if (down){
        //disabled for this specific gamemode
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
      //if this function is called, the isShooting variable is controlled by the keyinput, when the key is pressed down, the isShooting variable changes, so until the key is released another shot cannot be made
        if (!isShooting){
        //add a new bullet to the list of bullets
        bullets.add(new Bullet(new PVector(cords.x, cords.y)));
        //play sound effect
        pew.play();
        }
        //make this function not work until the key is released
        isShooting = true;

    }

    void draw(){
      //update velocity
      move();
      //color the player
      fill(255);
      //draw according to parent
      super.draw();
      //for each bullet
        for (Bullet bullet : enemyBullets) {
          //todo turn enemy into a list instead of array
          // if (!hit) {
            if (this.collision(bullet)) {
              oof.play();
              bullet.shot = true;
              hit = true;
              explosion.play();
              explosions.add(new Explosion(this));
              explosions.add(new Explosion(bullet));
              lives -= 1;
              if (lives < 0){
                gameState = GAMESTATE_GAMEOVER;
                sad.play();
              }

            // }
          }
        }


      }
    }
