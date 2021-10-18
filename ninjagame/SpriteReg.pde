//Provides a sprite registration class which can create sprites
class SpriteReg {
  int imageX;
  int imageY;
  PImage spriteImage;
  SpriteType sType;
  //Constructor
  SpriteReg(JSONObject jIn) {
    imageX = jIn.getInt("imageX");
    imageY = jIn.getInt("imageY");
    var s = jIn.getString("type");
    if (s.toLowerCase().equals("playertop")) {
      sType = SpriteType.PlayerTop;
    } else if (s.toLowerCase().equals("playertop")) {
      sType = SpriteType.PlayerBottom;
    } else {
      sType = SpriteType.End;
    }
  }
  void loadSpriteImage(SpriteSheet sIn) {
    spriteImage = sIn.getSpriteImage(imageX, imageY, 5, 5);
  }
  ImageSprite createSprite(float x, float y) {
    return new ImageSprite(x, y, spriteImage.width, spriteImage.height, spriteImage);
  }
}

enum SpriteType {
  PlayerTop,
    PlayerBottom,
    End
}
