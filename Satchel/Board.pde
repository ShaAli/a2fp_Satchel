class Board {
  private Tile[][] board;

  public Board() { // makes an empty board
    board = new Tile[BOARD_SIZE][BOARD_SIZE];
    for (int r = 0; r < BOARD_SIZE; r++) {
      for (int c = 0; c < BOARD_SIZE; c++) {
        board[r][c] = new Tile();
      }
    }
  }


  public void createBoard() {
    int x = (int)(Math.random() * BOARD_SIZE);
    int y = (int)(Math.random() * BOARD_SIZE);
    board[x][y] = new Tile(Tile.START);
    int tilesmade = 1;
    while (tilesmade < (BOARD_SIZE * BOARD_SIZE / 2)) { // for now, fill half the board 
      int random = (int)(Math.random()*4);
      try {
        if ((random == 0) && !board[x+1][y].isActivated()) {
          board[x+1][y].setActive(true);
          x++;
        }
        if ((random == 1) && !board[x][y+1].isActivated()) {
          board[x][y+1].setActive(true);
          y++;
        }
        if ((random == 2) && !board[x-1][y].isActivated()) {
          board[x-1][y].setActive(true);
          x--;
        }
        if ((random == 3) && !board[x][y-1].isActivated()) {
          board[x][y-1].setActive(true);
          y--;
        }
      }
      catch (IndexOutOfBoundsException e) { // occurs if we go outside board, just stops
      }
      tilesmade++;
    }
    //at the end, x,y will be the last tile, make it an end tile
    board[x][y] = new Tile(Tile.END);
  }

  public void draw() {
    rotateX(0.6);
    translate(BOARD_SIZE * TILE_SIZE / 4, BOARD_SIZE * TILE_SIZE / 2 - TILE_SIZE * 6, -TILE_SIZE * 3);
    scale(0.5);
    for(int x = 0; x < BOARD_SIZE; x++) {
      for(int y = 0; y < BOARD_SIZE; y++) {
        board[x][y].draw(x,y);
      }
    }
  }
}