class Enemy {
  int xpos, ypos, xsize, ysize, health;
  float speed; 
  int randRun;

  Enemy(int xp, int yp, int xs, int ys, int hp, float sp) {
    xpos = xp;
    ypos = yp;
    xsize = xs;
    ysize = ys;
    speed = sp;
    health = hp;
  }


  void following() {
    //add a random variable to determine which direction it moves in first

    for (int i = i=0; i<3; i++) {   
      randRun = int(random(0, 3));


      if (player.ypos < ypos && randRun == 0) { //if mouseY is smaller than targeypos:
        ypos= ypos- int(speed); //move down
      }
      if (player.ypos > ypos && randRun == 0) {  //if mouseY is larger than targeypos:
        ypos= ypos+ int(speed); //move up
      }

      if (player.xpos < xpos && randRun == 1) { //if the mouseX is smaller than targexpos:
        xpos= xpos-int(speed); //move right
      }
      if (player.xpos > xpos && randRun == 1) {  //if mouseX is larger than targexpos:
        xpos= xpos+int(speed); //move left
      }
    }
  }



  void speed() {
    speed = speed-0.03;
    if (speed < -3) {
      speed = 5;
    }
  }

  void display() {
    strokeWeight(2);
    stroke(255, 0, 128);
    rectMode(CENTER);
    fill(255, 0, 72);
    rect(xpos, ypos, xsize, ysize);
  }

  void update() {
    following();
    speed();
    display();
  }
}