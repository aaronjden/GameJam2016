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

  Button(String _name, float _x, float _y) {
    button_name = _name;
    x = _x;
    y = _y;
  }

  void showButton() {
    fill(255);
    rect(x, y, w, h);
<<<<<<< HEAD
    
    textAlign(CENTER);
=======

>>>>>>> parent of 9ff4e52... Centered buttons (in the class)
    fill(0);
    text(button_name, x+(w/4), y+(h/2));
  }

  boolean clicked() {
    if (mousePressed) {
      if (mouseX > (x-(w/2)) && mouseX < (x+(w/2)) && mouseY > (y-(h/2)) && mouseY < (y+(h/2))) {
        return true;
      }
    }
    return false;
  }
}