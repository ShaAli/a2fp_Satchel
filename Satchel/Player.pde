class Player {
  // enum for tile type
  //public static final int NORMAL = -1;
  //public static final int START = 0;
  //public static final int END = 1;
  
  
  
  private boolean alive;
  private Board gameboard;
  private Tile curr;
  
  public Player(Board b) { // used when making tile array
    gameboard = b;
   alive = true; //default tiles start inactive before createBoard
   curr = gameboard.getStart();
  }
  
  
  public void die() {
    alive = false;
  }

  public boolean isAlive() {
    return alive;
  }   
  
  public void move(int x, int y) {
       if (gameboard.board[curr.getX() + x][curr.getY() + y].isActivated()) {  
       curr = gameboard.board[curr.getX() + x][curr.getY() + y];
       }
  }

//
  public void draw() {
    if(alive) {
      translate(BOARD_SIZE * TILE_SIZE / 4, BOARD_SIZE * TILE_SIZE / 2 - TILE_SIZE * 6, -TILE_SIZE * 3);
      rotateX(0.3);
      scale(0.5);
      int x = curr.getX();
      int y = curr.getY();
      fill(0);
      stroke(0);
      translate(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE);
      box(TILE_SIZE / 2); 
      translate(-x * TILE_SIZE, -y * TILE_SIZE, TILE_SIZE);
      fill(0);
      text(x + ", " + y, x * TILE_SIZE - TILE_SIZE / 2, y * TILE_SIZE + TILE_SIZE / 2, TILE_SIZE / 2 + 5);
    }
  }
}