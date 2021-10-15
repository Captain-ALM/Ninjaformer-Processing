//Provides a tile registration class which can create tiles
class TileReg {
  int imageX;
  int imageY;
  PImage tileImage;
  boolean fluid; //Can move inside tile
  boolean overlay; //Should render ontop if fluid
  ModifierReg tick; //The tick modifier
  ModifierReg up; //The up modifier
  ModifierReg down; //The down modifier
  ModifierReg left; //The left modifier
  ModifierReg right; //The right modifier
  //Constructor
  TileReg(JSONObject jIn) {
    imageX = jIn.getInt("imageX");
    imageY = jIn.getInt("imageY");
    fluid = jIn.getBoolean("isFluid");
    overlay = jIn.getBoolean("isOverlay");
    tick = new ModifierReg(jIn.getJSONObject("onTick"));
    up = new ModifierReg(jIn.getJSONObject("onUp"));
    down = new ModifierReg(jIn.getJSONObject("onDown"));
    left = new ModifierReg(jIn.getJSONObject("onLeft"));
    right = new ModifierReg(jIn.getJSONObject("onRight"));
  }
  void loadSpriteImage(SpriteSheet sIn) {
    tileImage = sIn.getSpriteImage(imageX, imageY, 5, 5);
  }
  Tile createTile(float x, float y) {
    return new Tile(x, y, false, tileImage);
  }
}
