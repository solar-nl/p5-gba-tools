class Color {

  public int r;
  public int g;
  public int b;
  public int a;
  
  public PImage tile;

  public  Color(int c) {
    this.a = (c >> 24) & 0xFF;
    this.r = (c >> 16) & 0xFF;
    this.g = (c >> 8) & 0xFF;
    this.b = c & 0xFF;
  }

  public Color (int r, int g, int b, int a) {
    this.a = a;
    this.r = r;
    this.g = g;
    this.b = b;
    
    this.tile = colorTile(8);
    
  }
  public Color(int r, int g, int b) {
    this(r, g, b, 255);
  }

  public Color (int[] rgb) {
    this(rgb[0], rgb[1], rgb[2], 255);
  }

  public Color subtract(Color c) {
    int r = this.r - c.r;
    int g = this.g - c.g;
    int b = this.b - c.b;
    int a = this.a - c.a;

    return new Color(r, g, b, a);
  }

  public int squaredDistance(Color b) {

    int dr = b.r - this.r;
    int dg = b.g - this.g;
    int db = b.b - this.b;

    return (dr*dr)+(dg*dg)+(db*db);
  }
  boolean equals(Color other) {
    return this.r == other.r && this.g == other.g && this.b == other.b && this.a == other.a;
  }

  public PImage colorTile(int tileSize) {
    PImage tile = createImage(tileSize, tileSize, RGB);

    color c = color(this.r,this.g,this.b);
    
    tile.loadPixels();
    
    for (int i = 0; i<tileSize; i++) {
      for (int j=0; j<tileSize; j++) {
        tile.pixels[j*tileSize+i] = c;
      }
    }
    
    tile.updatePixels();
    return tile;
  }

  public String toString() {
    return "Color: [R: "+this.r+", G: "+this.g+", B:"+ this.b+", A:"+this.a+"]";
  }
}

class ColorQuantizer {

  private final int bitsPerChannel;

  public ColorQuantizer(int bitsPerChannel) {
    this.bitsPerChannel = bitsPerChannel;
  }

  public int quantizeColor(int r, int g, int b) {
    int rQuant = quantizeComponent(r);
    int gQuant = quantizeComponent(g);
    int bQuant = quantizeComponent(b);

    return (rQuant << (2 * bitsPerChannel)) | (gQuant << bitsPerChannel) | bQuant;
  }

  public Color deQuantizeColor(int quantizedColor) {
    int r = dequantizeComponent((quantizedColor >> (2 * bitsPerChannel)) & ((1 << bitsPerChannel) - 1));
    int g = dequantizeComponent((quantizedColor >> bitsPerChannel) & ((1 << bitsPerChannel) - 1));
    int b = dequantizeComponent(quantizedColor & ((1 << bitsPerChannel) - 1));

    return new Color(r,g,b);//int[]{r, g, b};
  }
  private int quantizeComponent(int c) {
    int maxVal = (1 << bitsPerChannel) - 1;
    return Math.round(c * maxVal / 255.0f);
  }

  private int dequantizeComponent(int c) {
    int maxVal = (1 << bitsPerChannel) - 1;
    return Math.round(c * 255.0f / maxVal);
  }
}
