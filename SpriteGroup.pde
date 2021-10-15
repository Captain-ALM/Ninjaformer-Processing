//Provides the ability to group sprites
final class SpriteGroup extends Sprite implements IInteractable {
  ArrayList<Sprite> sprites = new ArrayList<Sprite>();
  boolean freeze = false; //Freeze rendering and update executing
  private boolean updating = false; //If currently updating
  private SpriteZSorter zs = new SpriteZSorter(); //Stores the z sorter

  //Constructors:
  SpriteGroup() {
    this(0, 0);
  }
  SpriteGroup(float x, float y) {
    position = new PVector(x, y);
    size = new PSize(width, height);
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
    for (Sprite c : sprites) {
      var d = (Sprite)c.clone();
      offset(d, true);
      d.render();
    }
    updating = false;
  }

  //Check intersection for all objects until one is intersected or fully iterated over the list
  boolean isIntersecting(PVector point) {
    var toret = false;
    updateWaiter();
    for (Sprite c : sprites) {
      var d = (Sprite)c.clone();
      offset(d, true);
      if (d.isIntersecting(point)) {
        toret = true;
        break;
      }
    }
    updating = false;
    return toret;
  }

  void update() {
    freezeWaiter();
    sprites.sort(zs);
    freeze = false;
    updateWaiter();
    for (Sprite c : sprites) {
      offset(c, true);
      if (c instanceof IInteractable) {
        ((IInteractable)c).update();
      }
      offset(c, false);
    }
    updating = false;
  }

  //Enforce / Unenforce the offset on all sub-objects recursively
  void offsetEnforcement(boolean enforce) {
    if (enforce) {
      while (updating || freeze) {
        delay(125);
      }
      for (Sprite c : sprites) {
        offset(c, true);
        if (c instanceof SpriteGroup) {
          ((SpriteGroup)c).offsetEnforcement(enforce);
        }
      }
      updating = true;
      freeze = true;
    } else {
      while ((!updating) && (!freeze)) {
        delay(125);
      }
      for (Sprite c : sprites) {
        offset(c, false);
        if (c instanceof SpriteGroup) {
          ((SpriteGroup)c).offsetEnforcement(enforce);
        }
      }
      updating = false;
      freeze = false;
    }
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
  //Offset the object to and from its position due to the group
  private void offset(Sprite c, boolean add) {
    if (add) {
      var pos = rotatePoint(new PVector(c.position.x + this.position.x, c.position.y + this.position.y));
      c.position.x = pos.x;
      c.position.y = pos.y;
      c.rotate(angle);
    } else {
      var pos = rrotatePoint(new PVector(c.position.x, c.position.y));
      c.position.x = pos.x - this.position.x;
      c.position.y = pos.y - this.position.y;
      c.rotate(-angle);
    }
  }
  //Clone the object
  Object clone() {
    var toret =  new SpriteGroup(position.x, position.y);
    toret.angle = angle;
    freezeWaiter();
    toret.sprites = new ArrayList<Sprite>(sprites);
    freeze = false;
    return toret;
  }
}
