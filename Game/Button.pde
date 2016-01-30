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

  private color highlight = color(250, 20, 20, 70);
  private color normlight = color(0, 0, 0, 50);

  Button(String _name, float _x, float _y) {
    button_name = _name;
    x = _x;
    y = _y;
  }

  void showButton() {
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

  boolean clicked() {
    if (mousePressed) {
      if (mouseX > (x-(w/2)) && mouseX < (x+(w/2)) && mouseY > (y-(h/2)) && mouseY < (y+(h/2))) {
        return true;
      }
    }
    return false;
  }

  boolean mouseOver() {
    if (mouseX > (x-(w/2)) && mouseX < (x+(w/2)) && mouseY > (y-(h/2)) && mouseY < (y+(h/2))) {
      return true;
    }
    return false;
  }
}