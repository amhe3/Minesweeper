
boolean loseShow = false;
import de.bezier.guido.*;
int NUM_ROWS = 20; 
int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(401, 451);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    bombs = new ArrayList <MSButton> ();
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r ++)
    {
        for(int c = 0; c < NUM_COLS; c ++)
        {
            buttons[r][c] = new MSButton(r, c);
        }
    }
    
    setBombs();
}
public void setBombs()
{
    int ranRow = (int) (Math.random()* NUM_ROWS);
    int ranCol = (int) (Math.random()* NUM_COLS);
    for(int bombNum = 1; bombNum <= (int)(Math.random()*10)+40; bombNum++)
    {
        if(!bombs.contains(buttons[ranRow][ranCol]))
        {
            bombs.add(buttons[(int) (Math.random()* NUM_ROWS)][(int) (Math.random()* NUM_COLS)]);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    
    return false;
}
public void displayLosingMessage()
{
    fill(192, 192, 192);
    textSize(50);
    text("You Lose.", 200, 425);
    textSize(12);
}
public void displayWinningMessage()
{
    fill(192, 192, 192);
    textSize(50);
    text("You Win!", 200, 425);
    textSize(12);
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true; 
        if(keyPressed == true && marked == true)
        {
            marked = false;
        }
        else if(keyPressed == true && marked == false)
        {
            marked = true;
        }
        else if(bombs.contains(this))
        {
            loseShow = true;
        }
        else if(this.countBombs(r, c) > 0)
        {
            int num = countBombs(r, c);
            this.setLabel("" + num);
        }
        else
        {
            if(this.isValid(r,c-1)==true && buttons[r][c-1].isClicked() == false) //left
                buttons[r][c-1].mousePressed();
            if(this.isValid(r,c+1)==true && buttons[r][c+1].isClicked() == false) //right
                buttons[r][c+1].mousePressed();
            if(this.isValid(r-1,c)==true && buttons[r-1][c].isClicked() == false) //up
                buttons[r-1][c].mousePressed();
            if(this.isValid(r+1,c)==true && buttons[r+1][c].isClicked() == false) //down
                buttons[r+1][c].mousePressed();
            if(this.isValid(r-1,c-1)==true && buttons[r-1][c-1].isClicked() == false) //left top
                buttons[r-1][c-1].mousePressed();
            if(this.isValid(r-1,c+1)==true && buttons[r-1][c+1].isClicked() == false) //right top
                buttons[r][c+1].mousePressed();
            if(this.isValid(r+1,c-1)==true && buttons[r+1][c-1].isClicked() == false) //left bottom
                buttons[r+1][c-1].mousePressed();
            if(this.isValid(r+1,c+1)==true && buttons[r+1][c+1].isClicked() == false) //right bottom
                buttons[r+1][c+1].mousePressed();

        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);

        if(loseShow == true)
        {
            displayLosingMessage();
        }
        if(isWon() == true)
        {
            displayWinningMessage();
        }
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>-1 && r<20 && c>-1 && c<20)
        {
            return true;
        }
        else 
            return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(this.isValid(row-1, col-1)==true && bombs.contains(buttons[row-1][col-1])) //top left
            numBombs++;
        if(this.isValid(row-1, col)==true && bombs.contains(buttons[row-1][col])) //top
            numBombs++;
        if(this.isValid(row-1, col+1)==true && bombs.contains(buttons[row-1][col+1])) //top right
            numBombs++;
        if(this.isValid(row, col-1)==true && bombs.contains(buttons[row][col-1])) //left
            numBombs++;
        if(this.isValid(row, col+1)==true && bombs.contains(buttons[row][col+1])) //right
            numBombs++;
        if(this.isValid(row+1, col-1)==true && bombs.contains(buttons[row+1][col-1])) //bottom left
            numBombs++;
        if(this.isValid(row+1, col)==true && bombs.contains(buttons[row+1][col])) //bottom
            numBombs++;
        if(this.isValid(row+1, col+1)==true && bombs.contains(buttons[row+1][col+1])) //bottom right
            numBombs++;
        return numBombs;
    }
}



