/*
character actions
 carry- item coordinates are locked to character based on position
 item x,y, character x,y, health, sprite gifs
 */
class Adventurer {
  int xpos, ypos, health, facing;
  // coordinate from center, 3 hearts, 0 to 3, north to west
  boolean grab, attack, defend;
  //grabbing object, attacking, defending functions.


  Adventurer(int xp, int yp, int hp, boolean gb, boolean atk, boolean def) {
    xpos = xp;
    ypos = yp;
    grab = gb;
    attack = atk;
    defend = def;
    rectMode(CENTER);
    /*
    functions to make
     boolean function for sharing coordinates with grabbed item
     boolean for defend where touching dangerous elements nullifies damage
     boolean for attack where if an enemy is within range, they lose health
     character size is 24px
     function for last direction faced- from 0 to 3 north clockwise
     */
  }
  void controls() {
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
  }

  void display() {
    fill(255);
    rect(xpos, ypos, 24, 24);
  }


  void update() {
    controls();
    display();
  }
}
