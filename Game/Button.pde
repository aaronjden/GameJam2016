/* To use this function:
 * name ofthe button and the coordinate of the top of the button
 */

class Button {
  String button_name;
  float x; //Initial X position
  float y; //Initial Y position
  float w = 200; //Width of the button
  float h = 100; //Height of the button

  Button(String _name, float _x, float _y) {
    button_name = _name;
    x = _x;
    y = _y;
  }

  void showButton() {
    fill(255);
    rect(x, y, w, h);

    fill(0);
    text(button_name, x+(w/4), y+(h/2));
  }

  boolean clicked() {
    if (mousePressed) {
      if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
        return true;
      }
    }
    return false;
  }
}