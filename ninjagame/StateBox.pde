//Provides a panel class
class StateBox extends RectSpriteBase implements IInteractable {
  boolean active; //If the button is currently active
  //Colors:
  color backingColor = color(128);
  color activeColor = color(64, 0, 128);
  //Constructors
  StateBox(float x, float y, float width, float height, int border) {
    super(x, y, width, height, border);
  }
  //Render object
  void render() {
    super.render();
    myself.fill(backingColor);
    PVector[] pts = getRectPointsRotated();
    myself.quad(pts[0].x, pts[0].y, pts[1].x, pts[1].y, pts[2].x, pts[2].y, pts[3].x, pts[3].y);
    //Draw the X if active
    if (active) {
      myself.fill(activeColor);
      myself.line(pts[0].x, pts[0].y, pts[2].x, pts[2].y);
      myself.line(pts[1].x, pts[1].y, pts[3].x, pts[3].y);
    }
  }
  
  //Object update is requested
  void update() {
    if (mousePressed && isIntersecting(new PVector(mouseX, mouseY))) active = !active;
  }
  
  //Clone the object
  Object clone() {
    var toret = new StateBox(position.x, position.y, size.width, size.height, border);
    toret.angle = angle;
    toret.borderColor = borderColor;
    toret.activeColor = activeColor;
    toret.backingColor = backingColor;
    toret.active = active;
    return toret;
  }
}
