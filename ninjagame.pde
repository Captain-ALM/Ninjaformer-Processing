PApplet myself;  //Hold an instance of the executing program
SpriteWorld world; //Hold the world being used
Keyboard kb; //Hold the keyboard being used
Menus currentMenu; //Holds the current menu
color textC; //Holds the text colour
Button exiter; //Holds the button for exiting the program
ButtonImage backer; //Holds the button for going back in the program
PImage backimg; //Holds the image for the backer button
Panel upperPanel; //Holds the upper display panel
int saveSlotNumber; //Holds the save slot number
boolean playingMode = false; //Holds if the program is not in menu mode
boolean editingMode = false; //Holds if the level is in editing mode
TileReg[] regTiles; //Holds the loaded registered tiles
SpriteReg[] regSprites; //Holds the loaded registered sprites
SpriteSheet tileSheet; //Holds the tile sprite sheet
SpriteSheet playerSheet; //Holds the player sprite sheet
SpriteGroup playerg; //Holds the player sprite group
ImageSprite[] playerSprites; //Holds the players image sprites
SpriteSheet endSheet; //Holds the finish portal sprite sheet
ImageSprite[] endSprites; //Holds the end sprites
ArrayList<LevelData> llevel; //Holds the loaded level data
SpriteGroup grid; //Holds the sprite group for the grid
Tile[][] gridSprites; //Holds the grid sprites
SpriteGroup levelg; //Holds the sprites for the level
PVector scroll; //Holds the scroll status
int selectedIndex = 0;
boolean tileSelected = false;
int vTileIndex = 0;
int vSpriteIndex = 0;

//Core Event Handlers

void setup() {
  fullScreen();
  surface.setTitle("NinjaFormer");
  frameRate(30);
  //Initalize core variables
  myself = this;
  world = new SpriteWorld(displayWidth, displayHeight, color(64, 64, 192));
  kb = new Keyboard();
  textC = color(255, 32, 64);
  exiter = new Button(displayWidth - 75, 75, 150, 150, 4, "X");
  exiter.activeColor = color(255, 0, 128);
  exiter.inactiveColor = color(255, 128, 128);
  world.add(exiter);
  backimg = loadImage("back.png");
  backer = new ButtonImage(75, 75, 150, 150, 4, backimg, backimg);
  backer.activeColor = color(0, 0, 192);
  backer.inactiveColor = color(0, 128, 192);
  world.add(backer);
  upperPanel = new Panel(displayWidth / 2, 75, displayWidth, 150, 2);
  upperPanel.panelColor = color(64, 128, 64);
  upperPanel.position.z = -1;
  world.add(upperPanel);
  world.update();

  //Initalize Menus
  generateMenus();
  currentMenu = Menus.None;
  saveSlotNumber = 0;
}

void draw() {
  if (playingMode) {
    if (currentMenu != Menus.Game) switchMenu(Menus.Game); //Switch to game 'menu' if not on game 'menu'
  } else {
    if (currentMenu == Menus.None) switchMenu(Menus.Main); //Switch to main menu if on no menu
  }
  menuProcessor();
  if (buttonPressed(exiter)) exit();
  if (buttonPressed(backer)) goBack();
  world.render();
}

void mousePressed() {
  world.update();
}

void keyPressed() {
  kb.handleKeyPress(keyCode);
}

void keyReleased() {
  kb.handleKeyRelease(keyCode);
}

//Event Handlers
void goBack() {
  if (currentMenu == Menus.Game) {
    playingMode = false;
    switchMenu(Menus.Main);
  }
}

//Menu management

void generateMenus() {
  generateMainMenu();
  generateGameMenu();
}

void menuProcessor() {
  processorMainMenu();
  processorGameMenu();
}

//Main Menu
SpriteGroup menuMain; //Hold the group of sprites representing the main menu
SpriteGroup menuMainPanelGroup;
Label menuMainTitle;
Panel menuMainPanel;
Label menuMainPanelLabel;
Button menuMainPanelSlotAdd;
Button menuMainPanelSlotMinus;
Label menuMainPanelSlot;
StateBox menuMainPanelStateEditor;
Label menuMainPanelLabelEditor;
Button menuMainStart;

void generateMainMenu() {
  menuMain = new SpriteGroup();
  menuMainPanelGroup = new SpriteGroup(world.size.width / 2, world.size.height / 2);

  menuMainTitle = new Label(world.size.width / 2, 100, "Ninjaformer", 72);
  menuMainTitle.textColor = textC;
  menuMain.add(menuMainTitle);

  menuMainPanel = new Panel(0, 0, world.size.width / 2, world.size.height / 2, 2);
  menuMainPanel.panelColor = color(64, 64, 224);
  menuMainPanelGroup.add(menuMainPanel);
  menuMainPanelLabel = new Label(0, -(world.size.height / 4) + 50, (world.size.width / 4), 48, "Level Selector", 48);
  menuMainPanelGroup.add(menuMainPanelLabel);
  menuMainPanelSlotAdd = new Button(-(world.size.width / 4) + 50, 0, 50, 50, 1, "+");
  menuMainPanelGroup.add(menuMainPanelSlotAdd);
  menuMainPanelSlotMinus = new Button(world.size.width / 4 - 50, 0, 50, 50, 1, "-");
  menuMainPanelGroup.add( menuMainPanelSlotMinus);
  menuMainPanelSlot = new Label(0, 20, (world.size.width / 8), 50, "0", 50);
  menuMainPanelGroup.add(menuMainPanelSlot);
  menuMainPanelStateEditor = new StateBox(-(world.size.width / 4) + 50, (world.size.height / 4) - 50, 50, 50, 4);
  menuMainPanelGroup.add(menuMainPanelStateEditor);
  menuMainPanelLabelEditor = new Label(0, (world.size.height / 4) - 30, (world.size.width / 8), 50, "Level Editor Mode", 50);
  menuMainPanelGroup.add(menuMainPanelLabelEditor);
  menuMain.add(menuMainPanelGroup);

  menuMainStart = new Button(world.size.width / 2, 4 * (world.size.height / 5), world.size.width / 2, 50, 1, "Start Level");
  menuMain.add(menuMainStart);
  menuMain.update();
}

void processorMainMenu() {
  if (buttonPressed(menuMainPanelSlotAdd)) if (saveSlotNumber < 31) saveSlotNumber += 1;
  if (buttonPressed(menuMainPanelSlotMinus)) if (saveSlotNumber > 0) saveSlotNumber -= 1;
  menuMainPanelSlot.caption = Integer.toString(saveSlotNumber);
  editingMode = menuMainPanelStateEditor.active;
  if (buttonPressed(menuMainStart)) playingMode = true;
}

//'Game' menu
SpriteGroup menuGame = new SpriteGroup(); //Hold the group of sprites representing the game gui
Label menuGameTitle;
//Action Button for save / pause / play
ButtonImage menuGameSPP;
PImage pauseimg;
PImage playimg;
PImage saveimg;
//Status Labels (Playing Mode)
SpriteGroup playingGroup;
//Label labelPrimaryWeapon;
//Label labelSecondaryWeapon;
Label labelHealth;
//Editor Interface
SpriteGroup editingGroup;
Label labelSpriteRow;
Label labelTileRow;
Button leftSpriteRow;
Button rightSpriteRow;
Button leftTileRow;
Button rightTileRow;
ButtonImage[] spriteRow;
ButtonImage[] tileRow;

void generateGameMenu() {
  menuGameTitle = new Label(world.size.width / 2, 31, "PLACEHOLDER", 24);
  menuGameTitle.textColor = textC;
  menuGame.add(menuGameTitle);

  pauseimg = loadImage("pause.png");
  playimg = loadImage("play.png");
  saveimg = loadImage("save.png");
  menuGameSPP = new ButtonImage(250, 75, 100, 100, 2, playimg, pauseimg);
  menuGame.add(menuGameSPP);

  playingGroup = new SpriteGroup();
  //labelPrimaryWeapon = new Label(world.size.width / 3, 62, "PRIMARY WEAPON", 24);
  //labelPrimaryWeapon.textColor = textC;
  //playingGroup.add(labelPrimaryWeapon);
  //labelSecondaryWeapon = new Label(world.size.width / 3, 93, "SECONDARY WEAPON", 24);
  //labelSecondaryWeapon.textColor = textC;
  //playingGroup.add(labelSecondaryWeapon);
  labelHealth = new Label(2 * (world.size.width / 3), 78, "PLAYER HEALTH", 24);
  labelHealth.textColor = textC;
  playingGroup.add(labelHealth);

  editingGroup = new SpriteGroup();
  labelSpriteRow = new Label(2 * (world.size.width / 9), 70, "Sprite Row:", 24);
  labelSpriteRow.textColor = textC;
  editingGroup.add(labelSpriteRow);
  labelTileRow = new Label(2 * (world.size.width / 9), 123, "Tile Row:", 24);
  labelTileRow.textColor = textC;
  editingGroup.add(labelTileRow);
  leftSpriteRow = new Button((2 * (world.size.width / 5)) - 25, 65, 50, 50, 2, "<");
  editingGroup.add(leftSpriteRow);
  spriteRow = new ButtonImage[9];
  for (int i = 0; i<spriteRow.length; i++) {
    spriteRow[i] = new ButtonImage((2 * (world.size.width / 5)) + 25 + (i * 50), 65, 50, 50, 2, null, null);
    editingGroup.add(spriteRow[i]);
  }
  rightSpriteRow = new Button((2 * (world.size.width / 5)) + 475, 65, 50, 50, 2, ">");
  editingGroup.add(rightSpriteRow);
  leftTileRow = new Button((2 * (world.size.width / 5)) - 25, 120, 50, 50, 2, "<");
  editingGroup.add(leftTileRow);
  tileRow = new ButtonImage[9];
  for (int i = 0; i<tileRow.length; i++) {
    tileRow[i] = new ButtonImage((2 * (world.size.width / 5)) + 25 + (i * 50), 120, 50, 50, 2, null, null);
    editingGroup.add(tileRow[i]);
  }
  rightTileRow = new Button((2 * (world.size.width / 5)) + 475, 120, 50, 50, 2, ">");
  editingGroup.add(rightTileRow);
  menuGame.update();
}

void processorGameMenu() {
  if (editingMode) {
    menuGameTitle.caption = "Level Editor:";
    menuGameSPP.activeImage = saveimg;
    menuGameSPP.inactiveImage = saveimg;
    menuGameSPP.activeColor = color(64, 0, 128);
    menuGame.remove(playingGroup);
    menuGame.add(editingGroup);
    if (buttonPressed(menuGameSPP));
  } else {
    menuGameTitle.caption = "Player Statistics:";
    menuGameSPP.activeImage = playimg;
    menuGameSPP.inactiveImage = pauseimg;
    menuGameSPP.activeColor = menuGameSPP.inactiveColor;
    menuGame.remove(editingGroup);
    menuGame.add(playingGroup);
  }
}

void switchMenu(Menus m) {
  menuGameSPP.active = false; //Make sure this button if off
  if (currentMenu == Menus.Main) world.remove(menuMain);
  if (currentMenu == Menus.Game) world.remove(menuGame);
  currentMenu = m;
  if (currentMenu == Menus.Main) world.add(menuMain);
  if (currentMenu == Menus.Game) world.add(menuGame);
}

//Utility Functions

//Checks if a button is pressed and resets it and returns true if the mouse is not down and over it
boolean buttonPressed(Button buttonIn) {
  if (buttonIn.active && ! mousePressed) {
    buttonIn.active = false;
    var toret = false;
    menuMain.offsetEnforcement(true);
    toret = buttonIn.isIntersecting(new PVector(mouseX, mouseY));
    menuMain.offsetEnforcement(false);
    return toret;
  } else return false;
}

//Rotates a point
//Adapted from the soloution found at:
//https://stackoverflow.com/questions/2259476/rotating-a-point-about-another-point-2d
//Answer from Ziezi
PVector rotatePoint(PVector p, float angle, PVector centre) {
  if (angle == 0) return p;
  return new PVector((cos(angle) * (p.x - centre.x) - sin(angle) * (p.y - centre.y) + centre.x), (sin(angle) * (p.x - centre.x) + cos(angle) * (p.y - centre.y) + centre.y));
}

void loadLevel(int id) {
  var ljson = loadJSONArray(id + ".level.json");
  if (ljson == null) ljson = new JSONArray();
  llevel.clear();
  for (int i = 0; i<ljson.size(); i++) {
    llevel.add(new LevelData(ljson.getJSONObject(i)));
  }
}

void saveLevel(int id) {
  var tosave = new JSONArray();
  for (LevelData c : llevel) {
    tosave.append(c.getJSON());
  }
  saveJSONArray(tosave, id + ".level.json");
}

void loadTiles() {
  tileSheet = new SpriteSheet("tiles.png");
  var ljson = loadJSONArray("tiles.json");
  regTiles = new TileReg[ljson.size()];
  for (int i = 0; i<ljson.size(); i++) {
    regTiles[i] = new TileReg(ljson.getJSONObject(i));
    regTiles[i].loadSpriteImage(tileSheet);
  }
}

void loadSprites() {
  playerSheet = new SpriteSheet("player.png");
  endSheet = new SpriteSheet("ending.png");
  var ljson = loadJSONArray("sprites.json");
  regSprites = new SpriteReg[ljson.size()];
  for (int i = 0; i<ljson.size(); i++) {
    regSprites[i] = new SpriteReg(ljson.getJSONObject(i));
    regSprites[i].loadSpriteImage((regSprites[i].sType == SpriteType.PlayerTop || regSprites[i].sType == SpriteType.PlayerBottom) ? playerSheet :  endSheet);
  }
}

void generateGrid() {
  grid = new SpriteGroup(world.size.width / 2, (world.size.height / 2) + 150);
  var maxx = floor(world.size.width / 5.0);
  var maxy = floor(world.size.height / 5.0);
  gridSprites = new Tile[maxx][maxy];
  for (int i = 0; i<maxx; i++) {
    for (int j = 0; j<maxy; j++) {
      gridSprites[i][j] = new Tile((i * 5) + 2.5, (j * 5) + 2.5, true, null);
      gridSprites[i][j].position.z = 1000;
      grid.add(gridSprites[i][j]);
    }
  }
}

void updateEditorPanel() {
  int z = vSpriteIndex;
  for (int i = 0; i<spriteRow.length; i++) {
    spriteRow[i].activeImage = (z < regSprites.length) ? regSprites[z].spriteImage : null;
    spriteRow[i].inactiveImage = (z < regSprites.length) ? regSprites[z].spriteImage : null;
    spriteRow[i].active = false;
    z += 1;
  }
  z = vTileIndex;
  for (int i = 0; i<tileRow.length; i++) {
    tileRow[i].activeImage = (z < regTiles.length) ? regTiles[z].tileImage : null;
    tileRow[i].inactiveImage = (z < regTiles.length) ? regTiles[z].tileImage : null;
    tileRow[i].active = false;
    z += 1;
  }
  if (tileSelected) {
    tileRow[selectedIndex].active = true;
  } else {
    spriteRow[selectedIndex].active = true;
  }
}

//Menu enum
enum Menus {
  None,
    Main,
    Game
}
