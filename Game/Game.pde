Adventurer dude;

Button buttonPlayGame;
Button buttonExitGame;

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

  dude = new Adventurer(width/2, int(height*0.8), 3, false, false, false);

  buttonPlayGame = new Button("Play Game", (width/2)-150, height/4);
  buttonExitGame = new Button("Exit Game", )
}

void update() {
}

void draw() {
  stateManager(state);
  dude.update();
//dude = new Adventurer (xp, yp, hp, gb, atk, def);
//Adventurer(int xp, int yp, int hp, boolean gb, boolean atk, boolean def) {

}
