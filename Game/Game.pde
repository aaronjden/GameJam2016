/*
 * Queen Huong aka Judy
 */

Button buttons;
String game_name = "GGJ 2016";
int state;
boolean finishLevel = false;

void setup() {
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

void draw() {
  stateManager(state);
}
