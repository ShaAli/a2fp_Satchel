final int BOARD_SIZE = 15;
final int TILE_SIZE = 60;
final int BLOCK_SIZE = 70;
final int TILE_ALPHA = 120;

//debug governs SHOW_ functions, i.e. if debug is false and the SHOW_ vars are true, the info won't be printed
//debug being true also means other debug info
final boolean DEBUG = true;
final boolean SHOW_COORDS = true;

float rotX = 0.6;
float rotY = 0;
float scale = 0.5;
int oldMouseX = mouseX;
int oldMouseY = mouseY;
Player player;

public void settings() {
  size(BOARD_SIZE * TILE_SIZE + 50, BOARD_SIZE * TILE_SIZE + 50, P3D);
}

public void setup() {
  hint(DISABLE_OPTIMIZED_STROKE);
  strokeWeight(3);
  PFont font = createFont("ACaslonPro-Bold-20.vlw", 20);
  textFont(font);
  smooth();
  background(180);
  player = new Player(generateBoard());
}

public void draw() {
  Board board = player.getBoard();
  if (mousePressed) {
    if (oldMouseX != -1) {
      rotY -= (mouseX - oldMouseX) / 180.0;
      rotX += (mouseY - oldMouseY) / 180.0;
    }
    oldMouseX = mouseX;
    oldMouseY = mouseY;
  } else {
    oldMouseX = -1;
  }
  background(180);
  fill(0);
  text("Seed: " + board.getSeed(), 50, 50);
  text("Level: " + player.getLevel(), 50, 100);
  if(DEBUG) {
    text("Alive: " + board.tilesAlive(), 50, 150);
    text("Player pos: " + player.getCurrent().getX() + ", " + player.getCurrent().getY(), 50, 200);
    text("End pos: " + board.endTile.getX() + ", " + board.endTile.getY(), 50, 250);
    text("Player == end check: " + board.endTile.equals(player.getCurrent()), 50, 300); 
  }
  scale(scale);
  translate(BOARD_SIZE * TILE_SIZE, BOARD_SIZE * TILE_SIZE); //to rotate around center
  rotateX(rotX);
  rotateY(rotY);
  translate(-BOARD_SIZE * TILE_SIZE, -BOARD_SIZE * TILE_SIZE); // undo centering
  translate(BOARD_SIZE * TILE_SIZE / 4, BOARD_SIZE * TILE_SIZE / 2 - TILE_SIZE * 6, -TILE_SIZE * 3); // for better board centering, might improve on this later with pan

  board.draw();
  player.draw();
} 

public void keyPressed() {
  char k = Character.toLowerCase(key);
  if (k == '-') scale *= 0.9;
  if (k == '+') scale /= 0.9;
  if (k == ' ') {
    player.newBoard();
  }
  if (k == 'd') player.move(1, 0);
  if (k == 'a') player.move(-1, 0);
  if (k == 's') player.move(0, 1);
  if (k == 'w') player.move(0, -1);
}