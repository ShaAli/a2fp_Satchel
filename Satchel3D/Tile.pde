public static enum Type { NORMAL, START, END };

class Tile {
  private boolean inPlay;
  private int tileColor;
  private int xCor;
  private int yCor;
  private int zCor;
  
  public Tile(int x, int y, int z) { // used when making tile array
    this(Type.NORMAL, x, y, z); // normal type 
    inPlay = false; //default tiles start inactive before createBoard
  }
  
  public Tile(Tile other) { // copy constructor
    inPlay = other.inPlay;
    tileColor = other.tileColor;
    xCor = other.xCor;
    yCor = other.yCor;
  }
  
  public Tile(Type t, int x, int y, int z) {
    xCor = x;
    yCor = y;
    zCor = z;
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
  
  public int getZ() {
     return zCor; 
  }
  
  public boolean isActivated() {
    return inPlay;
  }   

  public boolean equals(Object o) {
    if(o instanceof Tile) {
      Tile other = (Tile)o;
      return other.xCor == xCor && other.yCor == yCor && other.zCor == zCor;
    }
    return false;
  }

  public void draw(int x, int y, int z) {
    xCor = x;
    yCor = y;
    zCor = z;
    if(inPlay) {
      fill(tileColor);
      stroke(0);
      translate(x * TILE_SIZE, y * TILE_SIZE, z * TILE_SIZE);
      box(TILE_SIZE); 
      translate(-x * TILE_SIZE, -y * TILE_SIZE, -z * TILE_SIZE);
      fill(0);
      if(DEBUG) {
        if(SHOW_COORDS) text(x + ", " + y + ", " + z, x * TILE_SIZE - TILE_SIZE / 2, y * TILE_SIZE + TILE_SIZE / 2, z * TILE_SIZE - TILE_SIZE / 2);
      }
    }
  }
}