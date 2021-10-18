//Provides a sprite sheet
class SpriteSheet {
  PImage sheet;

  SpriteSheet(String name) {
    sheet = loadImage(name);
  }
  //Gets the image of a sprite based on its position and size on the sheet
  PImage getSpriteImage(int x, int y, int w, int h) {
    return sheet.get(x, y, w, h);
  }
  //Gets an array of images of sprites based on a start position, a size and the number of sprites to take from the sheet going across
  PImage[] getSpriteImages(int x, int y, int w, int h, int c) {
    PImage[] toret = new PImage[c];
    for (int i = 0; i<c; i++) {
      toret[i] = sheet.get(x + (w * i), y, w, h);
    }
    return toret;
  }
}
