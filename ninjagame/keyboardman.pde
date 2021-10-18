//Provides a keyboard state holder class
final class Keyboard {
  private HashMap<Integer,Boolean> hm = new HashMap<Integer,Boolean>(); //Stores the keyboard state
  
  boolean getKeyPressed(char keyIn) {
    return hm.getOrDefault((int)keyIn, false);
  }
  boolean getKeyPressed(int keyIn) {
    return hm.getOrDefault(keyIn, false);
  }
  void handleKeyPress(char keyIn) {
    hm.put((int)keyIn, true);
  }
  void handleKeyPress(int keyIn) {
    hm.put(keyIn, true);
  }
  void handleKeyRelease(char keyIn) {
    hm.put((int)keyIn, false);
  }
  void handleKeyRelease(int keyIn) {
    hm.put(keyIn, false);
  }
  void resetKeys() {
    hm.clear();
  }
}
