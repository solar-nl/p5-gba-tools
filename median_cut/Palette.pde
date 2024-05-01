class Palette {
  private ArrayList<RGBCube> rgbCubes;
  private ArrayList<Color> colors;

  int[] paletteMap;

  private int numColors;
  private int bitsPerChannel;

  private ColorQuantizer cq;

  public Palette(PImage img, int numColors, int bitsPerChannel) {

    this.rgbCubes = new ArrayList<RGBCube>();
    this.colors = new ArrayList<Color>();
    this.numColors = numColors;
    this.bitsPerChannel = bitsPerChannel;
    this.cq = new ColorQuantizer(this.bitsPerChannel);

    img.loadPixels();

    HashSet<Integer> uniqueColors = new HashSet<>(img.pixels.length);
    for (int p : img.pixels) {
      uniqueColors.add(p);
    }

    RGBCube rgbCube = new RGBCube();

    for (int p : uniqueColors) {
      rgbCube.colors.add(new Color(p));
    }
    rgbCubes.add(rgbCube);

    this.colors = generatePalette();
  }

  public Palette(PImage img) {
    this(img, 256, 8);
  }

  public Palette(PImage img, int numColors) {
    this(img, numColors, 8);
  }
  // generate a palette using the median cut algorithm
  private ArrayList<Color> generatePalette() {
    List<RGBCube> tempCubes = new ArrayList<>();
    while (rgbCubes.size() < this.numColors) {
      for (RGBCube rgbCube : rgbCubes) {
        Color ranges = rgbCube.calculateDimensionRanges();
        int longestRange = rgbCube.findLongestDimension(ranges);
        ArrayList<Color> sortedColors = rgbCube.sortByChannel(longestRange);
        ArrayList<ArrayList> splitColorsList = rgbCube.splitColorList(sortedColors);
        for (ArrayList<Color> cl : splitColorsList) {
          tempCubes.add(new RGBCube(cl));
        }
      }
      rgbCubes.clear();
      rgbCubes.addAll(tempCubes);
      tempCubes.clear();
    }
    for (RGBCube rgbCube : rgbCubes) {
      Color averageColor = rgbCube.averageColor();

      int quantizedColor = cq.quantizeColor(averageColor.r, averageColor.g, averageColor.b);
      Color deQuantizedColor = cq.deQuantizeColor(quantizedColor);

      colors.add(deQuantizedColor);
    }
    return colors;
  }

  // Find the index of a color in the palette
  public int index(Color c) {
    for (int i = 0; i < colors.size(); i++) {
      if (colors.get(i).equals(c)) {
        return i;
      }
    }
    return -1; // Return -1 if color is not found
  }
  // create a paletized representation of the quantized Image
  public int[][] paletteIndices(PImage quantizedImage) {
    int[][] paletteIndices = new int[quantizedImage.width][quantizedImage.height];

    for (int x = 0; x < quantizedImage.width; x++) {
      for (int y = 0; y < quantizedImage.height; y++) {
        int index = x + y * quantizedImage.width;
        int pixelColor = quantizedImage.pixels[index];
        Color currentColor = new Color((pixelColor >> 16) & 0xFF, (pixelColor >> 8) & 0xFF, pixelColor & 0xFF, (pixelColor >> 24) & 0xFF);
        int paletteIndex = index(currentColor);
        paletteIndices[x][y] = paletteIndex;
      }
    }
    return paletteIndices;
  }



  PImage quantizeImage(PImage img, ArrayList<Color> colors) {
    img.loadPixels();
    for (int i = 0; i<img.pixels.length; i++) {

      int pixelColor = img.pixels[i];
      Color pColor = new Color(pixelColor);
      Color closestColor = findClosestColor(pColor, colors);
      img.pixels[i] = color(closestColor.r, closestColor.g, closestColor.b);
    }
    img.updatePixels();
    return img;
  }

  Color findClosestColor(Color c, ArrayList<Color> colors) {
    int minDistance = Integer.MAX_VALUE;
    Color closestColor = new Color (0, 0, 0);

    for (Color palColor : colors) {
      int dist = c.squaredDistance(palColor);
      if (dist < minDistance) {
        minDistance = dist;
        closestColor = palColor;
      }
    }

    return closestColor;
  }

  void debugImage(String filename, PImage image, ArrayList<Color>colors) {
    image.loadPixels();
    for (int i = 0; i<image.pixels.length; i++) {

      int pixelColor = image.pixels[i];
      Color pColor = new Color(pixelColor);
      Color closestColor = this.findClosestColor(pColor, colors);
      image.pixels[i] = color(closestColor.r, closestColor.g, closestColor.b);
    }
    image.updatePixels();
    image.save(filename);
  }

  public void draw(int xOrigin, int yOrigin, int tileSize, int spacing) {
  }

  void debugPaletteImage(ArrayList<Color> colors, String filename) {
    PImage debug = createImage(256, 256, RGB);
    debug.loadPixels();
    int index = 0;
    for (int y = 0; y < 16; y++) {
      for (int x = 0; x < 16; x++) {
        Color c;

        if (index < colors.size()) {
          c = colors.get(index);
        } else {
          c = new Color(0, 0, 0, 255);
        }
        color cc = color(c.r, c.g, c.b, c.a);

        for (int dy = 0; dy < 16; dy++) { // Fill a 16x16 pixel block
          for (int dx = 0; dx < 16; dx++) {
            int px = x * 16 + dx;
            int py = y * 16 + dy;
            debug.pixels[py * 256 + px] = cc;
          }
        }
        index++;
      }
    }

    debug.updatePixels();
    debug.save(filename);
  }
}

class PaletteView {

  PGraphics g;

  int width;
  int height;

  int rows;
  int cols;

  int tileSize;
  int spacing;
  
  int x;
  int y;

  Palette pal;
  
  String title;

  public PaletteView(int x, int y, Palette pal, int tileSize, int spacing) {

    this.x = x;
    this.y = y;
    
    // determine the width and height based on the number of colors in the palette, the tilesize and the spacing.
    int numColors = pal.numColors;
    rows = (int) sqrt(numColors);
    cols = (int) sqrt(numColors);

    this.tileSize = tileSize;
    this.spacing = spacing;

    this.width = (cols*tileSize)+(spacing*(cols-1));
    this.height = (rows*tileSize)+(spacing*(rows-1));

    this.pal = pal;

    g = createGraphics(this.width, this.height);
  }
  
  public void setup() {
    println("paletteViewSetup");
  }

  public void draw() {
    g.beginDraw();

    int index = 0;
    for (int row = 0; row < this.rows; row++) {
      for (int col = 0; col < this.cols; col++) {
        Color c;

        if (index < pal.colors.size()) {
          c = pal.colors.get(index);
        } else {
          c = new Color(0, 0, 0, 255);
        }

        int xPos = col*this.tileSize + col*this.spacing;
        int yPos = row*this.tileSize + row*this.spacing;
        g.image(c.tile, xPos, yPos);
        index++;
      }
    }
    g.endDraw();

    image(g, this.x, this.y);
  }
}

class PaletteWriter {

  private PrintWriter w;
  private ArrayList<Color> colors;
  private ColorQuantizer cq;

  private int bitsPerChannel;

  String name;

  public PaletteWriter(String fn, String paletteName, ArrayList<Color> colors, int bitsPerChannel) {
    this.w = createWriter(fn);
    this.colors = colors;
    this.name = paletteName;
    this.bitsPerChannel = bitsPerChannel;
    this.cq = new ColorQuantizer(this.bitsPerChannel);
  }

  public void dump() {
    // Include statements and array definitions
    w.println("#include \"memory.h\"");
    w.println("unsigned short EWRAM_DATA generated_palette[256];");

    // Start of array
    w.println("const unsigned short "+name+"["+colors.size()+"] = {");

    for (int i = 0; i < colors.size(); i++) {

      Color c = colors.get(i);

      int quantizedColor = cq.quantizeColor(c.b, c.g, c.r); // blue and red are reversed because the GBA likes it that way.

      w.print(String.format("0x%04X", quantizedColor)); // Format as hexadecimal

      // Handle commas and line breaks
      if (i < colors.size() - 1) w.print(", ");
      if ((i + 1) % 16 == 0) w.println();
    }

    // End of array
    w.println("};");
    w.flush(); // Make sure to flush the writer to ensure all data is written
    w.close(); // Close the writer to free resources
  }
}
