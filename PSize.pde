//Provides a PSize class
final class PSize {
  float width;
  float height;
  float depth;
  
  PSize(float width, float height) {
    this.width =  width;
    this.height = height;
  }
  
  PSize(float width, float height, float depth) {
    this(width, height);
    this.depth = depth;
  }
}
