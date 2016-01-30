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

  buttonPlayGame.showButton();
  buttonExitGame.showButton();

  if (buttonPlayGame.clicked()||key=='1') {
    println("play button clicked or press 1");
    state = 1;
  } else if (buttonExitGame.clicked() || key == '2') {
    println("exit clicked or press 2");
    exit();
  }
}

void stage1() {
  //println("game function loaded");

  background(255);
  dude.update();

  if (finishLevel) {
    state++;
  }
}