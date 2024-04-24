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
    pal = new Palette(this.sourceImage, this.tileColors, this.bitsPerColor);
    colors = pal.generatePalette();

    // create a new tilemap
    TileMap tm = new TileMap(sourceImage.width, sourceImage.height, this.tileSize);

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

        index++;
      }
    }
    // quantize the input image according to the palette
    quantizedImage = pal.quantizeImage(img, colors);

    // create tiles from the quantized image;
    index = 0;
    for (int y = 0; y < quantizedImage.height; y += tileSize) {
      for (int x = 0; x < quantizedImage.width; x += tileSize) {
        Tile tile = new Tile();

        tile.rgba = quantizedImage.get(x, y, tileSize, tileSize);

        tile.paletteIndices = pal.paletteIndices(tile.rgba);

        tile.id = index;

        tile.x = x;
        tile.y = y;

        tile.width = tile.rgba.width;
        tile.height = tile.rgba.height;

        tiles.add(tile);

        index++;
      }
    }
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
    
    println(spriteTiles.size());
    
    return spriteTiles;
  }

  public void draw() {

    int index = 0;
    int i = 0;
    int spacing = 1;
    for (int y = 0; y < this.height; y += tileSize) {
      int j = 0;
      for (int x = 0; x < this.width; x += tileSize) {

        Tile t = this.tiles.get(index);
        image(t.rgba, x+j*spacing, y+i*spacing);
        j++;
        index++;
      }
      i++;
    }
  }
}
