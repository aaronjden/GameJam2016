void muteChange(AudioPlayer y) {
  muteToggle.showButton();
  if (muteToggle.clicked() || key == 'm') {
    mute = !mute;
  }
  if (!mute) {    
    muteToggle.changeText("Mute Audio");
    audioLoop(y);
  } else if (mute) {
    muteToggle.changeText("Unmute Audio"); 
    y.pause();
    y.rewind();
  }
}

void muteChange(AudioPlayer x, AudioPlayer y, AudioPlayer z) {
  muteToggle.showButton();
  if (muteToggle.clicked() || key == 'm') {
    mute = !mute;
  }
  if (!mute) {    
    muteToggle.changeText("Mute Audio");
    audioLoop(y);
  } else if (mute) {
    muteToggle.changeText("Unmute Audio"); 
    y.pause();
    y.rewind();
  }
}

void audioLoop(AudioPlayer x) {
  if (x.position() == x.length()) {
    x.rewind();
    x.play();
  } else {
    x.play();
  }
}

void audioStop(AudioPlayer z) {
  z.pause();
  z.rewind();
}

void muteAll() {
  audioStop(musicMainMenu);
  audioStop(musicPaused);
  audioStop(musicGameOver);
  audioStop(musicNextLevel);
  audioStop(musicGameStart);
  audioStop(musicSpider);
}
