class Tile {
  // enum for tile type
  public static final int NORMAL = -1;
  public static final int START = 0;
  public static final int END = 1;
  
  private boolean inPlay;
  private int tileColor;
  private int type;
  public Tile() { // used when making tile array
    this(NORMAL); // normal type 
    inPlay = false; //default tiles start inactive before createBoard
  }
  
  public Tile(int t) {
    type = t;
    inPlay = true; //special tiles start activated
    if(t == NORMAL) {
      tileColor = color(128);
    }
    if(t == START) {
      tileColor = color(50, 200, 50);
    }
    if(t == END) {
      tileColor = color(200, 50, 50);
    }
  }
  
  public void setActive(boolean p) {
    inPlay = p;
  }

  public boolean isActivated() {
    return inPlay;
  }   

  public void draw(int x, int y) {
    if(inPlay) {
      fill(tileColor);
      stroke(0);
      translate(x * TILE_SIZE, y * TILE_SIZE, 0);
      box(TILE_SIZE);
      translate(-x * TILE_SIZE, -y * TILE_SIZE, 0);
      fill(0);
      text(x + ", " + y, x * TILE_SIZE - TILE_SIZE / 2, y * TILE_SIZE + TILE_SIZE / 2, TILE_SIZE / 2 + 5);
    }
  }
}