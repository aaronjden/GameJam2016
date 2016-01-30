class Staircase {
  private int squareSize = 50;
  private int x, y; //coordinate of the staircase
  private int xpos, ypos; //player coordinate

  Staircase(int _x, int _y) {
    x = _x;
    y = _y;
  }

  void display() {
    fill(0);
    stroke(1);
    strokeWeight(1);
    rect(x, y, squareSize, squareSize);
  }

  boolean playerOver(int _xpos, int _ypos) {
    xpos = _xpos;
    ypos = _ypos;
    if (xpos > (x-(squareSize/2)) && xpos < (x+(squareSize/2)) && ypos > (y-(squareSize/2)) && ypos < (y+(squareSize/2))) {
      return true;
    }
    return false;
  }
}