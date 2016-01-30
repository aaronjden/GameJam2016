/*
character actions
 carry- item coordinates are locked to character based on position
 item x,y, character x,y, health, sprite gifs
 //
 */
class Adventurer {
  int xpos, ypos, xsize, ysize, health, xfacing, yfacing, dropTime; 
  //
  int gridSize = 64;
  // coordinate from center, 3 hearts, 0 to 3, north to west
  boolean grab, attack, defend; 
  //grabbing object, attacking, defending functions.


  Adventurer(int xp, int yp, int xf, int yf, int xs, int ys, int hp, boolean gb, boolean atk, boolean def) {
    //location of adventurer (rectmode(center))
    xpos = xp;
    ypos = yp;
    //size of adventurer (should be the same size if square)
    xsize = xs;
    ysize = ys;
    //location in front of adventurer, objects in this zone can be interacted with.
    xfacing = xf;
    yfacing = yf;
    //checks if the character is grabbing anything
    grab = gb;

    //TO BE IMPLEMENTED: attacking and defending functions 
    attack = atk;
    defend = def;
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
      //directional button pressed will allow movement as long as it is not off screen
      // UP
      if (key == 'w' && ypos > height/(gridSize*2)) {
        ypos= ypos-(height/gridSize);

        yfacing = ypos-ysize;
        xfacing = xpos;
      }
      //DOWN
      if (key == 's' && ypos < height- (height/(gridSize*2))) {
        ypos= ypos+(height/gridSize);

        yfacing = ypos+ysize;
        xfacing = xpos;
      }
      //LEFT
      if (key == 'a' && xpos > width/(gridSize*2)) {
        xpos= xpos-(width/(gridSize));

        xfacing = xpos-xsize;
        yfacing = ypos;
      }
      //RIGHT
      if (key == 'd' && xpos < width- (width/(gridSize*2))) {
        xpos= xpos+(width/(gridSize));

        xfacing = xpos+xsize;
        yfacing = ypos;
      }
      /*spacebar to grab
       Prevention of rapid repeated inputs is required to pick up and drop item effectively. 
       dropTime implemented as a delay.*/
      if (key == ' ' && dropTime > 10) {
        if (grab ==false && dropTime > 10) {
          grab = true;
        } else if (grab == true ) {
          grab = false;
          //lets go if grabbed
        }
        dropTime = 0; //resets dropTime variable to prevent rapid repeated inputs
      }
    }

    //add control actions for attacking, defending, grabbing and dropping
  }

  void display() {
    //updates screen with character visuals

    //renews properties of stroke, strokeWeight, fill, and rectMode for shapes
    stroke(0); //black outline
    strokeWeight(1); //thin outline
    rectMode(CENTER); //coordinates from centre of shape

    //white adventurer square
    fill(255); // white
    rect(xpos, ypos, xsize, ysize);

    //adventurer facing zone outline colour (transparent hollow white square)
    stroke(255, 128);
    noFill();
    //if character is grabbing, respective outlines become thicker
    if (grab == true) {
      strokeWeight(3);
    } else {
      strokeWeight(1);
    }
    //adventurer facing zone- same size as adventurer square
    rect(xfacing, yfacing, xsize, ysize);
  }


  void update() {
    //update combines all class functions into one, less clutter on draw function.
    dropTime++; 
    //iterates every frame for grabbing input delay

    controls(); 
    display();
  }
}