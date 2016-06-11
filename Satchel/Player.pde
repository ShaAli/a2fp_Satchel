class Player {
  private Board layout;
  private Board gameboard;
  private Tile curr;
  private int level;

  public Player(Board b) { // players board
    gameboard = new Board(b);
    layout = new Board(b);
    curr = gameboard.getStart();
    level = 1;
  }
  
  public Board getBoard() { return gameboard; }  
  public int getLevel() { return level; }

  public void die() {
    gameboard = new Board(layout);
    curr = gameboard.startTile;
  }
  public void win() {
    newBoard();
    level++;
  }
  public void newBoard() {
    gameboard = generateBoard();
    layout = new Board(gameboard);
    curr = gameboard.startTile;
  }
  public void end() { // used when end tile is hit. If end is last tile, you win, otherwise you die
    print("End called");
    if (gameboard.tilesAlive() <= 1) { // if you are standing on the last tile, there will be 1 tile left
      win();
    }
    else {
      die();
    }
  }

  public Tile getCurrent() { return curr; }
  public void changePos (int x, int y) {
    gameboard.board[curr.getX()][curr.getY()].setActive(false);
    curr = gameboard.board[curr.getX() + x][curr.getY() + y];
  }
  public boolean isEnd(int x, int y) {
    return gameboard.board[curr.getX() + x][curr.getY() + y].equals(gameboard.endTile);
  }
  public boolean isActive(int x, int y) {
    return gameboard.board[curr.getX() + x][curr.getY() + y].isActivated();
  }
  public boolean inBounds (int x, int y) {
    return ((curr.getX() + x) >= 0) && ((curr.getX() + x) < gameboard.board.length) && ((curr.getY() + y) < gameboard.board[0].length)  && ((curr.getY() + y) >= 0);
  }
  public void move(int x, int y) {
    if (inBounds(x, y)) { //Tile is In Bounds
      if (isActive(x, y)) { //Tile is Active
        if (isEnd(x, y)) { //Tile is an Ending tile
          changePos(x, y);         
          end();
        }
        //Tile is regular
        else {
          changePos(x, y);
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
    fill(0);
    stroke(0);
    translate(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE * 3 / 4);
    box(TILE_SIZE / 2); 
    fill(0);
  }
}