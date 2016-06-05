class Tile {
  private boolean inPlay;

  public Tile() { // used when making tile array
    inPlay = false;
  }
  
  public void setActive(boolean p) {
    inPlay = p;
  }

  public boolean isActivated() {
    return inPlay;
  }   

  public void draw(int x, int y) {
    if(inPlay) {
      fill(128);
      stroke(0);
      translate(x * TILE_SIZE, y * TILE_SIZE, 0);
      box(TILE_SIZE);
      translate(-x * TILE_SIZE, -y * TILE_SIZE, 0);
      fill(0);
      text(x + ", " + y, x * TILE_SIZE - TILE_SIZE / 2, y * TILE_SIZE + TILE_SIZE / 2, TILE_SIZE / 2 + 5);
    }
  }
}