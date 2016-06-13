final int BOARD_SIZE = 7;
final int TILE_SIZE = 120;
final int TILE_ALPHA = 90;

//debug governs SHOW_ functions, i.e. if debug is false and the SHOW_ vars are true, the info won't be printed
//debug being true also means other debug info
final boolean DEBUG = false;
final boolean SHOW_COORDS = true;

PFont font;
float rotX = 0;
float rotY = 0;
float scale = 0.5;
int oldMouseX = mouseX;
int oldMouseY = mouseY;
Player player;

public void settings() {
  size(BOARD_SIZE * TILE_SIZE + 200, BOARD_SIZE * TILE_SIZE + 50, P3D);
}

public void setup() {
  hint(DISABLE_OPTIMIZED_STROKE);
  strokeWeight(TILE_SIZE / 12);
  font = createFont("ACaslonPro-Bold-20.vlw", 20);
  textFont(font);
  smooth();
  background(180);
  player = new Player();
  player.newBoard();
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
  text("Score: " + player.getScore(), 50, 150);
  
  if(DEBUG) {
    //text("Alive: " + board.tilesAlive(), 50, 150);
    text("Player pos: " + player.getCurrent().getX() + ", " + player.getCurrent().getY() + ", " + player.getCurrent().getZ(), 50, 200);
    text("Start pos: " + board.startTile.getX() + ", " + board.startTile.getY() + ", " + board.startTile.getZ(), 50, 250);
    text("End pos: " + board.endTile.getX() + ", " + board.endTile.getY() + ", " + board.endTile.getZ(), 50, 300);
    //text("Player == end check: " + board.endTile.equals(player.getCurrent()), 50, 350); 
  }
  else {
    noStroke();
    fill(255, 0, 0);
    rect(50, 180, 30, 30);
    text("X", 90, 200);
    fill(0, 255, 0);
    rect(50, 230, 30, 30);
    text("Y", 90, 250);
    fill(0, 0, 255);
    rect(50, 280, 30, 30);
    text("Z", 90, 300);
  }
  scale(scale);
  translate(BOARD_SIZE * TILE_SIZE / 2 / scale, BOARD_SIZE * TILE_SIZE / 2 / scale); //to rotate around center
  rotateX(rotX);
  rotateY(rotY);
  translate(-BOARD_SIZE * TILE_SIZE / 2 / scale, -BOARD_SIZE * TILE_SIZE / 2 / scale); // undo centering
  translate(BOARD_SIZE * TILE_SIZE / 4 / scale, BOARD_SIZE * TILE_SIZE / 4 / scale, -TILE_SIZE * 3); // for better board centering
  //lighting
  ambientLight(150, 150, 150);
  pointLight(140, 140, 200, -TILE_SIZE / 2, -TILE_SIZE / 2, -TILE_SIZE / 2); // light from just below origin
  
  board.draw();
  player.draw();
} 

public void rotateAroundPoint(float x, float y, float z, float rx, float ry, float rz) { // after this, pop the matrix
  pushMatrix();
  translate(x,y,z);
  rotateX(rx);
  rotateY(ry);
  rotateZ(rz);
}
  

public void keyPressed() {
  char k = Character.toLowerCase(key);
  if (k == '-') scale *= 0.9;
  if (k == '+') scale /= 0.9;
  if (k == ' ') {
    player.newBoard();
  }
  if (k == 'd') player.move(1,0,0);
  if (k == 'a') player.move(-1,0,0);
  if (k == 's') player.move(0,1,0);
  if (k == 'w') player.move(0,-1,0);
  if (k == 'q') player.move(0,0,1);
  if (k == 'e') player.move(0,0,-1); 
}