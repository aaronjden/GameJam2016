class Candle {
  int xPos, yPos, xSize, ySize;
  boolean litUp1;
  //is candle lit?
  PImage unlit;
  PImage[] lit = new PImage[3];
  int counter1 = 0;

  Candle() {
    xPos = int(random(10, 170)) * 5;
    yPos = int(random(10, 110)) * 5;
    xSize = 10;
    ySize = 30;
    unlit = loadImage("sprites/candle 1.png");

    for (int i = 1; i< 3; i++) {
      lit[i] = loadImage("sprites/candle "+nf(i+1, 1)+".png");
    }
  }

  Candle(int x, int y) {
    xPos = x;
    yPos = y;
    xSize = 10;
    ySize = 30;
    unlit = loadImage("sprites/candle 1.png");

    for (int i = 1; i< 3; i++) {
      lit[i] = loadImage("sprites/candle "+nf(i+1, 1)+".png");
    }
  }

  Candle(int _x, int _y, int _xSize, int _ySize) {
    xPos = _x;
    yPos = _y;

    xSize = _xSize;
    ySize = _ySize;
    litUp1 = false;
    //void light(){
    //if (Candle ypos match.xpos < )
    unlit = loadImage("sprites/candle 1.png");

    for (int i = 1; i< 3; i++) {
      lit[i] = loadImage("sprites/candle "+nf(i+1, 1)+".png");
    }
  }

  boolean litUp(Item x) {
    //match proximity  
    //if (x.xpos > x
    if (
    x.xpos > xPos-xSize
      &&
      x.xpos < xPos + xSize
      &&
      x.ypos > yPos-ySize
      &&
      x.ypos < yPos + ySize
      &&
      x.grabbed == false) {
      litUp1 = true;
      return true;
    } else {
      litUp1 = false;
    }
    return false;
  }


  void animation() {
    if (litUp1 == true) {
      image(lit[1], xPos, yPos);
      /*if (counter1 < 1) {
        counter1++;
      }
      if (counter1 >= 2) {
        counter1 = 0;
      }*/
      
    } else {
      image(unlit, xPos, yPos);
    }
  }

  void display() {
    fill(255);
    ellipse(xPos, yPos, xSize, ySize);
    //imageMode(CENTER);
    animation();
  }

  void update() {
    display();
  }
}

