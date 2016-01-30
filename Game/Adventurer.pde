/*
character actions
 carry- item coordinates are locked to character based on position
 item x,y, character x,y, health, sprite gifs
 //
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
<<<<<<< HEAD
  int xpos, ypos, xsize, ysize, health, xfacing, yfacing, dropTime;
  //
  int gridSize = 64;
=======
>>>>>>> origin/master
  // coordinate from center, 3 hearts, 0 to 3, north to west
  private int xpos;
  private int ypos;
  private int health;
  private int facing;

  //grabbing object, attacking, defending functions.
  private boolean grab;
  private boolean attack;
  private boolean defend;

  Adventurer(int xp, int yp, int xf, int yf, int xs, int ys, int hp) {
    //location of adventurer (rectmode(center))
    xpos = xp;
    ypos = yp;
<<<<<<< HEAD
    //size of adventurer (should be the same size if square)
    xsize = 25;
    ysize = 25;
    //location in front of adventurer, objects in this zone can be interacted with.
    xfacing = xf;
    yfacing = yf;
    //checks if the character is grabbing anything
    grab = false;

    //TO BE IMPLEMENTED: attacking and defending functions
    attack = false;
    defend = false;
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
=======
    grab = gb;
    attack = atk;
    defend = def;
>>>>>>> origin/master
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