/*gameJam2016
 // Class by Joel Mayner
 hellBinger- by Joel Mayner, Rahmin Nassiri, Huong Khong, Aaron Dennis, Jacky Wang 
 
 
 */
//TEMP VARIABLES FOR ominous glow FUNCTION
float timer =32;
float flipper = 0.1;

//DECLARING CLASSES
Adventurer player; //player character
Item box; // lighter/lit match

void setup() {
  size(666, 666); //mark of the beast on a 1:1 ratio. 
  //initialising player character 
  player = new Adventurer(width/2, int(height*0.8), width/2, int(height*0.8)-(width/16), 48, 48, 3, false, false, false);
  //  Adventurer(int xp, int yp, int xf, int yf, int xs, int ys, int hp, boolean gb, boolean atk, boolean def) {
  box = new Item(width/8, height/8, 16, 16, false);
  // Item(int xp, int yp, int xs, int ys, boolean gb) {
}

void draw() {

  ominousGlow();
  //background glowing effect, either temporary or to be overlayed over sprite assets

  player.update();
  //update player's activity
  box.update();
  //update box's activity
}

void ominousGlow() {
  //glowing effect, from dark red to red

  background(timer, timer/3, 32);
  //dominant red or brown with static blue.

  timer= timer + flipper;
  //colour changes in realtime.

  //flipper flips (reverses) colour progression
  if ( timer < 32 || timer > 128) {
    flipper= flipper *(-1);
    //progression becomes either positive or negative
  }
}