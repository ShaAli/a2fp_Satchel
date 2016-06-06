final int BOARD_SIZE = 15;
final int TILE_SIZE = 70;

Board board;
Player playah;
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
  playah = new Player(board);
  playah.draw();
}
  
public void mouseClicked() {
  background(180);
  board = new Board();
  board.createBoard();
  board.draw();
  playah = new Player(board);
  playah.draw();
}