//Provides a panel class
abstract class RectSpriteBase extends Sprite {
  int border; //The border width of the button or 0 for no width
  //Colors:
  color borderColor = color(0);
  //Constructors
  RectSpriteBase(float x, float y, float width, float height, int border) {
    position = new PVector(x, y);
    size = new PSize(width, height);
    this.border = border;
  }
  //Render object
  void render() {
    setupBorder();
  }
  //Setup border
  protected void setupBorder() {
    if (border < 1) myself.noStroke();
    else
    {
      myself.stroke(borderColor);
      myself.strokeWeight(border);
    }
  }
  //Check intersection
  boolean isIntersecting(PVector point) {
    PVector rpoint = rrotatePoint(point);
    PVector[] pts = getRectPoints();
    return (rpoint.x >= pts[0].x && rpoint.x <= pts[2].x && rpoint.y >= pts[0].y && rpoint.y <= pts[1].y);
  }
  //Get rectangle points
  protected PVector[] getRectPoints() {
    return new PVector[] {new PVector(position.x - (size.width / 2.0), position.y - (size.height / 2.0)), new PVector(position.x - (size.width / 2.0), position.y + (size.height / 2.0)), new PVector(position.x + (size.width / 2.0), position.y + (size.height / 2.0)), new PVector(position.x + (size.width / 2.0), position.y - (size.height / 2.0))};
  }
  //Get rotated rectangle points
  protected PVector[] getRectPointsRotated() {
    PVector[] pts = getRectPoints();
    return new PVector[] {rotatePoint(pts[0]), rotatePoint(pts[1]), rotatePoint(pts[2]), rotatePoint(pts[3])};
  }
}
