class Candle {
  int xPos, yPos, xSize, ySize;
  boolean move;

  Candle(int x, int y) {
    xPos = x;
    yPos = y;
    xSize = 10;
    ySize = 30;
  }

  Candle(int x, int y, int _xSize, int _ySize) {
    xPos = x;
    yPos = y;

    xSize = _xSize;
    ySize = _ySize;
  }

  void draw() {
    rect(xPos, yPos, xSize, ySize);
  }
}