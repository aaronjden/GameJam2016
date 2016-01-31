// player move variable
boolean forwardPressed = false;
boolean backwardPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

//player move in arrow key direction till key is released
void keyPressed() {
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
void keyReleased() {
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
float flipper = 0.1;

void ominousGlow() {
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


