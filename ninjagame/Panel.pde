//Provides a panel class
class Panel extends RectSpriteBase {
  //Colors:
  color panelColor = color(128);
  //Constructors
  Panel(float x, float y, float width, float height, int border) {
    super(x, y, width, height, border);
  }
  //Render object
  void render() {
    super.render();
    myself.fill(panelColor);
    PVector[] pts = getRectPointsRotated();
    myself.quad(pts[0].x, pts[0].y, pts[1].x, pts[1].y, pts[2].x, pts[2].y, pts[3].x, pts[3].y);
  }
  //Clone the object
  Object clone() {
    var toret = new Panel(position.x, position.y, size.width, size.height, border);
    toret.angle = angle;
    toret.borderColor = borderColor;
    toret.panelColor = panelColor;
    return toret;
  }
}
