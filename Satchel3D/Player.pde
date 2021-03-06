class Player {
  private Board layout;
  private Board gameboard;
  private Tile curr;
  private int level;
  private int score;
  private int multiplier;
  private long start;
  private long end;
  public Player() { // nothing, for setup
    layout = null;
    gameboard = null;
    curr = null;
    level = 1;
    score = 0;
  }
  public Player(Board b) { // players board
    this();
    gameboard = new Board(b);
    layout = new Board(b);
    curr = gameboard.getStart();
    multiplier = gameboard.tilesAlive();
    start = System.currentTimeMillis();
  }

  public Board getBoard() { 
    return gameboard;
  }  
  public int getLevel() { 
    return level;
  }
  public int getScore() {
    return score;
  }

  public void die() {
    gameboard = new Board(layout);
    curr = gameboard.getStart();
    score = score - 5;
  }
  public void win() {
    end = System.currentTimeMillis();
    int timebonus = 60 - (int)((end-start)/1000);
    if (timebonus>0){
      score = score + (multiplier*3) + timebonus;
    }
    else{
      score = score + (multiplier*3);
    }
    newBoard();
    level++;
  }
  public void newBoard() {
    gameboard = generateBoard();
    layout = new Board(gameboard);
    curr = gameboard.getStart();
    multiplier = gameboard.tilesAlive();
    start = System.currentTimeMillis();
  }
  public void end() { // used when end tile is hit. If end is last tile, you win, otherwise you die
    if (gameboard.tilesAlive() <= 1) { // if you are standing on the last tile, there will be 1 tile left
      win();
    } else {
      die();
    }
  }

  public Tile getCurrent() { 
    return curr;
  }
  public void changePos (int x, int y, int z) {
    gameboard.board[curr.getX()][curr.getY()][curr.getZ()].setActive(false);
    curr = gameboard.board[curr.getX() + x][curr.getY() + y][curr.getZ() + z];
  }
  public boolean isEnd(int x, int y, int z) {
    return gameboard.board[curr.getX() + x][curr.getY() + y][curr.getZ() + z].equals(gameboard.endTile);
  }
  public boolean isActive(int x, int y, int z) {
    return gameboard.board[curr.getX() + x][curr.getY() + y][curr.getZ() + z].isActivated();
  }
  public boolean inBounds (int x, int y, int z) {
    return ((curr.getX() + x) >= 0) && ((curr.getX() + x) < gameboard.board.length) 
        && ((curr.getY() + y) >= 0) && ((curr.getY() + y) < gameboard.board[0].length)
        && ((curr.getZ() + z) >= 0) && ((curr.getZ() + z) < gameboard.board[0][0].length);
  }
  public void move(int x, int y, int z) {
    if (inBounds(x, y, z)) { //Tile is In Bounds
      if (isActive(x, y, z)) { //Tile is Active
        if (isEnd(x, y, z)) { //Tile is an Ending tile
          changePos(x, y, z);         
          end();
        }
        //Tile is regular
        else {
          changePos(x, y, z);
        }
      }

      //no Tile where you step
      else {
        die();
      }
    }
    // out of bounds, meaning there's no Tile there
    else {         
      die();
    }
  }


public void draw() {
    int x = curr.getX();
    int y = curr.getY();
    int z = curr.getZ();
    fill(0);
    stroke(0);
    translate(x * TILE_SIZE, y * TILE_SIZE, z * TILE_SIZE);
    box(TILE_SIZE + 3); 
    fill(0);
  }
}