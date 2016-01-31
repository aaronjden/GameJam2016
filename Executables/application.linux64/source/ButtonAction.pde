void playGame() {
  buttonPlayGame.showButton();
  if (buttonPlayGame.clicked()||key=='1') {
    println("play button clicked or press 1");
    state = 10;
    tempState = 1;
    musicMainMenu.rewind();
    musicMainMenu.pause();
  }
}

void exitGame() {
  buttonExitGame.showButton();
  if (buttonExitGame.clicked() || key == '2') {
    println("exit clicked or press 2");
    exit();
  }
}

//Paused screen
void paused() {
  audioLoop(musicPaused);
  buttonResume.showButton();
  muteChange(musicPaused);
  returnToMenu();
  if (buttonResume.clicked() || key == 'r') {
    state = tempState;
    audioStop(musicPaused);
  }
}

void buttonContinue() {
  buttonPlayOn.changeText("Continue to level " + tempState);
  buttonPlayOn.showButton();
  returnToMenu();
  if (buttonPlayOn.clicked() || key == 'c') {
    state = tempState;
    audioStop(musicNextLevel);
//    musicNextLevel.pause();
  }
}

void buttonGameOver(){
  buttonTryAgain.showButton();
  if (buttonTryAgain.clicked()){
    state = tempState;
  }
}

void returnToMenu() {
  buttonReturnMenu.showButton();
  if (buttonReturnMenu.clicked() || key == 'x') {
    audioStop(musicNextLevel);
    state = 0;
    tempState = 0;
    imageMode(CENTER);
  }
}

