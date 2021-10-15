//Provides a clickable button class with an image backgrounds instead
class ButtonImage extends Button {
  //Images:
  PImage activeImage;
  PImage inactiveImage;

  //Constructors
  ButtonImage(float x, float y, float width, float height, int border, PImage activeImage, PImage inactiveImage) {
    super(x, y, width, height, border);
    this.activeImage = activeImage;
    this.inactiveImage = inactiveImage;
  }
  ButtonImage(float x, float y, float width, float height, int border, String caption, PImage activeImage, PImage inactiveImage) {
    this(x, y, width, height, border, activeImage, inactiveImage);
    this.caption = caption;
    textSize = floor(2.0 * (size.height / 3.0));
  }
  //Render object
  void render() {
    myself.fill((active) ? activeColor : inactiveColor);
    PVector[] pts = getRectPointsRotated();
    myself.quad(pts[0].x, pts[0].y, pts[1].x, pts[1].y, pts[2].x, pts[2].y, pts[3].x, pts[3].y);
    
    if (active && activeImage != null) {
      myself.imageMode(CENTER);
      myself.pushMatrix();
      myself.translate(position.x, position.y);
      myself.rotate(angle);
      myself.image(activeImage, 0, 0, size.width, size.height);
      myself.popMatrix();
    } else if ((!active) && inactiveImage != null) {
      myself.imageMode(CENTER);
      myself.pushMatrix();
      myself.translate(position.x, position.y);
      myself.rotate(angle);
      myself.image(inactiveImage, 0, 0, size.width, size.height);
      myself.popMatrix();
    }
    
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
  
  //Clone the object
  Object clone() {
    var toret = new ButtonImage(position.x, position.y, size.width, size.height, border, caption, activeImage, inactiveImage);
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
