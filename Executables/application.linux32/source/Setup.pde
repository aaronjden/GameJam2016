import ddf.minim.*;
Minim minim;
AudioPlayer musicMainMenu, musicPaused, musicGameOver, musicNextLevel;
AudioPlayer musicGameStart, musicSpider;

Button muteToggle;
boolean mute = false;

void audioLoad() {
  muteToggle = new Button("Mute Audio", width - 100, height - 50);
  minim = new Minim(this);
  musicMainMenu = minim.loadFile("audio/menu.mp3");
  musicPaused = minim.loadFile("audio/menu.mp3");
  musicGameOver = minim.loadFile("audio/gameOver.mp3");
  musicNextLevel = minim.loadFile("audio/nextLevel.mp3");
  
  musicGameStart = minim.loadFile("audio/gameStart.mp3");
  musicSpider = minim.loadFile("audio/spider.mp3");
}

Button buttonPlayGame;
Button buttonExitGame;
Button buttonPlayOn;
Button buttonResume;
Button buttonReturnMenu;
Button buttonTryAgain;

void buttonsLoad() {
  buttonPlayGame = new Button("Play Game", width/2, height/2);
  buttonExitGame = new Button("Exit Game", width/2, height*0.75);
  buttonPlayOn = new Button("Continue to level " + tempState + "\n Press c to continue", width/2, height/2);
  buttonResume = new Button("Press r to \n resume game", width/2, height/2);
  buttonReturnMenu = new Button("Exit to menu", 100, height - 50);
  buttonTryAgain = new Button("Try Again!", width/2, height/2);
}

Adventurer player;
Enemy spider;
Staircase nextlevel;
Item match; // lighter/lit match
Candle candle;
PImage fireLogo;

void otherObjectsLoad() {
  player = new Adventurer(width/2, int(height*0.8), width/2, int(height*0.8)-(width/16), 48, 48, 3, false, false, false);
  candle = new Candle(width/2, height/2, 30, 30);
  nextlevel = new Staircase(200, 200); //progress to the next level
  match = new Item(16, 16);
  // Item(int xp, int yp, int xs, int ys, boolean gb)
  spider = new Enemy(width/2, int(height*0.2), 64, 64, 3, 3);
  //enemy(int xp, int yp, int xs, int ys, int hp)
  imageMode(CENTER);
  fireLogo = loadImage("logo/fireLogoGif.gif", "gif");
}

