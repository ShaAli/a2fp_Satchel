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
  
  public void changePos (int x, int y, int z) {
        gameboard.board[curr.getX()][curr.getY()][curr.getX()].setActive(false);
        curr = gameboard.board[curr.getX() + x][curr.getY() + y][curr.getZ() + z];
        gameboard.killTile();

  }
  public boolean isEnd(int x , int y, int z) {
    return gameboard.board[curr.getX() + x][curr.getY() + y][curr.getZ() + z].equals(gameboard.endTile);
  }
   public boolean isActive(int x , int y, int z) {
    return gameboard.board[curr.getX() + x][curr.getY() + y][curr.getZ() + z].isActivated();
  }
  public boolean inBounds (int x, int y, int z) {
    return ((curr.getX() + x) >= 0) && ((curr.getX() + x) < gameboard.board.length) && ((curr.getY() + y) < gameboard.board[0].length)  && ((curr.getY() + y) >= 0) && ((curr.getZ() + z) < gameboard.board[0][0].length)  && ((curr.getZ() + z) >= 0);
  }
  public void move(int x, int y, int z) {
      //Tile is In Bounds
       if (inBounds(x,y, z)) {
         //Tile is Active
         if (isActive(x,y, z)) {
               //Tile is an Ending tile;
                if (isEnd(x,y, z)) {
                    changePos(x,y, z);         
                    finish();
                }
                //Tile is regular
                else {
                  changePos(x,y, z);
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
      int z = curr.getZ();
      fill(0);
      stroke(0);
      translate(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE * 3/4);
      box(TILE_SIZE / 2); 
      fill(0);
      
    }
  }
}