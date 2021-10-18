//Provides a level data store class
class LevelData {
  int x;
  int y;
  int id;
  boolean tile;
  LevelData(JSONObject jIn) {
    x = jIn.getInt("x");
    y = jIn.getInt("y");
    id = jIn.getInt("id");
    tile = jIn.getBoolean("isTile");
  }
  JSONObject getJSON() {
    var toret = new JSONObject();
    toret.setInt("x", x);
    toret.setInt("y", y);
    toret.setInt("id", id);
    toret.setBoolean("isTile", tile);
    return toret;
  }
}
