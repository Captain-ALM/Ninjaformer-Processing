//Provides a world for sprites to exist in, implementing the required features
final class SpriteWorld implements IRenderable, IInteractable {
  PSize size; //World size
  color backgroundColor; //World background color
  ArrayList<Sprite> sprites = new ArrayList<Sprite>();
  boolean freeze = false; //Freeze rendering and update executing
  private boolean updating = false; //If currently updating
  private SpriteZSorter zs = new SpriteZSorter(); //Stores the z sorter

  SpriteWorld(float width, float height, color backgroundColor) {
    size = new PSize(width, height);
    this.backgroundColor = backgroundColor;
  }

  void add(Sprite spriteIn) {
    freezeWaiter();
    if (! sprites.contains(spriteIn)) sprites.add(spriteIn);
    freeze = false;
  }

  void remove(Sprite spriteIn) {
    freezeWaiter();
    sprites.remove(spriteIn);
    freeze = false;
  }

  void clear() {
    freezeWaiter();
    sprites.clear();
    freeze = false;
  }

  void render() {
    updateWaiter();
    myself.background(backgroundColor);
    for (Sprite c : sprites) {
      c.render();
    }
    updating = false;
  }

  void update() {
    freezeWaiter();
    sprites.sort(zs);
    freeze = false;
    updateWaiter();
    for (Sprite c : sprites) {
      if (c instanceof IInteractable) {
        ((IInteractable)c).update();
      }
    }
    updating = false;
  }

  private void freezeWaiter() {
    freeze = true;
    while (updating) {
      delay(125);
    }
  }

  private void updateWaiter() {
    updating = true;
    while (freeze) {
      delay(125);
    }
  }
}
