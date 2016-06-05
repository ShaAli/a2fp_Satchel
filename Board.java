public class Board{
    private Tile[][] board = new Tile[5][5];
    
    public Board(int size){
   	board = new Tile[size][size];
	for(int r = 0; r<size; r++){
	    for (int c = 0; c<size; c++){
		board[r][c] = new Tile();
	    }
	}
    }

    
    public void createBoard(){
	int length = board.length;
	int x = (int)(Math.random() * length);
	int y = (int)(Math.random() * length);
	board[x][y] = new Tile();
	board[x][y].activateTile();
	int tilesmade = 1;
	while (tilesmade < (length*length)){
	    int random = (int)(Math.random()*4);
	    try {
		if ((random == 0) && !board[x+1][y].isActivated()){
		    board[x+1][y].activateTile();
		    x++;
		}
		if ((random == 1) && !board[x][y+1].isActivated()){
		    board[x][y+1].activateTile();
		    y++;
		}
		if ((random == 2) && !board[x-1][y].isActivated()){
		    board[x-1][y].activateTile();
		    x--;
		}
		if ((random == 3) && !board[x][y-1].isActivated()){
		    board[x][y-1].activateTile();
		    y--;
		}
	    }
	    catch (IndexOutOfBoundsException e) {}
	    tilesmade++;
	}
    }

    public String toString(){
	String ret = "";
	for(Tile[] tarr: board){
	    for(Tile t: tarr){
		ret= ret + t + " ";
	    }
	    ret += "\n";
	}
	return ret;
    }

    public static void main(String[] args){	
	Board level = new Board(20);
	level.createBoard();	
	System.out.println(level);
    }
	
}
