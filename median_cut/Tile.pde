class Tile {
  int id;

  public PImage rgba;
  public int[][] paletteIndices;

  public int x;
  public int y;
  public int width;
  public int height;

  public Tile () {
  }

  public Tile (PImage img) {
    this.rgba = img;
  }

  public void draw() {
    image(rgba, this.x, this.y);
  }
}

class TileMap {

  public ArrayList<Tile> tiles;

  public TileMap () {
    this.tiles = new ArrayList<Tile>();
  }
}

class TileSet {
  TileMap tm;
  Palette pal;
  ArrayList<Color> colors;

  PImage sourceImage;
  PImage quantizedImage;
  ArrayList<Tile> tiles;

  int tileColors;
  int tileSize;
  int bitsPerColor;

  int width;
  int height;

  int columns;
  int rows;

  public TileSet(PImage img, int tileColors, int tileSize, int bpc) {
    this.sourceImage = img;
    this.tileColors = tileColors;
    this.tileSize = tileSize;
    this.bitsPerColor = bpc;

    this.width = img.width;
    this.height = img.height;

    this.columns = this.width / tileSize;
    this.rows = this.height / tileSize;

    // create a new palette based on the input image and the number of colors.
    this.pal = new Palette(this.sourceImage, this.tileColors, this.bitsPerColor);
    colors = pal.generatePalette();

    // quantize the input image according to the palette
    quantizedImage = pal.quantizeImage(img, colors);

    // create a new tilemap
    tm = new TileMap();

    tiles = new ArrayList<Tile>();



    int index = 0;
    for (int y = 0; y < sourceImage.height; y += tileSize) {
      for (int x = 0; x < sourceImage.width; x += tileSize) {
        Tile tile = new Tile();
        tile.id = index;
        tile.x = x;
        tile.y = y;
        tile.width = tileSize;
        tile.height = tileSize;

        tm.tiles.add(tile);

        tile.rgba = quantizedImage.get(x, y, tileSize, tileSize);
        tile.paletteIndices = pal.paletteIndices(tile.rgba);

        tiles.add(tile);

        index++;
      }
    }
  }

  private ArrayList<Tile> chopTiles(PImage quantizedImage, TileMap tm, int tileSize) {
    ArrayList<Tile> t = new ArrayList<Tile>();
    
    
    
    return t;
  }

  public ArrayList<Tile> getSpriteTiles(SpriteSize s, int tileIndex) {
    ArrayList<Tile> spriteTiles = new ArrayList<Tile>();

    int startRow = tileIndex / this.columns;
    int startCol = tileIndex % this.columns;

    int tileWidth = s.width/tileSize;
    int tileHeight = s.height/tileSize;

    for (int row = 0; row < tileHeight; row++) {
      for (int col = 0; col < tileWidth; col++) {
        int currentRow = startRow + row;
        int currentCol = startCol + col;

        if (currentCol < columns) { // Check if within the bounds of the tileset width
          int index = currentRow * columns + currentCol;
          Tile tile = tiles.get(index);
          spriteTiles.add(tile);
        }
      }
    }
    return spriteTiles;
  }

  public void draw(int xOrigin, int yOrigin) {

    int index = 0;
    int i = 0;
    int spacing = 1;

    for (int y = 0; y < this.height; y += tileSize) {
      int j = 0;
      for (int x = 0; x < this.width; x += tileSize) {

        int xPos = xOrigin+x+j*spacing;
        int yPos = yOrigin+y+i*spacing;

        Tile t = this.tiles.get(index);
        image(t.rgba, xPos, yPos );
        j++;
        index++;
      }
      i++;
    }
  }
}
