class TileMap {
  
  public ArrayList<Tile> tiles;
  private int width;
  private int height;
  private int tileSize;
  
  
  public TileMap (int width, int height, int tileSize) {
    this.tiles = new ArrayList<Tile>();
    this.width = width;
    this.height = height;
    this.tileSize = tileSize;
  }
}
