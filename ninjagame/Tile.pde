//Provides a tile sprite class with an image background
class Tile extends RectSpriteBase {
  PImage tileImage;
  //Constructor
  Tile(float x, float y, boolean hasBorder, PImage tileImg) {
    super(x, y, 5, 5, (hasBorder) ? 1 : 0);
    this.tileImage = tileImg;
  }
  //Render object
  void render() {
    myself.fill(0, 0, 0, 255);
    PVector[] pts = getRectPointsRotated();
    myself.quad(pts[0].x, pts[0].y, pts[1].x, pts[1].y, pts[2].x, pts[2].y, pts[3].x, pts[3].y);
    if (tileImage != null) {
      myself.imageMode(CENTER);
      myself.pushMatrix();
      myself.translate(position.x, position.y);
      myself.rotate(angle);
      myself.image(tileImage, 0, 0, size.width, size.height);
      myself.popMatrix();
    }
  }
  //Clone the object
  Object clone() {
    var toret = new Tile(position.x, position.y, border > 0, tileImage);
    toret.angle = angle;
    toret.borderColor = borderColor;
    return toret;
  }
}
