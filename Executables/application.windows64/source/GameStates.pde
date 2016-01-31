void stateManager(int _state) {
  state = _state;
  //println("current state number: "+state);

  if (state == 0) {
    main_menu();
  } else if (state == 1) {
    stage1();
  } else if (state == 2) {
    stage2();
  } else if (state == 10) {
    continueScreen();
  } else if (state == 11) {
    paused();
  } else if (state == 12) {
    gameOver();
  } else {
    state = 0;
  }
}


void main_menu() {
  //text(game_name, width/2, height/4); //name of the game
  //  frameRate(5);

  image(fireLogo, width/2, height/4);
  muteChange(musicMainMenu);
  playGame();
  exitGame();
}

//Splash screen shown between levels
void continueScreen() { 
  frameRate(60);
  audioLoop(musicNextLevel);
  buttonContinue();
}

//This function is to be run in the levels to check if the p key was pressed to pause the game
void pauseGame() {
  if (key == 'p' || key == 'P') {
    state = 11;
  }
}

void gameOver() {
  buttonGameOver();
}

void stage1() {
  //println("game function loaded");

  player.update(); //update player's activity
  //  box.update(); //update box's act//ivit/y
  candle.update();
  match.update(); //update match's activity

  nextlevel.display();
  pauseGame();
  if (!mute) {
    audioLoop(musicGameStart);
  }
  if (candle.litUp(match)) {
    audioStop(musicGameStart);
    if (!mute) {
      audioLoop(musicSpider);
    }
    spider.update(); //update enemy's activity
    nextlevel.openDoor();
  }
  if (candle.litUp(match) == true && nextlevel.playerOver(player.xpos, player.ypos)) {
    if (match.grabbed == false) {
      nextlevel.complete = true;
      audioStop(musicSpider);
    } else {
      nextlevel.complete = false;
    }
    println("player goes to the next level");
    tempState++;
    state = 10;
  }
}

void stage2() {
  player.update(); //update player's activity
  match.update(); //update box's activity
  spider.update(); //update enemy's activity
  nextlevel.display();
  pauseGame();
  if (match.grabbed == true && nextlevel.playerOver(player.xpos, player.ypos)) {
    println("player goes to the next level");
    tempState++;
    state = 10;
  }
}

