//V4-JACKY
Adventurer player;

Button buttonPlayGame;
Button buttonExitGame;

Enemy spider;
Staircase nextlevel;
Item box; // lighter/lit match

String game_name = "GGJ 2016";
int state;
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

  state = 0; // when the program loads, load the main menu


  player = new Adventurer(width/2, int(height*0.8), width/2, int(height*0.8)-(width/16), 48, 48, 3, false, false, false);

  buttonPlayGame = new Button("Play Game", width/2, height/2);
  buttonExitGame = new Button("Exit Game", width/2, height*0.75);

  nextlevel = new Staircase(200, 200); //progress to the next level
  box = new Item(width/8, height/8, 16, 16, false);
  // Item(int xp, int yp, int xs, int ys, boolean gb)
  spider = new Enemy(width/2, int(height*0.2), 64, 64, 3, 3);
  //enemy(int xp, int yp, int xs, int ys, int hp)
}

void draw() {
  ominousGlow(); //background glowing effect, either temporary or to be overlayed over sprite assets

  stateManager(state);
}