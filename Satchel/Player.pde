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
  
  public void move(int x, int y) {
       if (((curr.getX() + x) >= 0) && ((curr.getX() + x) < gameboard.board.length) && ((curr.getY() + y) < gameboard.board[0].length)  && ((curr.getY() + y) >= 0)) {
       if (gameboard.board[curr.getX() + x][curr.getY() + y].isActivated()) {
                if (gameboard.board[curr.getX() + x][curr.getY() + y].equals(gameboard.endTile)) {
                                  gameboard.board[curr.getX()][curr.getY()].setActive(false);
                                  finish();

                                  gameboard.killTile();
                                  curr = gameboard.board[curr.getX() + x][curr.getY() + y];
                                  

                }

                gameboard.board[curr.getX()][curr.getY()].setActive(false);
                gameboard.killTile();
                curr = gameboard.board[curr.getX() + x][curr.getY() + y];
       }
       else {
         die();
         
       }
       }
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