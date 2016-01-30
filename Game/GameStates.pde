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
  //text(game_name, (width/2) - 100, 100); //name of the game

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

  player.update(); //update player's activity
  box.update(); //update box's activity
  spider.update(); //update enemy's activity
  nextlevel.display();

  if (box.grabbed == true && nextlevel.playerOver(player.xpos, player.ypos)) {
    println("player goes to the next level");
    state++;
  }
}

void stage2() {
}