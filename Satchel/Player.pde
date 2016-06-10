class Player {
  private boolean alive;
  private Board gameboard;
  private Tile curr;
  
  public Player(Board b) { // players board
    gameboard = b;
   alive = true; // starts alive becomes dead
   curr = gameboard.getStart();
  }
  
  
  public void die() {
    alive = false;
    ALIVE = false;
  }
  
  public void undie() {
    alive = true;
    ALIVE = true;
  }
  
  public boolean isAlive() {
    return alive;
  }
  public void finish()  {
      if (board.numAlive() <= 1) {
          COMPLETE = true;
          die();
      }
      else {
        die();
      }
      
  }
  
  public void changePos (int x, int y) {
        gameboard.board[curr.getX()][curr.getY()].setActive(false);
        curr = gameboard.board[curr.getX() + x][curr.getY() + y];
        gameboard.killTile();

  }
  public boolean isEnd(int x , int y) {
    return gameboard.board[curr.getX() + x][curr.getY() + y].equals(gameboard.endTile);
  }
   public boolean isActive(int x , int y) {
    return gameboard.board[curr.getX() + x][curr.getY() + y].isActivated();
  }
  public boolean inBounds (int x, int y) {
    return ((curr.getX() + x) >= 0) && ((curr.getX() + x) < gameboard.board.length) && ((curr.getY() + y) < gameboard.board[0].length)  && ((curr.getY() + y) >= 0);
  }
  public void move(int x, int y) {
      //Tile is In Bounds
       if (inBounds(x,y)) {
         //Tile is Active
         if (isActive(x,y)) {
               //Tile is an Ending tile;
                if (isEnd(x,y)) {
                    changePos(x,y);         
                    finish();
                }
                //Tile is regular
                else {
                  changePos(x,y);
                 }
         }
         
        //Tile is inActive
       else {
         die();
       }
       }
       //Tile is out of bounds
       else {
         
         die();
         
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