import java.util.Random;
class Board {
  public Tile[][][]board;
  private long seed;
  private Random RNG;
  private Tile startTile, endTile;
  private int tilesAlive;
  
  public Board() { // makes an empty board 
    this((long) ((Math.random() * Long.MAX_VALUE - Long.MAX_VALUE / 2) * 2));
    //seed can be almost any long value: if random gens 0, we get seed is -2^63 + 2, which is long min + 2
    //if random gens just below 1, we get seed is (2^63-2 - (2^62 - 1)) * 2 which is (2^62 - 1) * 2 which is long max - 1
    //so seed can be all but 4 long values
  }

  public long getSeed() { return seed; }

  public Board(long s) { // seeds RNG
    board = new Tile[BOARD_SIZE][BOARD_SIZE][BOARD_SIZE];
    for (int x = 0; x < BOARD_SIZE; x++) {
      for (int y = 0; y < BOARD_SIZE; y++) {
          for (int z = 0; z < BOARD_SIZE; z++) {
              board[x][y][z] = new Tile(x, y, z);  
          }  
       }
    }
    seed = s;
    RNG = new Random(seed);
    tilesAlive = 0;
  }
  
  public Board(Board other) { // copy constructor for board storage
    seed = other.seed;
    RNG = new Random(seed); 
    startTile = new Tile(other.startTile);
    endTile = new Tile(other.endTile);
    tilesAlive = other.tilesAlive;
    board = new Tile[other.board.length][other.board[0].length][other.board[0][0].length];
    for(int x = 0; x < board.length; x++) {
      for(int y = 0; y < board[0].length; y++) {
          for(int z = 0; z < board[0][0].length; z++){
              board[x][y][z] = new Tile(other.board[x][y][z]);
          }
       }
    }
  }
  
  public Tile getStart() {
    return startTile;
    
  }
  public int numAlive() {return tilesAlive;}
  public void killTile() { tilesAlive--; }
  public void createBoard() {
    int x = (int)(RNG.nextFloat() * BOARD_SIZE);
    int y = (int)(RNG.nextFloat() * BOARD_SIZE);
    int z = (int)(RNG.nextFloat() * BOARD_SIZE);
    board[x][y][z] = new Tile(Type.START, x, y, z);
    startTile = board[x][y][z];
    int tilesmade = 0;
    
    while (tilesmade < (BOARD_SIZE * BOARD_SIZE / 2)) { // for now, fill half the board 
      
      int random = (int)(RNG.nextFloat()*6);
      try {
        if ((random == 0) && !board[x+1][y][z].isActivated()) {
          board[x+1][y][z].setActive(true);
          x++;
          tilesAlive++;
          board[x][y][z].setNum(tilesAlive);
        }
        else if ((random == 1) && !board[x][y+1][z].isActivated()) {
          board[x][y+1][z].setActive(true);
          y++;
          tilesAlive++;
          board[x][y][z].setNum(tilesAlive);
        }
        else if ((random == 2) && !board[x][y][z+1].isActivated()) {
          board[x][y][z+1].setActive(true);
          z++;
          tilesAlive++;
          board[x][y][z].setNum(tilesAlive);
        }
        else if ((random == 3) && !board[x-1][y][z].isActivated()) {
          board[x-1][y][z].setActive(true);
          x--;
          tilesAlive++;
          board[x][y][z].setNum(tilesAlive);
        }
        else if ((random == 4) && !board[x][y-1][z].isActivated()) {
          board[x][y-1][z].setActive(true);
          y--;
          tilesAlive++;
          board[x][y][z].setNum(tilesAlive);
        }
        else if ((random == 5) && !board[x][y][z-1].isActivated()) {
          board[x][y][z-1].setActive(true);
          z--;
          tilesAlive++;
          board[x][y][z].setNum(tilesAlive);
        }
        //tilesAlive++;
        
        
      }
      catch (IndexOutOfBoundsException e) { // occurs if we go outside board, just stops
      }
      tilesmade++;
    }
    //at the end, x,y will be the last tile, make it an end tile
    board[x][y][z] = new Tile(Type.END, x, y, z);
    endTile = board[x][y][z];
  }

  public void draw() {
    fill(0);
    for(int x = 0; x < BOARD_SIZE; x++) {
      for(int y = 0; y < BOARD_SIZE; y++) {
          for(int z = 0; z < BOARD_SIZE; z++){
            board[x][y][z].draw(x,y,z);
          }
      }
    }
  }
}