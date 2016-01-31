import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Game extends PApplet {

//V4-Aaron

String game_name = "The R";
int state;
int tempState;
boolean finishLevel = false;

public void setup() {
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

public void draw() {
  ominousGlow(); //background glowing effect, either temporary or to be overlayed over sprite assets
  stateManager(state);
}

/*
character actions
 carry- item coordinates are locked to character based on position
 item x,y, character x,y, health, sprite gifs
 //
 */

class Adventurer {
  int xpos, ypos, xsize, ysize, health, xfacing, yfacing, dropTime; 
  //
  int gridSize = 64;
  // coordinate from center, 3 hearts, 0 to 3, north to west
  boolean grab, attack, defend; 
  //grabbing object, attacking, defending functions.

  int spriteWidth, spriteHeight;
  int currentFrame;
  int spriteFrames;
  int spriteDir;
  PImage [] leftSprites, upSprites, rightSprites, downSprites;
  //required for animation and loading sprites


    Adventurer(int xp, int yp, int xf, int yf, int xs, int ys, int hp, boolean gb, boolean atk, boolean def) {
    //location of adventurer (rectmode(center))
    xpos = xp;
    ypos = yp;
    //size of adventurer (should be the same size if square)
    xsize = xs;
    ysize = ys;
    //location in front of adventurer, objects in this zone can be interacted with.
    xfacing = xf;
    yfacing = yf;
    //checks if the character is grabbing anything
    grab = gb;

    //TO BE IMPLEMENTED: attacking and defending functions 
    attack = atk;
    defend = def;
    /*
    functions to make
     boolean function for sharing coordinates with grabbed item
     boolean for defend where touching dangerous elements nullifies damage
     boolean for attack where if an enemy is within range, they lose health
     character size is 24px
     function for last direction faced- from 0 to 3 north clockwise
     */

    spriteWidth = 32;
    spriteHeight = 32;
    spriteFrames = 4;
    currentFrame = 0;

    spriteDir = 3;

    leftSprites = new PImage[spriteFrames];
    upSprites = new PImage[spriteFrames];
    rightSprites = new PImage[spriteFrames];
    downSprites = new PImage[spriteFrames];

    for (int i = 0; i < spriteFrames; i++) {
      leftSprites[i] = loadImage("player/left"+nf(i, 1)+".png");
      upSprites[i] = loadImage("player/up"+nf(i, 1)+".png");
      rightSprites[i] = loadImage("player/right"+nf(i, 1)+".png");
      downSprites[i] = loadImage("player/down"+nf(i, 1)+".png");
    }
  }

  public void controls() {
    if (keyPressed == true) {
      //directional button pressed will allow movement as long as it is not off screen
      if (forwardPressed) {
        ypos -= 2.0f;

        yfacing = ypos-ysize;
        xfacing = xpos;
      }

      if (backwardPressed) {
        ypos += 2.0f;

        yfacing = ypos+ysize;
        xfacing = xpos;

        if (ypos > 700) {
          ypos = 700;
        }
      }

      if (leftPressed) {
        xpos -= 2.0f;

        xfacing = xpos-xsize;
        yfacing = ypos;

        if (xpos < 0) {
          xpos = 0;
        }
      }

      if (rightPressed) {
        xpos += 2.0f;

        xfacing = xpos+xsize;
        yfacing = ypos;

        if (xpos > width - 10) {
          xpos = width - 10;
        }
      }

      /*spacebar to grab
       Prevention of rapid repeated inputs is required to pick up and drop item effectively. 
       dropTime implemented as a delay.*/
      if (key == ' ' && dropTime > 10) {
        if (grab ==false && dropTime > 10) {
          grab = true;
        } else if (grab == true ) {
          grab = false;
          //lets go if grabbed
        }
        dropTime = 0; //resets dropTime variable to prevent rapid repeated inputs
      }
    }

    //add control actions for attacking, defending, grabbing and dropping
  }

  public void display() {
    //updates screen with character visuals

    //renews properties of stroke, strokeWeight, fill, and rectMode for shapes
    stroke(0); //black outline
    strokeWeight(1); //thin outline
    rectMode(CENTER); //coordinates from centre of shape

    //white adventurer square
    fill(255); // white
    rect(xpos, ypos, xsize, ysize);

    //adventurer facing zone outline colour (transparent hollow white square)
    stroke(255, 128);
    noFill();
    //if character is grabbing, respective outlines become thicker
    if (grab == true) {
      strokeWeight(3);
    } else {
      strokeWeight(1);
    }
    //adventurer facing zone- same size as adventurer square
    rect(xfacing, yfacing, xsize, ysize);

    // character animation direction based on keypress
    pushMatrix();
    pushStyle();
    imageMode(CENTER);
    if (keyPressed) {
      if (key == 'a') {
        image(leftSprites[currentFrame], xpos, ypos);
        if (frameCount % 10 == 0) {
          currentFrame++;
        }
        spriteDir = 0;
      } else if (key == 'w') {
        image(upSprites[currentFrame], xpos, ypos);
        if (frameCount % 10 == 0) {
          currentFrame++;
        }
        spriteDir = 1;
      } else if (key == 'd') {
        image(rightSprites[currentFrame], xpos, ypos);
        if (frameCount % 10 == 0) {
          currentFrame++;
        }
        spriteDir = 2;
      } else if (key == 's') {
        image(downSprites[currentFrame], xpos, ypos);
        if (frameCount % 10 == 0) {
          currentFrame++;
        }
        spriteDir = 3;
      }
      if (currentFrame >= spriteFrames)
      {
        currentFrame = 0;
      }
    }
    //idle direction based on last pressed direction
    else {
      if (spriteDir == 0) {
        image(leftSprites[0], xpos, ypos);
        currentFrame = 0;
      } else if (spriteDir == 1) {
        image(upSprites[0], xpos, ypos);
        currentFrame = 0;
      } else if (spriteDir == 2) {
        image(rightSprites[0], xpos, ypos);
        currentFrame = 0;
      } else if (spriteDir == 3) {
        image(downSprites[0], xpos, ypos);
        currentFrame = 0;
      }
    } 
    popStyle();
    popMatrix();
  }

  public void update() {
    //update combines all class functions into one, less clutter on draw function.
    dropTime++; 
    //iterates every frame for grabbing input delay

    controls(); 
    display();
  }
}

public void muteChange(AudioPlayer y) {
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

public void muteChange(AudioPlayer x, AudioPlayer y, AudioPlayer z) {
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

public void audioLoop(AudioPlayer x) {
  if (x.position() == x.length()) {
    x.rewind();
    x.play();
  } else {
    x.play();
  }
}

public void audioStop(AudioPlayer z) {
  z.pause();
  z.rewind();
}

public void muteAll() {
  audioStop(musicMainMenu);
  audioStop(musicPaused);
  audioStop(musicGameOver);
  audioStop(musicNextLevel);
  audioStop(musicGameStart);
  audioStop(musicSpider);
}
/* To use this function:
 * name ofthe button and the coordinate of the top of the button
 * Queen Huong aka Judy
 */

class Button {
  private String button_name;
  private float x; //Initial X position
  private float y; //Initial Y position
  private float w = 200; //Width of the button
  private float h = 100; //Height of the button

  private int highlight = color(250, 20, 20, 70);
  private int normlight = color(0, 0, 0, 50);

  Button(String _name, float _x, float _y) {
    button_name = _name;
    x = _x;
    y = _y;
  }

  Button(String _name, float _x, float _y, float _w, float _h) {
    button_name = _name;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }


  public void showButton() {
    rectMode(CENTER);
    if (mouseOver()) {
      stroke(192, 0, 0);
      fill(highlight);
    } else {
      stroke(255);
      fill(normlight);
    }
    rect(x, y, w, h);

    textAlign(CENTER);

    fill(255);
    text(button_name, x, y);
  }

  public void changeLocation(float _x, float _y) {
    x = _x;
    y = _y;
  }

  public void changeText(String _name) {
    button_name = _name;
  }

  public void changeSize(float _w, float _h) {
    w = _w;
    h = _h;
  }

  public boolean clicked() {
    if (mousePressed) {
      if (mouseX > (x-(w/2)) && mouseX < (x+(w/2)) && mouseY > (y-(h/2)) && mouseY < (y+(h/2))) {
        return true;
      }
    }
    return false;
  }

  public boolean mouseOver() {
    if (mouseX > (x-(w/2)) && mouseX < (x+(w/2)) && mouseY > (y-(h/2)) && mouseY < (y+(h/2))) {
      return true;
    }
    return false;
  }
}

public void playGame() {
  buttonPlayGame.showButton();
  if (buttonPlayGame.clicked()||key=='1') {
    println("play button clicked or press 1");
    state = 10;
    tempState = 1;
    musicMainMenu.rewind();
    musicMainMenu.pause();
  }
}

public void exitGame() {
  buttonExitGame.showButton();
  if (buttonExitGame.clicked() || key == '2') {
    println("exit clicked or press 2");
    exit();
  }
}

//Paused screen
public void paused() {
  audioLoop(musicPaused);
  buttonResume.showButton();
  muteChange(musicPaused);
  returnToMenu();
  if (buttonResume.clicked() || key == 'r') {
    state = tempState;
    audioStop(musicPaused);
  }
}

public void buttonContinue() {
  buttonPlayOn.changeText("Continue to level " + tempState);
  buttonPlayOn.showButton();
  returnToMenu();
  if (buttonPlayOn.clicked() || key == 'c') {
    state = tempState;
    audioStop(musicNextLevel);
//    musicNextLevel.pause();
  }
}

public void buttonGameOver(){
  buttonTryAgain.showButton();
  if (buttonTryAgain.clicked()){
    state = tempState;
  }
}

public void returnToMenu() {
  buttonReturnMenu.showButton();
  if (buttonReturnMenu.clicked() || key == 'x') {
    audioStop(musicNextLevel);
    state = 0;
    tempState = 0;
    imageMode(CENTER);
  }
}

class Candle {
  int xPos, yPos, xSize, ySize;
  boolean litUp1;
  //is candle lit?
  PImage unlit;
  PImage[] lit = new PImage[3];
  int counter1 = 0;

  Candle() {
    xPos = PApplet.parseInt(random(10, 170)) * 5;
    yPos = PApplet.parseInt(random(10, 110)) * 5;
    xSize = 10;
    ySize = 30;
    unlit = loadImage("sprites/candle 1.png");

    for (int i = 1; i< 3; i++) {
      lit[i] = loadImage("sprites/candle "+nf(i+1, 1)+".png");
    }
  }

  Candle(int x, int y) {
    xPos = x;
    yPos = y;
    xSize = 10;
    ySize = 30;
    unlit = loadImage("sprites/candle 1.png");

    for (int i = 1; i< 3; i++) {
      lit[i] = loadImage("sprites/candle "+nf(i+1, 1)+".png");
    }
  }

  Candle(int _x, int _y, int _xSize, int _ySize) {
    xPos = _x;
    yPos = _y;

    xSize = _xSize;
    ySize = _ySize;
    litUp1 = false;
    //void light(){
    //if (Candle ypos match.xpos < )
    unlit = loadImage("sprites/candle 1.png");

    for (int i = 1; i< 3; i++) {
      lit[i] = loadImage("sprites/candle "+nf(i+1, 1)+".png");
    }
  }

  public boolean litUp(Item x) {
    //match proximity  
    //if (x.xpos > x
    if (
    x.xpos > xPos-xSize
      &&
      x.xpos < xPos + xSize
      &&
      x.ypos > yPos-ySize
      &&
      x.ypos < yPos + ySize
      &&
      x.grabbed == false) {
      litUp1 = true;
      return true;
    } else {
      litUp1 = false;
    }
    return false;
  }


  public void animation() {
    if (litUp1 == true) {
      image(lit[1], xPos, yPos);
      /*if (counter1 < 1) {
        counter1++;
      }
      if (counter1 >= 2) {
        counter1 = 0;
      }*/
      
    } else {
      image(unlit, xPos, yPos);
    }
  }

  public void display() {
    fill(255);
    ellipse(xPos, yPos, xSize, ySize);
    //imageMode(CENTER);
    animation();
  }

  public void update() {
    display();
  }
}

public void stateManager(int _state) {
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


public void main_menu() {
  //text(game_name, width/2, height/4); //name of the game
  //  frameRate(5);

  image(fireLogo, width/2, height/4);
  muteChange(musicMainMenu);
  playGame();
  exitGame();
}

//Splash screen shown between levels
public void continueScreen() { 
  frameRate(60);
  audioLoop(musicNextLevel);
  buttonContinue();
}

//This function is to be run in the levels to check if the p key was pressed to pause the game
public void pauseGame() {
  if (key == 'p' || key == 'P') {
    state = 11;
  }
}

public void gameOver() {
  buttonGameOver();
}

public void stage1() {
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

public void stage2() {
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

// player move variable
boolean forwardPressed = false;
boolean backwardPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

//player move in arrow key direction till key is released
public void keyPressed() {
  //single arrow keys
  if (key == 'w') {
    forwardPressed = true;
  } else if (key == 's') {
    backwardPressed = true;
  } else if (key == 'd') {
    rightPressed = true;
  } else if (key== 'a') {
    leftPressed = true;
  }
}

//player let go of arrow key, will stop moving in key direction
public void keyReleased() {
  if (key == 'w') {
    forwardPressed = false;
  } else if (key == 's') {
    backwardPressed = false;
  } else if (key == 'a') {
    leftPressed = false;
  } else if (key == 'd') {
    rightPressed = false;
  }
}


//TEMP VARIABLES FOR ominous glow FUNCTION
float timer =32;
float flipper = 0.1f;

public void ominousGlow() {
  //glowing effect, from dark red to red

  background(timer, timer/3, 32);
  //dominant red or brown with static blue.

  timer= timer + flipper;
  //colour changes in realtime.

  //flipper flips (reverses) colour progression
  if ( timer < 32 || timer > 128) {
    flipper= flipper *(-1);
    //progression becomes either positive or negative
  }
}



Minim minim;
AudioPlayer musicMainMenu, musicPaused, musicGameOver, musicNextLevel;
AudioPlayer musicGameStart, musicSpider;

Button muteToggle;
boolean mute = false;

public void audioLoad() {
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

public void buttonsLoad() {
  buttonPlayGame = new Button("Play Game", width/2, height/2);
  buttonExitGame = new Button("Exit Game", width/2, height*0.75f);
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

public void otherObjectsLoad() {
  player = new Adventurer(width/2, PApplet.parseInt(height*0.8f), width/2, PApplet.parseInt(height*0.8f)-(width/16), 48, 48, 3, false, false, false);
  candle = new Candle(width/2, height/2, 30, 30);
  nextlevel = new Staircase(200, 200); //progress to the next level
  match = new Item(16, 16);
  // Item(int xp, int yp, int xs, int ys, boolean gb)
  spider = new Enemy(width/2, PApplet.parseInt(height*0.2f), 64, 64, 3, 3);
  //enemy(int xp, int yp, int xs, int ys, int hp)
  imageMode(CENTER);
  fireLogo = loadImage("logo/fireLogoGif.gif", "gif");
}

class Enemy {
  int xpos, ypos, xsize, ysize, health;
  float speed; 
  int randRun;
  PImage [] spider = new PImage[5];
  int counter = 0;
  int temp = 1;

  Enemy(int xp, int yp, int xs, int ys, int hp, float sp) {
    xpos = xp;
    ypos = yp;
    xsize = xs;
    ysize = ys;
    speed = sp;
    health = hp;
    for (int i = 0; i<4; i++) {
      spider[i] = loadImage("sprites/spider "+ nf(i+1, 1) + ".png");
    }
  }


  public void following() {
    //add a random variable to determine which direction it moves in first

    for (int i = i=0; i<3; i++) {   
      randRun = PApplet.parseInt(random(0, 3));


      if (player.ypos < ypos && randRun == 0) { //if mouseY is smaller than targeypos:
        ypos= ypos- PApplet.parseInt(speed); //move down
      }
      if (player.ypos > ypos && randRun == 0) {  //if mouseY is larger than targeypos:
        ypos= ypos+ PApplet.parseInt(speed); //move up
      }

      if (player.xpos < xpos && randRun == 1) { //if the mouseX is smaller than targexpos:
        xpos= xpos-PApplet.parseInt(speed); //move right
      }
      if (player.xpos > xpos && randRun == 1) {  //if mouseX is larger than targexpos:
        xpos= xpos+PApplet.parseInt(speed); //move left
      }
    }
  }



  public void speed() {
    speed = speed-0.03f;
    if (speed < -3) {
      speed = 5;
    }
  }

  public void display() {
    strokeWeight(2);
    stroke(255, 0, 128);
    rectMode(CENTER);
    fill(255, 0, 72);
    rect(xpos, ypos, xsize, ysize);
    pushMatrix();
    imageMode(CENTER);
    image(spider[counter], xpos, ypos);
    popMatrix();
  }

  public void update() {
    following();
    speed();
    display();
  }
}

class Item {
  int xpos, ypos, xsize, ysize;
  //coordinates of iterm
  boolean grabbed = false;
  //decides if item coords are locked to character
  PImage match;
  Item(int xs, int ys) {
    xpos = PApplet.parseInt(random(10, ((width/5)-10))) * 5;
    ypos = PApplet.parseInt(random(10, ((height/5)-10))) * 5;

    xsize = xs;
    ysize = ys;
    
    match = loadImage("sprites/match 2.png");
    grabbed = false;
  }

  Item(int xp, int yp, int xs, int ys, boolean gb) {
    //location of item
    xpos = xp;
    ypos = yp;

    //size of image
    xsize = xs;
    ysize = ys;
    
    match = loadImage("sprites/match2.png");
    //checks if item has been grabbed (indirectly related to character grab function
    grabbed = gb;
  }

  public void grabbing() {
    //checks player facing variables to see if item is within the grabbing zone
    //24 has been chosen as the area range, no issues with it so far.
    if (
    xpos - player.xfacing < 24 && 
      xpos - player.xfacing > -24 &&
      ypos - player.yfacing < 24 && 
      ypos - player.yfacing > -24
      && player.grab == true
      ) {

      grabbed = true;
    } else {
      grabbed = false;
    }
  }
  public void carrying() {
    //keeps carrying the item, by matching its coordinates with the facing zone of the adventurer class
    if (grabbed == true) {
      xpos = player.xfacing;
      ypos = player.yfacing;
    }
  }
  public void display() {
    //TEMP will display basic shape until sprite is ready
    fill(255, 255, 10, 128);
    rect(xpos, ypos, xsize, ysize);
    image(match, xpos, ypos);
  }
  public void update() {
    carrying();
    grabbing();
    display();
  }
}

class Level {
  int xpos, ypos;
  boolean door;

  public void walls() {
  }

  public void display() {
  }
}
class Staircase {
  private int squareSize = 50;
  private int x, y; //coordinate of the staircase
  private int xpos, ypos; //player coordinate
  int counter = 0;
  PImage doorClosed;
  PImage [] door = new PImage[6];
  boolean complete = false;

  Staircase() {
    x = PApplet.parseInt(random(10, ((width/5)-10))) * 5;
    y = PApplet.parseInt(random(10, ((height/5)-10))) * 5;
    
    doorClosed = loadImage("sprites/door 1.png");
    for (int i = 2; i<6; i++) {
      door[i] = loadImage("sprites/door "+ nf(i, 1) + ".png");
    }
  }

  Staircase(int _x, int _y) {
    x = _x; 
    y = _y;
    
    doorClosed = loadImage("sprites/door 1.png");
    for (int i = 1; i<6; i++) {
      door[i] = loadImage("sprites/door "+ nf(i, 1) + ".png");
    }
  }

  public void display() {
    fill(0); 
    stroke(1); 
    strokeWeight(1); 
    rect(x, y, squareSize, squareSize); 
    imageMode(CENTER);

    if (complete == false) {
      closeDoor();
    } else if (complete) {
      openDoor();
    }
  }

  public boolean playerOver(int _xpos, int _ypos) {
    xpos = _xpos; 
    ypos = _ypos; 
    if (xpos > (x-(squareSize/2)) && xpos < (x+(squareSize/2)) && ypos > (y-(squareSize/2)) && ypos < (y+(squareSize/2))) {
      return true;
    }
    return false;
  }

  public void openDoor() {
    while (counter<5) {
      counter++;
    }
    image(door[counter], x, y);
  }

  public void closeDoor() {
    image(doorClosed, x, y);
    counter = 0;
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
