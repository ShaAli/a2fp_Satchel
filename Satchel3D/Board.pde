import java.util.Random;
class Board {
  public Tile[][][]board;
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
  }
  
  public Board(Board other) { // copy constructor for board storage
    seed = other.seed;
    RNG = new Random(seed); 
    startTile = new Tile(other.startTile);
    endTile = new Tile(other.endTile);
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
  public Tile getEnd() {
    return endTile;
  }
  
  public int tilesAlive() { //replace old system with an actual counting method, bc other one barely worked
    int num = 0;
    for(int x = 0; x < board.length; x++) {
      for(int y = 0; y < board[0].length; y++) {
        for(int z = 0; z < board[0][0].length; z++) {
          if(board[x][y][z].isActivated()) num++;
        }
      }
    }
    return num;
  }
  
  public void createBoard() {
    int x = (int)(RNG.nextFloat() * board.length);
    int y = (int)(RNG.nextFloat() * board[0].length);
    int z = (int)(RNG.nextFloat() * board[0][0].length);
    board[x][y][z] = new Tile(Type.START, x, y, z);
    startTile = board[x][y][z];
    int tilesmade = 0;
    
    while (tilesmade < (BOARD_SIZE * BOARD_SIZE / 2)) { // for now, fill half the board 
      
      int random = (int)(RNG.nextFloat()*6);
      try {
        if ((random == 0) && !board[x+1][y][z].isActivated()) {
          board[x+1][y][z].setActive(true);
          x++;
        }
        else if ((random == 1) && !board[x][y+1][z].isActivated()) {
          board[x][y+1][z].setActive(true);
          y++;
        }
        else if ((random == 2) && !board[x][y][z+1].isActivated()) {
          board[x][y][z+1].setActive(true);
          z++;
        }
        else if ((random == 3) && !board[x-1][y][z].isActivated()) {
          board[x-1][y][z].setActive(true);
          x--;
        }
        else if ((random == 4) && !board[x][y-1][z].isActivated()) {
          board[x][y-1][z].setActive(true);
          y--;
        }
        else if ((random == 5) && !board[x][y][z-1].isActivated()) {
          board[x][y][z-1].setActive(true);
          z--;
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
    //draw axes
    //ortho();
    textFont(font, TILE_SIZE);
    strokeWeight(TILE_SIZE / 5);
    stroke(255,0,0);
    line(-TILE_SIZE * 3, -TILE_SIZE, -TILE_SIZE, TILE_SIZE, -TILE_SIZE, -TILE_SIZE); //top is D
    rotateAroundPoint(TILE_SIZE, -TILE_SIZE, -TILE_SIZE, 0, 0, 0);
    text("D", 0, TILE_SIZE / 4, 0);
    popMatrix();
    rotateAroundPoint(-TILE_SIZE * 3, -TILE_SIZE, -TILE_SIZE, 0, 0, 0);
    text("A", -TILE_SIZE + 30, TILE_SIZE / 4, 0);
    popMatrix();
    stroke(0,255,0);
    line(-TILE_SIZE, -TILE_SIZE * 3, -TILE_SIZE, -TILE_SIZE, TILE_SIZE, -TILE_SIZE); //top is S
    rotateAroundPoint(-TILE_SIZE, TILE_SIZE, -TILE_SIZE, 0, 0, PI / 2);
    text("S", 0, TILE_SIZE / 4, 0);
    popMatrix();
    rotateAroundPoint(-TILE_SIZE, -TILE_SIZE * 3, -TILE_SIZE, 0, 0, PI / 2);
    text("W", -TILE_SIZE, TILE_SIZE / 4, 0);
    popMatrix();
    stroke(0,0,255);
    line(-TILE_SIZE, -TILE_SIZE, -TILE_SIZE * 3, -TILE_SIZE, -TILE_SIZE, TILE_SIZE); //top is Q
    rotateAroundPoint(-TILE_SIZE, -TILE_SIZE, TILE_SIZE, -PI / 2, -PI / 2, 0);
    text("Q", -TILE_SIZE / 4 - 10, -10, 0);
    popMatrix();
    rotateAroundPoint(-TILE_SIZE, -TILE_SIZE, -TILE_SIZE * 3, PI, -PI / 2, 0);
    text("E", TILE_SIZE / 4 - 10, 40, 0);
    popMatrix();
    strokeWeight(TILE_SIZE / 12);
    textFont(font);
    //perspective();

  }
}

public Board generateBoard() {
    Board board = new Board();
    board.createBoard();
    return board;
}