class Rect {
  
  public int x;
  public int y;

  public int width;
  public int height;


  public Rect(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
/*
  public boolean intersectsPoint(PVector p) {
    int x1 = this.x;
    int y1 = this.y;   
    int x2 = this.x+this.width;
    int y2 = this.y+this.height;

    return (x1 <= (int) p.x <= x2 && y1 <= (int) p.y <= y2); 
    
  }*/

}

class Mouse {

  boolean dragging;
  
  PVector pos;
  PVector startDrag;
  PVector endDrag;

  public Mouse() {

  }

}
