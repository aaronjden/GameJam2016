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

Button buttons;
String game_name = "GGJ 2016";
int state;
boolean finishLevel = false;

public void setup() {
  size(900, 600);
  background(255);
  smooth();
  stroke(1);
  strokeWeight(1);
  fill(0);
  textSize(18);

  state = 0; // when the program loads, load the main menu

  buttons = new Button("Play Game", (width/2)-150, height/4);
}

public void update() {
}

public void draw() {
  stateManager(state);
}
/*
character actions
 carry- item coordinates are locked to character based on position
 item x,y, character x,y, health, sprite gifs
 */
class Adventurer {
  int xpos, ypos, health, facing, xsize, ysize;
  // coordinate from center, 3 hearts, 0 to 3, north to west
  boolean grab, attack, defend;
  //grabbing object, attacking, defending functions.

  Adventurer(int xp, int yp, int xs, int ys, int hp, boolean gb, boolean atk, boolean def) {
	xpos = xp;
	ypos = yp;
	xsize = xs;
	ysize = ys;
	grab = gb;
	attack = atk;
	defend = def;

	/*
	functions to make
	boolean function for sharing coordinates with grabbed item
	boolean for defend where touching dangerous elements nullifies damage
	boolean for attack where if an enemy is within range, they lose health
	function for last direction faced- from 0 to 3 north clockwise

	*/
  }
}
/* To use this function:
 * name ofthe button and the coordinate of the top of the button
 */

class Button {
  String button_name;
  float x; //Initial X position
  float y; //Initial Y position
  float w = 200; //Width of the button
  float h = 100; //Height of the button

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
      if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
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
  buttons.showButton();
  if (buttons.clicked()||key=='1') {
    state = 1;
    println("play button clicked or press 1");
  }
}

public void stage1() {
  background(255);
  //println("game function loaded");

  if (finishLevel) {
    state++;
  }
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
