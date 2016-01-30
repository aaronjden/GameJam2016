/*
character actions
 carry- item coordinates are locked to character based on position
 item x,y, character x,y, health, sprite gifs
 */

/*
    functions to make
 boolean function for sharing coordinates with grabbed item
 boolean for defend where touching dangerous elements nullifies damage
 boolean for attack where if an enemy is within range, they lose health
 character size is 24px
 function for last direction faced- from 0 to 3 north clockwise
 */

class Adventurer {
  // coordinate from center, 3 hearts, 0 to 3, north to west
  private int xpos;
  private int ypos;
  private int health;
  private int facing;

  //grabbing object, attacking, defending functions.
  private boolean grab;
  private boolean attack;
  private boolean defend;

  Adventurer(int xp, int yp, int hp, boolean gb, boolean atk, boolean def) {
    xpos = xp;
    ypos = yp;
    grab = gb;
    attack = atk;
    defend = def;
  }

  void display() {
    fill(255);
    rect(xpos, ypos, 24, 24);
  }

  void update() {
    controls();
    display();
  }

  void controls() {
    /*
    if (keyPressed == true) {
     //UP
     if (key == 'w' && ypos > height/128) {
     ypos= ypos-height/128;
     }
     //DOWN
     if (key == 's' && ypos < height- height/128) {
     ypos= ypos+height/128;
     }
     //RIGHT
     if (key == 'd' && xpos > width/128) {
     xpos= xpos+width/128;
     }
     //LEFT
     if (key == 'a' && xpos < width- width/128 && width > width/128 ) {
     xpos= xpos-width/128;
     }
     }
     */

    if (forwardPressed) {
      ypos -= 2.0;
    }
    if (backwardPressed) {
      ypos += 2.0;
      if (ypos > 700) {
        ypos = 700;
      }
    }
    if (leftPressed) {
      xpos -= 2.0;
      if (xpos < 0) {
        xpos = 0;
      }
    }
    if (rightPressed) {
      xpos += 2.0;
      if (xpos > width - 10) {
        xpos = width - 10;
      }
    }
  }
}