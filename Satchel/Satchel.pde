<<<<<<< HEAD
final int BOARD_SIZE = 15;
final int TILE_SIZE = 70;
=======
final int BOARD_SIZE = 30;
final int TILE_SIZE = 30;
final int BLOCK_SIZE = 70;
final boolean SHOW_COORDS = false;
>>>>>>> 3de85f79da5dd3faf1d9e81010cb76a4a57df62b

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