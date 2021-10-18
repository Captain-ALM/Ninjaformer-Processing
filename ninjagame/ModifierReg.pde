class ModifierReg {
  int health;
  int x;
  int y;
  ModifierReg(JSONObject jIn) {
    health = jIn.getInt("health");
    x = jIn.getInt("x");
    y = jIn.getInt("y");
  }
  ModifierReg(int healthIn, int xIn, int yIn) {
    health = healthIn;
    x = xIn;
    y = yIn;
  }
  ModifierReg add(ModifierReg toAdd) {
    return new ModifierReg(health + toAdd.health, x + toAdd.x, y + toAdd.y);
  }
}
