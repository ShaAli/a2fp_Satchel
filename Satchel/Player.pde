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
                gameboard.board[curr.getX()][curr.getY()].setActive(false);

       curr = gameboard.board[curr.getX() + x][curr.getY() + y];
       }
       
  }


  public void draw() {
    if(alive) {
      int x = curr.getX();
      int y = curr.getY();
      fill(0);
      stroke(0);
      translate(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE * 3 / 4);
      box(TILE_SIZE / 2); 
      fill(0);
      
    }
  }
}