void setup() {
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
  player = new Adventurer(width/2, int(height*0.8), width/2, int(height*0.8)-(width/16), 48, 48, 3);
}

void draw() {
  stateManager(state);
  player.update();
//dude = new Adventurer (xp, yp, hp, gb, atk, def);
//Adventurer(int xp, int yp, int hp, boolean gb, boolean atk, boolean def) {

}
