class Item {
  int xpos, ypos, xsize, ysize;
  //coordinates of iterm
  boolean grabbed;
  //decides if item coords are locked to character

  Item(int xp, int yp, int xs, int ys, boolean gb) {
    //location of item
    xpos = xp;
    ypos = yp;

    //size of image
    xsize = xs;
    ysize = ys;

    //checks if item has been grabbed (indirectly related to character grab function
    grabbed = gb;
  }

  void grabbing() {
    //checks player facing variables to see if item is within the grabbing zone
    //24 has been chosen as the area range, no issues with it so far.
    if (
      xpos - player.xfacing < 24 && 
      xpos - player.xfacing > -24 &&
      ypos - player.yfacing < 24 && 
      ypos - player.yfacing > -24
      && player.grab == true
      ) {

      grabbed = true;
    } else {
      grabbed = false;
    }
  }
  void carrying() {
    //keeps carrying the item, by matching its coordinates with the facing zone of the adventurer class
    if (grabbed == true) {
      xpos = player.xfacing;
      ypos = player.yfacing;
    }
  }
  void display() {
    //TEMP will display basic shape until sprite is ready
    fill(255, 255, 10, 128);
    rect(xpos, ypos, xsize, ysize);
  }
  void update() {
    carrying();
    grabbing();
    display();
  }
}