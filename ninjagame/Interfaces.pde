//Provides a rendering interface
interface IRenderable {
  void render(); //Renders the object
}
//Provides an interface for moving an object
interface IMoveable {
  void moveUp(float amount); //Moves the object up by an amount
  void moveDown(float amount); //Moves the object down by an amount
  void moveLeft(float amount); //Moves the object left by an amount
  void moveRight(float amount); //Moves the object right by an amount
}
//Provides an interface for rotating an object
interface IRotateable {
  void rotate(float angle); //Rotates the object by an amount
}
//Provides an interface to check for intersection
interface ICollideChecker {
  boolean isIntersecting(PVector point); //Checks if the specified point is within the object
}
//Provides an interface for interaction
interface IInteractable {
  void update(); //Object update is requested
}
