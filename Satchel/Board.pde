import java.util.Random;
class Board {
  private Tile[][] board;
  private long seed;
  private Random RNG;
  
  public Board() { // makes an empty board 
    this((long) ((Math.random() * Long.MAX_VALUE - Long.MAX_VALUE / 2) * 2));
    //seed can be almost any long value: if random gens 0, we get seed is -2^63 + 2, which is long min + 2
    //if random gens just below 1, we get seed is (2^63-2 - (2^62 - 1)) * 2 which is (2^62 - 1) * 2 which is long max - 1
    //so seed can be all but 4 long values
  }

  public Board(long s) { // seeds RNG
    board = new Tile[BOARD_SIZE][BOARD_SIZE];
    for (int r = 0; r < BOARD_SIZE; r++) {
      for (int c = 0; c < BOARD_SIZE; c++) {
        board[r][c] = new Tile();
      }
    }
    seed = s;
    RNG = new Random(seed);
  }
  public void createBoard() {
    int x = (int)(RNG.nextFloat() * BOARD_SIZE);
    int y = (int)(RNG.nextFloat() * BOARD_SIZE);
    board[x][y] = new Tile(Tile.START);
    int tilesmade = 1;
    while (tilesmade < (BOARD_SIZE * BOARD_SIZE / 2)) { // for now, fill half the board 
      int random = (int)(RNG.nextFloat()*4);
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
    fill(0);
    text("Seed: " + seed, 50, 50);
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