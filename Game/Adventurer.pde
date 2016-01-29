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
