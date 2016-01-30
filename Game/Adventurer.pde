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
  
  int spriteWidth, spriteHeight;
  int currentFrame;
  int spriteFrames;
  int spriteDir;
  PImage [] leftSprites, upSprites, rightSprites, downSprites;
  //required for animation and loading sprites


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
     
     spriteWidth = 32;
     spriteHeight = 32;
     spriteFrames = 4;
     currentFrame = 0;
     
     spriteDir = 3;
     
     leftSprites = new PImage[spriteFrames];
     upSprites = new PImage[spriteFrames];
     rightSprites = new PImage[spriteFrames];
     downSprites = new PImage[spriteFrames];
     
     for(int i = 0; i < spriteFrames; i++){
       leftSprites[i] = loadImage("player/left"+nf(i, 1)+".png");
       upSprites[i] = loadImage("player/up"+nf(i, 1)+".png");
       rightSprites[i] = loadImage("player/right"+nf(i, 1)+".png");
       downSprites[i] = loadImage("player/down"+nf(i, 1)+".png");
     }
     
  }

  void controls() {
    if (keyPressed == true) {
      //directional button pressed will allow movement as long as it is not off screen
      if (forwardPressed) {
        ypos -= 2.0;

        yfacing = ypos-ysize;
        xfacing = xpos;
      }
      
      if (backwardPressed) {
        ypos += 2.0;

        yfacing = ypos+ysize;
        xfacing = xpos;

        if (ypos > 700) {
          ypos = 700;
        }
      }
      
      if (leftPressed) {
        xpos -= 2.0;

        xfacing = xpos-xsize;
        yfacing = ypos;

        if (xpos < 0) {
          xpos = 0;
        }
      }
      
      if (rightPressed) {
        xpos += 2.0;

        xfacing = xpos+xsize;
        yfacing = ypos;

        if (xpos > width - 10) {
          xpos = width - 10;
        }
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
    
    // character animation direction based on keypress
    pushMatrix();
    pushStyle();
    imageMode(CENTER);
    if(keyPressed) {
      if (key == 'a') {
        image(leftSprites[currentFrame], xpos, ypos);
        if(frameCount % 10 == 0){
          currentFrame++;
        }
        spriteDir = 0;
      }
      else if (key == 'w') {
        image(upSprites[currentFrame], xpos, ypos);
        if(frameCount % 10 == 0){
          currentFrame++;
        }
        spriteDir = 1;
      }
      else if (key == 'd') {
        image(rightSprites[currentFrame], xpos, ypos);
        if(frameCount % 10 == 0){
          currentFrame++;
        }
        spriteDir = 2;
      }
      else if (key == 's') {
        image(downSprites[currentFrame], xpos, ypos);
        if(frameCount % 10 == 0){
          currentFrame++;
        }
        spriteDir = 3;
      }
      if (currentFrame >= spriteFrames)
      {
        currentFrame = 0;
      }
    }
    //idle direction based on last pressed direction
    else{
      if(spriteDir == 0) {
        image(leftSprites[0], xpos, ypos);
        currentFrame = 0;
      }
      else if(spriteDir == 1) {
        image(upSprites[0], xpos, ypos);
        currentFrame = 0;
      }
      else if(spriteDir == 2) {
        image(rightSprites[0], xpos, ypos);
        currentFrame = 0;
      }
      else if(spriteDir == 3) {
        image(downSprites[0], xpos, ypos);
        currentFrame = 0;
      }
    }
    popStyle();
    popMatrix();
  }

  void update() {
    //update combines all class functions into one, less clutter on draw function.
    dropTime++; 
    //iterates every frame for grabbing input delay

    controls(); 
    display();
  }
}