class Staircase {
  private int squareSize = 50;
  private int x, y; //coordinate of the staircase
  private int xpos, ypos; //player coordinate
  int counter = 0;
  PImage doorClosed;
  PImage [] door = new PImage[6];
  boolean complete = false;

  Staircase() {
    x = int(random(10, ((width/5)-10))) * 5;
    y = int(random(10, ((height/5)-10))) * 5;
    
    doorClosed = loadImage("sprites/door 1.png");
    for (int i = 2; i<6; i++) {
      door[i] = loadImage("sprites/door "+ nf(i, 1) + ".png");
    }
  }

  Staircase(int _x, int _y) {
    x = _x; 
    y = _y;
    
    doorClosed = loadImage("sprites/door 1.png");
    for (int i = 1; i<6; i++) {
      door[i] = loadImage("sprites/door "+ nf(i, 1) + ".png");
    }
  }

  void display() {
    fill(0); 
    stroke(1); 
    strokeWeight(1); 
    rect(x, y, squareSize, squareSize); 
    imageMode(CENTER);

    if (complete == false) {
      closeDoor();
    } else if (complete) {
      openDoor();
    }
  }

  boolean playerOver(int _xpos, int _ypos) {
    xpos = _xpos; 
    ypos = _ypos; 
    if (xpos > (x-(squareSize/2)) && xpos < (x+(squareSize/2)) && ypos > (y-(squareSize/2)) && ypos < (y+(squareSize/2))) {
      return true;
    }
    return false;
  }

  void openDoor() {
    while (counter<5) {
      counter++;
    }
    image(door[counter], x, y);
  }

  void closeDoor() {
    image(doorClosed, x, y);
    counter = 0;
  }
}

