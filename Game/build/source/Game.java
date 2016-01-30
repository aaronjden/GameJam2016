import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Game extends PApplet {

public void setup() {
  size(900, 600);
  background(255);
  smooth();
  stroke(0);
  strokeWeight(5);
  fill(0);
  textSize(18);

  state = 0; // when the program loads, load the main menu


  rectMode(CORNER);

  buttonPlayGame = new Button("Play Game", (width/2), height/4);
  buttonExitGame = new Button("Exit Game", (width/2), height/2);
  player = new Adventurer(width/2, PApplet.parseInt(height*0.8f), width/2, PApplet.parseInt(height*0.8f)-(width/16), 48, 48, 3);
}

public void draw() {
  stateManager(state);
  player.update();
//dude = new Adventurer (xp, yp, hp, gb, atk, def);
//Adventurer(int xp, int yp, int hp, boolean gb, boolean atk, boolean def) {

}
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


  Adventurer(int xp, int yp, int xf, int yf, int xs, int ys, int hp) {
    //location of adventurer (rectmode(center))
    xpos = xp;
    ypos = yp;
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
  public void controls() {
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

  public void display() {
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


  public void update() {
    //update combines all class functions into one, less clutter on draw function.
    dropTime++;
    //iterates every frame for grabbing input delay

    controls();
    display();
  }
}
/* To use this function:
 * name ofthe button and the coordinate of the top of the button
 * Queen Huong aka Judy
 */

class Button {
  private String button_name;
  private float x; //Initial X position
  private float y; //Initial Y position
  private float w = 200; //Width of the button
  private float h = 100; //Height of the button

  Button(String _name, float _x, float _y) {
    button_name = _name;
    x = _x;
    y = _y;
  }

  public void showButton() {
    fill(255);
    rect(x, y, w, h);

    fill(0);
    text(button_name, x+(w/4), y+(h/2));
  }

  public boolean clicked() {
    if (mousePressed) {
      if (mouseX > (x-(w/2)) && mouseX < (x+(w/2)) && mouseY > (y-(h/2)) && mouseY < (y+(h/2))) {
        return true;
      }
    }
    return false;
  }
}
class Candle{
  int xPos, yPos, xSize, ySize;
  boolean move;

  Candle(int x, int y){
    xPos = x;
    yPos = y;
    xSize = 10;
    ySize = 30;
  }

  Candle(int x, int y, int _xSize, int _ySize){
    xPos = x;
    yPos = y;

    xSize = _xSize;
    ySize = _ySize;
  }

  public void draw(){
    rect(xPos, yPos, xSize, ySize);
  }
}
public void stateManager(int _state) {
  state = _state;
  //println("current state number: "+state);

  if (state == 0) {
    main_menu();
  }
  if (state == 1) {
    stage1();
  }
}

public void main_menu() {
  text(game_name, (width/2) - 100, 100); //name of the game
  buttonPlayGame.showButton();
  buttonExitGame.showButton();
  if (buttonPlayGame.clicked()||key=='1') {
    state = 1;
    println("play button clicked or press 1");
  } else if (buttonExitGame.clicked() || key == '2'){
    exit();
  }
}

public void stage1() {
  background(255);
  //println("game function loaded");

  if (finishLevel) {
    state++;
  }
}
//TEMP VARIABLES FOR ominous glow FUNCTION
float timer =32;
float flipper = 0.1f;

String game_name = "GGJ 2016";
int state;
boolean finishLevel = false;

//DECLARING CLASSES
Adventurer player; //player character
// Item box; // lighter/lit match
Button buttonPlayGame;
Button buttonExitGame;
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

  public void grabbing() {
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
  public void carrying() {
    //keeps carrying the item, by matching its coordinates with the facing zone of the adventurer class
    if (grabbed == true) {
      xpos = player.xfacing;
      ypos = player.yfacing;
    }
  }
  public void display() {
    //TEMP will display basic shape until sprite is ready
    fill(255, 255, 10, 128);
    rect(xpos, ypos, xsize, ysize);
  }
  public void update() {
    carrying();
    grabbing();
    display();
  }
}
class Level {
  int xpos, ypos;
  boolean door;

  public void walls() {
  }

  public void display() {
  }
}
class Pedastal{
/* interacts with the item class. 
Once the item shares coordinates with the pedastal,  
*/
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
