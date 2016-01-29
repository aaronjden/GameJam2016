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

public void setup(){
  size(900, 600);
  smooth();
}

public void draw(){

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
class Candle{
  int xPos, yPos, xSize, ySize;
  boolean move;

  Candle(int x, int y, int _xSize, int _ySize){
    xPos = x;
    yPos = y;

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
