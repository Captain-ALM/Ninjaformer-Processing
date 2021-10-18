//Provides a label class
class Label extends Sprite implements IInteractable {
  color textColor = color(0);
  String caption;
  int textSize;
  protected boolean restricted;
  //Constructors
  Label(float x, float y, String caption, int textSize) {
    this.position = new PVector(x, y);
    this.size = new PSize(textSize * caption.length(), textSize);
    this.caption = caption;
    this.textSize = textSize;
    restricted = false;
  }
  Label(float x, float y, float width, float height, String caption, int textSize) {
    this.position = new PVector(x, y);
    this.size = new PSize(width, height);
    this.caption = caption;
    this.textSize = textSize;
    if (textSize > floor(2 * (size.height / 3.0))) textSize = floor(2 * (size.height / 3.0));
    restricted = true;
  }
  //Render object
  void render() {
    myself.textAlign(CENTER);
    myself.textSize(textSize);
    if(! restricted) this.size = new PSize(textWidth(caption), textSize);
    myself.pushMatrix();
    myself.translate(position.x, position.y);
    myself.rotate(angle);
    myself.fill(textColor);
    myself.text(caption, 0, 0);
    myself.popMatrix();
  }
  //Check intersection, not supported
  boolean isIntersecting(PVector point) {
    return false;
  }
  //Update object
  void update() {
    if(restricted) updateTextSize();
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
    var toret = (restricted) ? new Label(position.x, position.y, size.width, size.height, caption, textSize) :  new Label(position.x, position.y, caption, textSize);
    toret.angle = angle;
    toret.textColor = textColor;
    toret.textSize = textSize;
    return toret;
  }
}
