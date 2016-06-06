final int BOARD_SIZE = 30;
final int TILE_SIZE = 30;
final int BLOCK_SIZE = 70;
final boolean SHOW_COORDS = false;

Board board;

public void settings() {
  size(BOARD_SIZE * TILE_SIZE + 50, BOARD_SIZE * TILE_SIZE + 50, P3D);
}

public void setup() {
  PFont font = createFont("ACaslonPro-Bold-20.vlw", 20);
  textFont(font);
  smooth();
  background(180);
  board = new Board();
  board.createBoard();
  board.draw();
}

public void draw() {
}
  
public void mouseClicked() {
  background(180);
  board = new Board();
  board.createBoard();
  board.draw();
}