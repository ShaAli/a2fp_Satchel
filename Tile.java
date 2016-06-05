public class Tile{
    private boolean inPlay;
    private boolean steppedOn;
    private Tile teleport;
    
    public Tile(){
	inPlay = false;
	steppedOn = false;
    }
    public void activateTile(){
	inPlay = true;
    }
    
    public boolean isActivated(){
	return inPlay;

    }   

    public String toString(){
	if (inPlay) return "X";
	else return "O";
    }
}
