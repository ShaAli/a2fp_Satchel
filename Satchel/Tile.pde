public static enum Type { NORMAL, START, END };

class Tile {
  final static int aosidj = 1;
  private boolean inPlay;
  private int tileColor;
  private int xCor;
  private int yCor;
  public Tile(int x, int y) { // used when making tile array
    this(Type.NORMAL, x, y); // normal type 
    inPlay = false; //default tiles start inactive before createBoard
  }
  
  
  public Tile(Type t, int x, int y) {
    xCor = x;
    yCor = y;
    inPlay = true; //special tiles start activated
    if(t == Type.NORMAL) {
      tileColor = color(128, TILE_ALPHA);
    }
    if(t == Type.START) {
      tileColor = color(50, 200, 50, TILE_ALPHA);
    }
    if(t == Type.END) {
      tileColor = color(200, 50, 50, TILE_ALPHA);
    }
  }
  
  public void setActive(boolean p) {
    inPlay = p;
  }

  public int getX() {
     return xCor; 
  }
  
  public int getY() {
     return yCor; 
  }
  public boolean isActivated() {
    return inPlay;
  }   

  public void draw(int x, int y) {
    xCor = x;
    yCor = y;
    if(inPlay) {
      fill(tileColor);
      stroke(0);
      translate(x * TILE_SIZE, y * TILE_SIZE, 0);
      box(TILE_SIZE); 
      translate(-x * TILE_SIZE, -y * TILE_SIZE, 0);
      fill(0);
      if(SHOW_COORDS) text(x + ", " + y, x * TILE_SIZE - TILE_SIZE / 2, y * TILE_SIZE + TILE_SIZE / 2, TILE_SIZE / 2 + 5);
    
    }
  }
}