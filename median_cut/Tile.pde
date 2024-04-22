class Tile {
  int id;

  public PImage rgba;
  public int[][] paletteIndices;

  public int x;
  public int y;
  public int width;
  public int height;

  private int numColors;
  private int bitsPerChannel;

  
  public Tile () {
  
  }

  public Tile (PImage img) {
    this.rgba = img;
  }
  
  public void draw() {
    image(rgba,this.x,this.y);
  }
}
