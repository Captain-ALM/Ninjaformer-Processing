import java.util.*;

//Defines an abstract sprite class implementing the required features
abstract class Sprite implements IRenderable, IMoveable, IRotateable, ICollideChecker, Cloneable {
  PVector position; //Object position
  PSize size; //Object size
  float angle;

  abstract void render(); //Provides an overridable render function
  //Moves the object up by an amount
  void moveUp(float amount) {
    position = rotatePoint(new PVector(position.x, position.y - amount));
  }
  //Moves the object down by an amount
  void moveDown(float amount) {
    position = rotatePoint(new PVector(position.x, position.y + amount));
  }
  //Moves the object left by an amount
  void moveLeft(float amount) {
    position = rotatePoint(new PVector(position.x - amount, position.y));
  }
  //Moves the object right by an amount
  void moveRight(float amount) {
    position = rotatePoint(new PVector(position.x + amount, position.y));
  }
  //Rotates the object by an amount
  void rotate(float angle) {
    angle += this.angle;
    if (angle < -TAU) {
      angle %= -TAU;
      angle = TAU - angle;
    }
    if (angle > TAU) angle %= TAU;
    if (angle < 0) angle = TAU + angle;
    this.angle = angle;
  }
  abstract boolean isIntersecting(PVector point); //Checks if the specified point is within the object
  //Rotates a point about the centre of the sprite
  //Adapted from the soloution found at:
  //https://stackoverflow.com/questions/2259476/rotating-a-point-about-another-point-2d
  //Answer from Ziezi
  protected PVector rotatePoint(PVector p) {
    if (angle == 0) return p;
    return new PVector((cos(angle) * (p.x - position.x) - sin(angle) * (p.y - position.y) + position.x), (sin(angle) * (p.x - position.x) + cos(angle) * (p.y - position.y) + position.y));
  }
  protected PVector rrotatePoint(PVector p) {
    if (angle == 0) return p;
    return new PVector((cos(-angle) * (p.x - position.x) - sin(-angle) * (p.y - position.y) + position.x), (sin(-angle) * (p.x - position.x) + cos(-angle) * (p.y - position.y) + position.y));
  }
  abstract Object clone(); //Clones the object
}

//Sorts sprites in the Z order
class SpriteZSorter implements Comparator<Sprite> {
  //Used for sorting in ascending order of position depth
  public int compare(Sprite a, Sprite b)
  {
    return round(a.position.z - b.position.z);
  }
}
