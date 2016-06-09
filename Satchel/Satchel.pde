final int BOARD_SIZE = 15;
final int TILE_SIZE = 60;
final int BLOCK_SIZE = 70;
final int TILE_ALPHA = 120;
boolean ALIVE = true;
boolean COMPLETE = false;
final boolean SHOW_COORDS = true;
int level = 1;

Board layout; // stores untouched copy of board
Board board;
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
  strokeWeight(2);
  PFont font = createFont("ACaslonPro-Bold-20.vlw", 20);
  textFont(font);
  smooth();
  background(180);
  generateBoard();
}

public void draw() {

  if (ALIVE) {
    if(mousePressed) {
      if(oldMouseX != -1) {
        rotY -= (mouseX - oldMouseX) / 180.0;
        rotX += (mouseY - oldMouseY) / 180.0;
      }
      oldMouseX = mouseX;
      oldMouseY = mouseY;
    }
    else {
      oldMouseX = -1;
    }
    background(180);
    fill(0);
    text("Seed: " + board.getSeed(), 50, 50);
    text("Level: " + level, 50, 100);

    
    scale(scale);
    translate(BOARD_SIZE * TILE_SIZE, BOARD_SIZE * TILE_SIZE); //to rotate around center
    rotateX(rotX);
    rotateY(rotY);
    translate(-BOARD_SIZE * TILE_SIZE, -BOARD_SIZE * TILE_SIZE); // undo centering
    translate(BOARD_SIZE * TILE_SIZE / 4, BOARD_SIZE * TILE_SIZE / 2 - TILE_SIZE * 6, -TILE_SIZE * 3); // for better board centering, might improve on this later with pan
    
    board.draw();
    player.draw();
    } 
    else {
      if (COMPLETE) {
        generateBoard();
        player.undie();
        level++;
        COMPLETE = false;
      }
      else {
        noLoop();
      background(255);
      fill(0);
        resetBoard();
        player.undie();
      }
    }
    
}

public void generateBoard() {
  board = new Board();
  board.createBoard();
  player = new Player(board);
  layout = new Board(board);
}

public void resetBoard() {
  board = new Board(layout);
  player = new Player(board);
}

public void keyPressed() {
  char k = Character.toLowerCase(key);
  if(k == '-') scale *= 0.9;
  if(k == '+') scale /= 0.9;
  if(k == ' ') {
    generateBoard();
  }
  if (k == 'd') player.move(1,0);
  if (k == 'a') player.move(-1,0);
  if (k == 's') player.move(0,1);
    if (k == 'w') player.move(0,-1);
    
}