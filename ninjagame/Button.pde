//Provides a clickable button class
class Button extends RectSpriteBase implements IInteractable {
  boolean active; //If the button is currently active
  //Colors:
  color activeColor = color(64, 0, 128);
  color inactiveColor = color(128);
  color textColor = color(0);
  String caption; //The button caption
  protected int textSize;
  //Constructors
  Button(float x, float y, float width, float height, int border) {
    super(x, y, width, height, border);
  }
  Button(float x, float y, float width, float height, int border, String caption) {
    this(x, y, width, height, border);
    this.caption = caption;
    textSize = floor(2.0 * (size.height / 3.0));
  }
  //Render object
  void render() {
    super.render();
    myself.fill((active) ? activeColor : inactiveColor);
    PVector[] pts = getRectPointsRotated();
    myself.quad(pts[0].x, pts[0].y, pts[1].x, pts[1].y, pts[2].x, pts[2].y, pts[3].x, pts[3].y);

    //Render the caption if their is one
    if (caption != null) {
      myself.textAlign(CENTER);
      myself.textSize(textSize);
      myself.pushMatrix();
      myself.translate(position.x, position.y);
      myself.rotate(angle);
      myself.fill(textColor);
      myself.text(caption, 0, (size.height / 7.0));
      myself.popMatrix();
    }
  }

  //Object update is requested
  void update() {
    if (mousePressed && isIntersecting(new PVector(mouseX, mouseY))) active = !active;
    updateTextSize();
  }

  //Update text size
  protected void updateTextSize() {
    textSize = floor(2 * (size.height / 3.0));
    if (caption != null) {
      myself.textSize(textSize);
      if (myself.textWidth(caption) > size.width) {
        while (myself.textWidth(caption) > size.width) {
          if (textSize < 2) break;
          textSize -= 1;
          myself.textSize(textSize);
        }
      }
    }
  }

  //Clone the object
  Object clone() {
    var toret = new Button(position.x, position.y, size.width, size.height, border, caption);
    toret.angle = angle;
    toret.borderColor = borderColor;
    toret.activeColor = activeColor;
    toret.inactiveColor = inactiveColor;
    toret.textColor = textColor;
    toret.textSize = textSize;
    toret.active = active;
    return toret;
  }
}
