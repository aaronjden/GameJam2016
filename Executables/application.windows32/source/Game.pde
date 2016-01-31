//V4-Aaron

String game_name = "The R";
int state;
int tempState;
boolean finishLevel = false;

void setup() {
  frameRate(60);
  size(900, 600);
  background(255);
  smooth();
  stroke(1);
  strokeWeight(1);
  fill(0);
  textSize(18);

  state = 0; // when the program loads, load the main menu. Ref: GameStates tab

  //Setup Tab
  audioLoad();
  buttonsLoad();
  otherObjectsLoad();
}

void draw() {
  ominousGlow(); //background glowing effect, either temporary or to be overlayed over sprite assets
  stateManager(state);
}

