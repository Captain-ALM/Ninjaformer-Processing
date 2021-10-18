//Provides an image sprite
class ImageSprite extends RectSpriteBase {
  PImage sImage;
  //Constructors
  ImageSprite(float x, float y, float width, float height, PImage sImage) {
    super(x, y, width, height, 0);
    this.sImage = sImage;
  }
  //Render object
  void render() {
    myself.fill(0, 0, 0, 255);
    PVector[] pts = getRectPointsRotated();
    myself.quad(pts[0].x, pts[0].y, pts[1].x, pts[1].y, pts[2].x, pts[2].y, pts[3].x, pts[3].y);
    if (sImage != null) {
      myself.imageMode(CENTER);
      myself.pushMatrix();
      myself.translate(position.x, position.y);
      myself.rotate(angle);
      myself.image(sImage, 0, 0, size.width, size.height);
      myself.popMatrix();
    }
  }
  //Clone the object
  Object clone() {
    var toret = new ImageSprite(position.x, position.y, size.width, size.height, sImage);
    toret.angle = angle;
    toret.borderColor = borderColor;
    return toret;
  }
}
