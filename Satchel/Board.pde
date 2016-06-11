import java.util.Random;
class Board {
  public Tile[][] board;
  private long seed;
  private Random RNG;
  private Tile startTile, endTile;
  
  public Board() { // makes an empty board 
    this((long) ((Math.random() * Long.MAX_VALUE - Long.MAX_VALUE / 2) * 2));
    //seed can be almost any long value: if random gens 0, we get seed is -2^63 + 2, which is long min + 2
    //if random gens just below 1, we get seed is (2^63-2 - (2^62 - 1)) * 2 which is (2^62 - 1) * 2 which is long max - 1
    //so seed can be all but 4 long values
  }

  public long getSeed() { return seed; }

  public Board(long s) { // seeds RNG
    board = new Tile[BOARD_SIZE][BOARD_SIZE];
    for (int r = 0; r < BOARD_SIZE; r++) {
      for (int c = 0; c < BOARD_SIZE; c++) {
        board[r][c] = new Tile(r, c);
      }
    }
    seed = s;
    RNG = new Random(seed);
  }
  
  public Board(Board other) { // copy constructor for board storage
    seed = other.seed;
    RNG = new Random(seed); 
    startTile = new Tile(other.startTile);
    endTile = new Tile(other.endTile);
    board = new Tile[other.board.length][other.board[0].length];
    for(int x = 0; x < board.length; x++) {
      for(int y = 0; y < board[0].length; y++) {
        board[x][y] = new Tile(other.board[x][y]);
      }
    }
  }
  
  public Tile getStart() {
    return startTile;
    
  }
  public Tile getEnd() {
    return endTile;
  }
  
  public int tilesAlive() { //replace old system with an actual counting method, bc other one barely worked
    int num = 0;
    for(int r = 0; r < board.length; r++) {
      for(int c = 0; c < board[0].length; c++) {
        if(board[r][c].isActivated()) num++;
      }
    }
    return num;
  }
    
  
  public void createBoard() {
    int r = (int)(RNG.nextFloat() * board.length);
    int c = (int)(RNG.nextFloat() * board[0].length);
    board[r][c] = new Tile(Type.START, r, c);
    startTile = board[r][c];
    int tilesmade = 0;
    
    while (tilesmade < (BOARD_SIZE * BOARD_SIZE / 2)) { // for now, fill half the board 
      
      int random = (int)(RNG.nextFloat()*4);
      try {
        if ((random == 0) && !board[r+1][c].isActivated()) {
          board[r+1][c].setActive(true);
          r++;
        }
        else if ((random == 1) && !board[r][c+1].isActivated()) {
          board[r][c+1].setActive(true);
          c++;
        }
        else if ((random == 2) && !board[r-1][c].isActivated()) {
          board[r-1][c].setActive(true);
          r--;
        }
        else if ((random == 3) && !board[r][c-1].isActivated()) {
          board[r][c-1].setActive(true);
          c--;
        }
      }
      catch (IndexOutOfBoundsException e) { // occurs if we go outside board, just stops
      }
      tilesmade++;
    }
    //at the end, x,y will be the last tile, make it an end tile
    board[r][c] = new Tile(Type.END, r, c);
    endTile = board[r][c];
  }

  public void draw() {
    fill(0);
    for(int x = 0; x < BOARD_SIZE; x++) {
      for(int y = 0; y < BOARD_SIZE; y++) {
        board[x][y].draw(x,y);
      }
    }
    
  }
}

public Board generateBoard() {
    Board board = new Board();
    board.createBoard();
    return board;
}