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

void update() {
}

void draw() {
  stateManager(state);
}

void stateManager(int _state) { 
  state = _state;
  //println("current state number: "+state);

  if (state == 0) {
    main_menu();
  }
  if (state == 1) {
    stage1();
  }
}

void main_menu() {
  text(game_name, (width/2) - 100, 100); //name of the game
  buttons.showButton();
  if (buttons.clicked()||key=='1') {
    state = 1;
    println("play button clicked or press 1");
  }
}

void stage1() {
  background(255);
  //println("game function loaded");

  if (finishLevel) {
    state++;
  }
}